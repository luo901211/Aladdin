//
//  TeachingVideoCollectionVC.m
//  Aladdin
//
//  Created by luo on 2017/4/9.
//  Copyright © 2017年 wenqi. All rights reserved.
//

#import "TeachingVideoCollectionVC.h"
#import "VideoListViewModel.h"
#import "ALDVideoModel.h"
#import "TeachingVideoCollectionViewCell.h"
#import "TeachingVideoDetailVC.h"

@interface TeachingVideoCollectionVC ()

@property (nonatomic, strong) VideoListViewModel *viewModel;

@end

@implementation TeachingVideoCollectionVC

static NSString * const reuseIdentifier = @"TeachingVideoCollectionViewCell";

- (instancetype)init {
    // layout
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.minimumLineSpacing = 0;
    flowLayout.itemSize = CGSizeMake(Main_Screen_Width / 2, 165 * kScreenWidthRatio);
    
    return [super initWithCollectionViewLayout:flowLayout];
}

- (VideoListViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[VideoListViewModel alloc] init];
    }
    return _viewModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    [self.collectionView registerNib:[UINib nibWithNibName:@"TeachingVideoCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:reuseIdentifier];
    // Do any additional setup after loading the view.
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    __weak TeachingVideoCollectionVC *weakSelf = self;
    self.collectionView.mj_header = [WQChiBaoZiHeader headerWithRefreshingBlock:^{
        [weakSelf loadDataWithType:WQFetchDataTypeRefresh];
    }];
    self.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf loadDataWithType:WQFetchDataTypeLoadMore];
    }];
    self.collectionView.mj_footer.automaticallyHidden = YES;
    
    [self.collectionView.mj_header beginRefreshing];

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
            [self.collectionView.mj_footer endRefreshingWithNoMoreData];
        }
        
        if (type == WQFetchDataTypeRefresh) {
            
            [self.collectionView.mj_header endRefreshing];
            
        }else if(type == WQFetchDataTypeLoadMore && !noMoreData){
            
            [self.collectionView.mj_footer endRefreshing];
            
        }
        [self.collectionView reloadData];
    } failure:^(NSError *error) {
        if (type == WQFetchDataTypeRefresh) {
            [self.collectionView.mj_header endRefreshing];
        }else if(type == WQFetchDataTypeLoadMore){
            [self.collectionView.mj_footer endRefreshing];
        }
        NSLog(@"%@",error.userInfo);
    }];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.viewModel.list.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TeachingVideoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.model = self.viewModel.list[indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (![[User sharedInstance] isLogin]) {
        NSLog(@"请先登录");
        return;
    }
    
    TeachingVideoDetailVC *vc = [[TeachingVideoDetailVC alloc] init];
    ALDVideoModel *model = self.viewModel.list[indexPath.row];
    vc.ID = model.ID;
    [self.navigationController pushViewController:vc animated:YES];
}
@end
