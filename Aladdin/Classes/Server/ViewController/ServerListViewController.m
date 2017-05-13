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

#import "UserFeatureView.h"
#import "WQPopWindow.h"

@interface ServerListViewController ()


@property (nonatomic, strong) ServerListViewModel *viewModel;

@property (nonatomic, strong) UserFeatureView *userFeatureView;

@end

@implementation ServerListViewController

- (ServerListViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[ServerListViewModel alloc] init];
    }
    return _viewModel;
}

- (UserFeatureView *)userFeatureView {
    if (!_userFeatureView) {
        _userFeatureView = [[UserFeatureView alloc] init];
        _userFeatureView.top = 64 + 5;
        _userFeatureView.right = Main_Screen_Width - 20;
    }
    return _userFeatureView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"阿拉丁平台服务";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"item_user_center"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:(UIBarButtonItemStylePlain) target:self action:@selector(showUserFeatureView)];
    
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

- (void)showUserFeatureView {    
    [[WQPopWindow sharedWindow] addSubview:self.userFeatureView];
    [[WQPopWindow sharedWindow] show];
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
    ALDServerModel *model = self.viewModel.list[indexPath.row];
    return [ServerCell heightForRow:model];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ServerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ServerCell"];
    ALDServerModel *model = self.viewModel.list[indexPath.row];
    cell.model = model;
    return cell;
}

#pragma mark - Table view delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ServerDetailViewController *vc = [[ServerDetailViewController alloc] init];
    ALDServerModel *model = self.viewModel.list[indexPath.row];
    vc.ID = model.ID;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
