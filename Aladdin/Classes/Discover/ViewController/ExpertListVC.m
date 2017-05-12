//
//  ExpertListVC.m
//  Aladdin
//
//  Created by luo on 2017/4/23.
//  Copyright © 2017年 wenqi. All rights reserved.
//

#import "ExpertListVC.h"
#import "ExpertListViewModel.h"
#import "ALDExpertModel.h"
#import "ExpertCell.h"
#import "ExpertDetailVC.h"

@interface ExpertListVC ()

@property (nonatomic, strong) ExpertListViewModel *viewModel;

@end

@implementation ExpertListVC

- (ExpertListViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[ExpertListViewModel alloc] init];
    }
    return _viewModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.inviteReplyBlock) {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:(UIBarButtonItemStylePlain) target:self action:@selector(dismiss)];
    }
    
    self.tableView.tableFooterView = [UIView new];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ExpertCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"ExpertCell"];
    
    __weak ExpertListVC *weakSelf = self;
    self.tableView.mj_header = [WQChiBaoZiHeader headerWithRefreshingBlock:^{
        [weakSelf loadDataWithType:WQFetchDataTypeRefresh];
    }];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf loadDataWithType:WQFetchDataTypeLoadMore];
    }];
    self.tableView.mj_footer.automaticallyHidden = YES;
    
    [self.tableView.mj_header beginRefreshing];
    
}

- (void)dismiss {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - /************************* 刷新数据 ***************************/

- (void)loadDataWithType:(WQFetchDataType)type
{
    @weakify(self);
    
    NSInteger pageIndex = 1;
    if (type == WQFetchDataTypeLoadMore) {
        pageIndex = (NSInteger)self.viewModel.list.count / API_PAGE_SIZE + 1;
    }
    
    [self.viewModel loadDataListWithLevel:self.level pageIndex:pageIndex success:^(BOOL noMoreData) {
        @strongify(self)
        
        if (noMoreData) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        
        if (type == WQFetchDataTypeRefresh) {
            
            [self.tableView.mj_header endRefreshing];
            
        }else if(type == WQFetchDataTypeLoadMore && !noMoreData){
            
            [self.tableView.mj_footer endRefreshing];
            
        }
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        if (type == WQFetchDataTypeRefresh) {
            [self.tableView.mj_header endRefreshing];
        }else if(type == WQFetchDataTypeLoadMore){
            [self.tableView.mj_footer endRefreshing];
        }
        [MBProgressHUD showAutoMessage:error.localizedDescription];
    }];
    
    
}

#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    ALDExpertModel *model = self.viewModel.list[indexPath.row];
    return [ExpertCell heightForRow:model];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ExpertCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ExpertCell"];
    ALDExpertModel *model = self.viewModel.list[indexPath.row];
    cell.model = model;
    return cell;
}

#pragma mark - Table view delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ALDExpertModel *model = self.viewModel.list[indexPath.row];

    if (self.inviteReplyBlock) {
        // 邀请回答
        self.inviteReplyBlock(@(model.ID));
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
        return;
    }
    
    ExpertDetailVC *vc = [[ExpertDetailVC alloc] init];
    vc.level = self.level;
    vc.ID = model.ID;
    [self.navigationController pushViewController:vc animated:YES];
}
@end
