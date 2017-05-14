//
//  QuestionListVC.m
//  Aladdin
//
//  Created by luo on 2017/4/25.
//  Copyright © 2017年 wenqi. All rights reserved.
//

#import "QuestionListVC.h"
#import "ALDQuestionModel.h"
#import "QuestionCell.h"
#import "QuestionDetailVC.h"

@interface QuestionListVC ()

@property (nonatomic, strong) QuestionListViewModel *viewModel;

@end

@implementation QuestionListVC

- (QuestionListViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[QuestionListViewModel alloc] init];
    }
    return _viewModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.tableFooterView = [UIView new];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"QuestionCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"QuestionCell"];
    
    __weak QuestionListVC *weakSelf = self;
    self.tableView.mj_header = [WQRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadDataWithType:WQFetchDataTypeRefresh];
    }];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf loadDataWithType:WQFetchDataTypeLoadMore];
    }];
    self.tableView.mj_footer.automaticallyHidden = YES;
    
    [self.tableView.mj_header beginRefreshing];
    
    // 注册通知
    if (self.type == QuestionTypeUser) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginNotificationAction) name:kNotification_Login object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(logoutNotificationAction) name:kNotification_Logout object:nil];
    }
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
    
    [self.viewModel loadDataListWithPageIndex:pageIndex type:self.type success:^(BOOL noMoreData) {
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
    ALDQuestionModel *model = self.viewModel.list[indexPath.row];
    return [QuestionCell heightForRow:model];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QuestionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"QuestionCell"];
    ALDQuestionModel *model = self.viewModel.list[indexPath.row];
    cell.model = model;
    return cell;
}

#pragma mark - Table view delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    QuestionDetailVC *vc = [[QuestionDetailVC alloc] init];
    ALDQuestionModel *model = self.viewModel.list[indexPath.row];
    vc.ID = model.ID;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 通知
- (void)loginNotificationAction {
    [self.tableView.mj_header beginRefreshing];
}
- (void)logoutNotificationAction {
    [self.viewModel.list removeAllObjects];
    [self.tableView reloadData];
}
-(void)dealloc {
    if (self.type == QuestionTypeUser) {
        [[NSNotificationCenter defaultCenter] removeObserver:self];
    }
}

@end
