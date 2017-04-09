//
//  AnswerMainViewController.m
//  Aladdin
//
//  Created by luo on 2017/4/9.
//  Copyright © 2017年 wenqi. All rights reserved.
//

#import "AnswerMainViewController.h"
#import "SGSegmentedControl.h"
#import "AnswerListViewController.h"

@interface AnswerMainViewController ()<SGSegmentedControlDefaultDelegate, UIScrollViewDelegate>

@property (nonatomic, strong) SGSegmentedControlStatic *topSView;
@property (nonatomic, strong) SGSegmentedControlBottomView *bottomSView;

@end

@implementation AnswerMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.navigationItem.title = @"问答";
    
    [self initUI];
}

- (void)initUI {
    
    NSArray *titleArr = @[@"精华问答", @"大家都在问", @"我的提问"];
    NSMutableArray *childVC = [NSMutableArray array];
    for (int i = 0; i < titleArr.count; i++) {
        AnswerListViewController *vc = [[AnswerListViewController alloc] init];
        [childVC addObject:vc];
        [self addChildViewController:vc];
    }
    self.bottomSView = [[SGSegmentedControlBottomView alloc] initWithFrame:CGRectMake(0, 64 + 38, self.view.frame.size.width, self.view.frame.size.height - 64 - 38)];
    _bottomSView.childViewController = childVC;
    _bottomSView.delegate = self;
    [self.view addSubview:_bottomSView];
    
    
    
    // SegmentedControl
    self.topSView = [SGSegmentedControlStatic segmentedControlWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 44) delegate:nil childVcTitle:titleArr indicatorIsFull:NO];
    // 必须实现的方法
    [self.topSView SG_setUpSegmentedControlType:^(SGSegmentedControlStaticType *segmentedControlStaticType, NSArray *__autoreleasing *nomalImageArr, NSArray *__autoreleasing *selectedImageArr) {        
    }];
    [self.topSView SG_setUpSegmentedControlStyle:^(UIColor *__autoreleasing *segmentedControlColor, UIColor *__autoreleasing *titleColor, UIColor *__autoreleasing *selectedTitleColor, UIColor *__autoreleasing *indicatorColor, BOOL *isShowIndicor) {
        *segmentedControlColor = [UIColor whiteColor];
        *titleColor = COLOR_WORD_GRAY_2;
        *selectedTitleColor = GLOBAL_TINT_COLOR;
        *indicatorColor = GLOBAL_TINT_COLOR;
        *isShowIndicor = YES;
    }];

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
