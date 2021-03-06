//
//  NewsMainViewController.m
//  Aladdin
//
//  Created by luo on 2017/4/9.
//  Copyright © 2017年 wenqi. All rights reserved.
//

#import "NewsMainViewController.h"
#import "SGSegmentedControl.h"
#import "NewsListViewController.h"
#import "NewsMainViewModel.h"
#import "ALDNewsTypeModel.h"
#import "PolicySearchVC.h"
#import "UserFeatureView.h"
#import "WQPopWindow.h"

@interface NewsMainViewController ()<SGSegmentedControlDefaultDelegate, UIScrollViewDelegate>

@property (nonatomic, strong) SGSegmentedControlDefault *topSView;
@property (nonatomic, strong) SGSegmentedControlBottomView *bottomSView;
@property (nonatomic, strong) UserFeatureView *userFeatureView;

@property (nonatomic, strong) NewsMainViewModel *viewModel;

@end

@implementation NewsMainViewController

- (NewsMainViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[NewsMainViewModel alloc] init];
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
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.navigationItem.title = @"阿拉丁";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:(UIBarButtonSystemItemSearch) target:self action:@selector(showSearchVC)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"item_user_center"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:(UIBarButtonItemStylePlain) target:self action:@selector(showUserFeatureView)];
    [self loadNewsType];
    
}

- (void)showSearchVC {
    PolicySearchVC *searchVC = [[PolicySearchVC alloc] init];
    [self.navigationController pushViewController:searchVC animated:YES];
}
- (void)showUserFeatureView {
    [[WQPopWindow sharedWindow] addSubview:self.userFeatureView];
    [[WQPopWindow sharedWindow] show];
}

- (void)loadNewsType {
    @weakify(self);
    [self.viewModel loadNewsTypeWithCompleted:^(NSError *error) {
        @strongify(self)
        if (!error) {
            [self initUI];
        }else{
            [MBProgressHUD showAutoMessage:error.localizedDescription];
        }
    }];
}

- (void)initUI {
    NSMutableArray *array = self.viewModel.newsTypeList;
    NSMutableArray *titles = [NSMutableArray array];
    NSMutableArray *childVC = [NSMutableArray array];

    for (int i = 0; i < array.count; i++) {
        // titles
        ALDNewsTypeModel *model = array[i];
        [titles addObject:model.title];
        
        // child view controller
        NewsListViewController *vc = [[NewsListViewController alloc] init];
        vc.viewModel.ID = model.ID;
        [childVC addObject:vc];
        [self addChildViewController:vc];

    }
    
    self.bottomSView = [[SGSegmentedControlBottomView alloc] initWithFrame:CGRectMake(0, 64 + 38, self.view.frame.size.width, self.view.frame.size.height - 64 - 38)];
    _bottomSView.childViewController = childVC;
    _bottomSView.delegate = self;
    [self.view addSubview:_bottomSView];
    
    self.topSView = [SGSegmentedControlDefault segmentedControlWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 38) delegate:self childVcTitle:titles isScaleText:NO];
    self.topSView.backgroundColor = [UIColor whiteColor];
    self.topSView.titleColorStateNormal = COLOR_WORD_GRAY_2;
    self.topSView.titleColorStateSelected = GLOBAL_TINT_COLOR;
    self.topSView.indicatorColor = GLOBAL_TINT_COLOR;
    [self.view addSubview:_topSView];

}

- (void)SGSegmentedControlDefault:(SGSegmentedControlDefault *)segmentedControlDefault didSelectTitleAtIndex:(NSInteger)index {
    // 计算滚动的位置
    CGFloat offsetX = index * self.view.frame.size.width;
    self.bottomSView.contentOffset = CGPointMake(offsetX, 0);
    [self.bottomSView showChildVCViewWithIndex:index outsideVC:self];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    // 计算滚动到哪一页
    NSInteger index = scrollView.contentOffset.x / scrollView.frame.size.width;
    
    // 1.添加子控制器view
    [self.bottomSView showChildVCViewWithIndex:index outsideVC:self];
    
    // 2.把对应的标题选中
    [self.topSView changeThePositionOfTheSelectedBtnWithScrollView:scrollView];
}


@end
