//
//  ServerListViewController.m
//  Aladdin
//
//  Created by luo on 2017/4/16.
//  Copyright © 2017年 wenqi. All rights reserved.
//

#import "ServerListViewController.h"
#import "ServerListViewModel.h"
#import "ALDServerModel.h"
#import "ServerCell.h"
#import "ServerDetailViewController.h"

@interface ServerListViewController ()


@property (nonatomic, strong) ServerListViewModel *viewModel;

@end

@implementation ServerListViewController

- (ServerListViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[ServerListViewModel alloc] init];
    }
    return _viewModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"阿拉丁平台服务";
    
    self.tableView.tableFooterView = [UIView new];
    [self.tableView registerNib:[UINib nibWithNibName:@"ServerCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"ServerCell"];
    
    __weak ServerListViewController *weakSelf = self;
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
        pageIndex = (NSInteger)self.viewModel.serverList.count / API_PAGE_SIZE + 1;
    }
    
    [self.viewModel loadServerListWithPageIndex:pageIndex success:^(BOOL noMoreData) {
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
    ALDServerModel *model = self.viewModel.serverList[indexPath.row];
    return [ServerCell heightForRow:model];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.serverList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ServerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ServerCell"];
    ALDServerModel *model = self.viewModel.serverList[indexPath.row];
    cell.model = model;
    return cell;
}

#pragma mark - Table view delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ServerDetailViewController *vc = [[ServerDetailViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
