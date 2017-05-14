//
//  CollectListVC.m
//  Aladdin
//
//  Created by luo on 2017/4/18.
//  Copyright © 2017年 wenqi. All rights reserved.
//

#import "CollectListVC.h"
#import "ALDCollectModel.h"
#import "CollectCell.h"
#import "CollectListViewModel.h"

@interface CollectListVC ()<UIAlertViewDelegate>

@property (nonatomic, strong) CollectListViewModel *viewModel;

@end

@implementation CollectListVC

- (CollectListViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[CollectListViewModel alloc] init];
    }
    return _viewModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.navigationItem.title = @"我的收藏";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"CollectCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"CollectCell"];
    self.tableView.tableFooterView = [UIView new];
    
    __weak CollectListVC *weakSelf = self;
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
        [MBProgressHUD showAutoMessage:error.localizedDescription];
    }];
}

#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    ALDCollectModel *model = self.viewModel.list[indexPath.row];
    return [CollectCell heightForRow:model];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CollectCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CollectCell"];
    ALDCollectModel *model = self.viewModel.list[indexPath.row];
    cell.model = model;
    cell.tapCollectBlock = ^(id obj){
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"确定取消收藏吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alertView.tag = indexPath.row + 100;
        [alertView show];
    };

    return cell;
}

#pragma mark - Table view delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

}
#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        NSInteger modelIndex = alertView.tag - 100;
        ALDCollectModel *model = self.viewModel.list[modelIndex];

        [self.viewModel cancelCollectDataWithID:model.ID success:^(id obj) {
            [self.viewModel.list removeObjectAtIndex:modelIndex];
            [self.tableView deleteRow:modelIndex inSection:0 withRowAnimation:UITableViewRowAnimationAutomatic];
        } failure:^(id obj) {
            [MBProgressHUD showAutoMessage:obj];
        }];
    }
}
@end
