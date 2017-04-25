//
//  QuestionContainerVC.m
//  Aladdin
//
//  Created by luo on 2017/4/25.
//  Copyright © 2017年 wenqi. All rights reserved.
//

#import "QuestionContainerVC.h"
#import "SGPageView.h"
#import "QuestionListVC.h"

@interface QuestionContainerVC ()<SGPageTitleViewDelegate, SGPageContentViewDelegare>

@property (nonatomic, strong) SGPageTitleView *pageTitleView;
@property (nonatomic, strong) SGPageContentView *pageContentView;

@end

@implementation QuestionContainerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationItem.title = @"问答";
    
    [self initUI];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initUI {
    
    NSArray *titles = @[@"精华问答", @"大家都在问", @"我的问答"];
    
    QuestionListVC *vc1 = [[QuestionListVC alloc] init];
    vc1.type = QuestionTypeEssence;
    [self addChildViewController:vc1];

    QuestionListVC *vc2 = [[QuestionListVC alloc] init];
    vc2.type = QuestionTypeNotEssence;
    [self addChildViewController:vc2];

    QuestionListVC *vc3 = [[QuestionListVC alloc] init];
    vc3.type = QuestionTypeUser;
    [self addChildViewController:vc3];

    NSArray *childVC = @[vc1, vc2, vc3];
    
    /// pageTitleView
    self.pageTitleView = [SGPageTitleView pageTitleViewWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 51) delegate:self titleNames:titles];
    [self.view addSubview:_pageTitleView];
    _pageTitleView.selectedIndex = 0;
    _pageTitleView.titleColorStateNormal = COLOR_WORD_GRAY_2;
    _pageTitleView.titleColorStateSelected = GLOBAL_TINT_COLOR;
    _pageTitleView.indicatorColor = GLOBAL_TINT_COLOR;
    _pageTitleView.indicatorStyle = SGIndicatorTypeEqual;
    
    [self.view addSubview:({
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, self.pageTitleView.bottom, Main_Screen_Width, 10)];
        view.backgroundColor = HEXCOLOR(0xf6f6f6);
        view;
    })];
    
    /// pageContentView
    CGFloat contentViewHeight = self.view.frame.size.height - 64 - 51 -10;
    self.pageContentView = [[SGPageContentView alloc] initWithFrame:CGRectMake(0, 64 + 51 + 10, self.view.frame.size.width, contentViewHeight) parentVC:self childVCs:childVC];
    _pageContentView.delegatePageContentView = self;
    [self.view addSubview:_pageContentView];
    
}

#pragma mark - SGPageContentViewDelegare

- (void)SGPageTitleView:(SGPageTitleView *)SGPageTitleView selectedIndex:(NSInteger)selectedIndex {
    [self.pageContentView setPageCententViewCurrentIndex:selectedIndex];
}

- (void)SGPageContentView:(SGPageContentView *)SGPageContentView progress:(CGFloat)progress originalIndex:(NSInteger)originalIndex targetIndex:(NSInteger)targetIndex {
    [self.pageTitleView setPageTitleViewWithProgress:progress originalIndex:originalIndex targetIndex:targetIndex];
}



@end
