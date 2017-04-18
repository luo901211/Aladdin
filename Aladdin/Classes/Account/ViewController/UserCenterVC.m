//
//  UserCenterViewController.m
//  Aladdin
//
//  Created by luo on 2017/4/17.
//  Copyright © 2017年 wenqi. All rights reserved.
//

#import "UserCenterVC.h"
#import "SGSegmentedControl.h"
#import "UserInfoListVC.h"
#import "ChangePasswordVC.h"

@interface UserCenterVC ()<SGSegmentedControlDefaultDelegate, UIScrollViewDelegate>

@property (nonatomic, strong) SGSegmentedControlDefault *topSView;
@property (nonatomic, strong) SGSegmentedControlBottomView *bottomSView;

@end

@implementation UserCenterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.navigationItem.title = @"用户中心";

    [self initUI];    
}

- (void)initUI {
    
    
    UserInfoListVC *userInfoListVC = [[UserInfoListVC alloc] init];
    ChangePasswordVC *changePasswordVC = [[ChangePasswordVC alloc] init];
    [self addChildViewController:userInfoListVC];
    [self addChildViewController:changePasswordVC];
    
    NSArray *childVC = @[userInfoListVC, changePasswordVC];
    NSArray *titles = @[@"基本信息", @"修改密码"];
    
    
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
