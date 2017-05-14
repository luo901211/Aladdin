//
//  NewsListViewController.m
//  Aladdin
//
//  Created by luo on 2017/4/8.
//  Copyright © 2017年 wenqi. All rights reserved.
//

#import "NewsListViewController.h"
#import "ALDNewsBannerModel.h"
#import "NewsCell.h"
#import "SDCycleScrollView.h"
#import "NewsDetailViewController.h"

@interface NewsListViewController ()

@property (nonatomic, strong) SDCycleScrollView *cycleScrollView;

@end

@implementation NewsListViewController

- (NewsListViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[NewsListViewModel alloc] init];
    }
    return _viewModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.tableFooterView = [UIView new];
    [self.tableView registerNib:[UINib nibWithNibName:@"NewsCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"NewsCell"];
    
    __weak NewsListViewController *weakSelf = self;
    self.tableView.mj_header = [WQRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadDataWithType:WQFetchDataTypeRefresh];
    }];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf loadDataWithType:WQFetchDataTypeLoadMore];
    }];
    self.tableView.mj_footer.automaticallyHidden = YES;
    
    [self.tableView.mj_header beginRefreshing];
    
    [self loadBannerData];
}

- (void)loadBannerData {
    @weakify(self);
    [self.viewModel loadBannerListWithCompleted:^(NSError *error) {
        @strongify(self);
        if (error) {
            [MBProgressHUD showAutoMessage:error.localizedDescription];
            return;
        }
        
        [self initCycleScrollViewWithArray:self.viewModel.bannerList];
        
    }];
}

- (void)initCycleScrollViewWithArray:(NSArray *)array {
    NSMutableArray *images = [NSMutableArray array];
    for (int i = 0; i < array.count; i++) {
        ALDNewsBannerModel *model = array[i];
        [images addObject:model.pic_url];
    }
    
    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, Main_Screen_Width, 150 * kScreenWidthRatio) delegate:nil placeholderImage:nil];
    cycleScrollView.imageURLStringsGroup = images;
    cycleScrollView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
    cycleScrollView.autoScroll = images.count > 1;
    cycleScrollView.clickItemOperationBlock = ^(NSInteger currentIndex) {
        NewsDetailViewController *vc = [[NewsDetailViewController alloc] init];
        ALDNewsModel *model = self.viewModel.bannerList[currentIndex];
        vc.ID = model.ID;
        [self.navigationController pushViewController:vc animated:YES];
    };
    self.tableView.tableHeaderView = cycleScrollView;
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
    ALDNewsModel *model = self.viewModel.list[indexPath.row];
    return [NewsCell heightForRow:model];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NewsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NewsCell"];
    ALDNewsModel *model = self.viewModel.list[indexPath.row];
    cell.model = model;
    return cell;
}

#pragma mark - Table view delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NewsDetailViewController *vc = [[NewsDetailViewController alloc] init];
    ALDNewsModel *model = self.viewModel.list[indexPath.row];
    vc.ID = model.ID;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
