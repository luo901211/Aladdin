//
//  FinanceListVC.m
//  Aladdin
//
//  Created by luo on 2017/4/23.
//  Copyright © 2017年 wenqi. All rights reserved.
//

#import "FinanceListVC.h"
#import "FinanceListViewModel.h"
#import "ALDFinanceModel.h"
#import "FinanceCell.h"
#import "FinanceChapterListVC.h"

@interface FinanceListVC ()

@property (nonatomic, strong) FinanceListViewModel *viewModel;

@end

@implementation FinanceListVC

- (FinanceListViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[FinanceListViewModel alloc] init];
    }
    return _viewModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"财务秘籍";
    self.tableView.tableFooterView = [UIView new];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"FinanceCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"FinanceCell"];
    
    __weak FinanceListVC *weakSelf = self;
    self.tableView.mj_header = [WQChiBaoZiHeader headerWithRefreshingBlock:^{
        [weakSelf loadDataWithType:WQFetchDataTypeRefresh];
    }];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf loadDataWithType:WQFetchDataTypeLoadMore];
    }];
    self.tableView.mj_footer.automaticallyHidden = YES;
    
    [self.tableView.mj_header beginRefreshing];
    
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
    
    [self.viewModel loadDataListWithPageIndex:pageIndex success:^(BOOL noMoreData) {
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
        NSLog(@"%@",error.userInfo);
    }];
    
    
}

#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    ALDFinanceModel *model = self.viewModel.list[indexPath.row];
    return [FinanceCell heightForRow:model];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FinanceCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FinanceCell"];
    ALDFinanceModel *model = self.viewModel.list[indexPath.row];
    cell.model = model;
    return cell;
}

#pragma mark - Table view delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    FinanceChapterListVC *vc = [[FinanceChapterListVC alloc] init];
    ALDFinanceModel *model = self.viewModel.list[indexPath.row];
    vc.ID = model.ID;
    vc.title = model.title;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
