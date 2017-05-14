//
//  ExpertContainerVC.m
//  Aladdin
//
//  Created by luo on 2017/4/23.
//  Copyright © 2017年 wenqi. All rights reserved.
//

#import "ExpertContainerVC.h"
#import "SGPageView.h"
#import "ExpertListVC.h"

@interface ExpertContainerVC ()<SGPageTitleViewDelegate, SGPageContentViewDelegare>
@property (nonatomic, strong) SGPageTitleView *pageTitleView;
@property (nonatomic, strong) SGPageContentView *pageContentView;
@property (strong, nonatomic) NSMutableArray *arrayList;

@end

@implementation ExpertContainerVC

- (NSMutableArray *)arrayList {
    if (!_arrayList) {
        _arrayList = [NSMutableArray array];
        [_arrayList addObject:@{@"title": @"知名专家", @"level": @(2)}];
        [_arrayList addObject:@{@"title": @"优秀回答者", @"level": @(1)}];
    }
    return _arrayList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationItem.title = @"大咖专栏";
    if (self.expertTapBlock) {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:(UIBarButtonItemStylePlain) target:self action:@selector(dismiss)];
    }
    
    [self initUI];
}

- (void)dismiss {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void)initUI {
    
    NSMutableArray *titleArr = [NSMutableArray array];
    NSMutableArray *childVC = [NSMutableArray array];

    for (int i = 0; i < self.arrayList.count; i++) {
        NSDictionary *dic = self.arrayList[i];
        
        // title
        [titleArr addObject:dic[@"title"]];
        
        // child vc
        ExpertListVC *vc = [[ExpertListVC alloc] init];
        if (self.expertTapBlock) {
            vc.inviteReplyBlock = self.expertTapBlock;
        }
        vc.level = [dic[@"level"] integerValue];
        [childVC addObject:vc];
        [self addChildViewController:vc];

    }
    /// pageTitleView
    self.pageTitleView = [SGPageTitleView pageTitleViewWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 51) delegate:self titleNames:titleArr];
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
