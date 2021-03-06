//
//  PolicyContainerVC.m
//  Aladdin
//
//  Created by luo on 2017/4/21.
//  Copyright © 2017年 wenqi. All rights reserved.
//

#import "PolicyContainerVC.h"
#import "SGPageView.h"
#import "PolicyListVC.h"

@interface PolicyContainerVC ()<SGPageTitleViewDelegate, SGPageContentViewDelegare>
@property (nonatomic, strong) SGPageTitleView *pageTitleView;
@property (nonatomic, strong) SGPageContentView *pageContentView;
@property (strong, nonatomic) NSMutableArray *arrayList;

@end

@implementation PolicyContainerVC

- (NSMutableArray *)arrayList {
    if (!_arrayList) {
        _arrayList = [NSMutableArray array];
    }
    return _arrayList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationItem.title = @"政策法规";
    
    [self loadData];
}

- (void)loadData {
    
    @weakify(self);
    
    [AFNManagerRequest getWithPath:API_DISCOVER_POLICY_TYPE params:nil success:^(NSURLResponse *response, NSArray *responseObject) {
        
        @strongify(self);
        
        self.arrayList = [responseObject mutableCopy];
        [self initUI];
        
    } failure:^(NSError *error) {
        [MBProgressHUD showAutoMessage:error.localizedDescription];
    }];
    
}

- (void)initUI {
    
    NSMutableArray *titleArr = [NSMutableArray arrayWithCapacity:self.arrayList.count];
    for (int i = 0; i < self.arrayList.count; i++) {
        NSDictionary *dic = self.arrayList[i];
        [titleArr addObject:dic[@"title"]];
    }
    
    NSMutableArray *childVC = [NSMutableArray array];
    
    for (int i = 0; i < titleArr.count; i++) {
        PolicyListVC *vc = [[PolicyListVC alloc] init];
        vc.ID = [self.arrayList[i][@"id"] integerValue];
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
    CGFloat contentViewHeight = self.view.frame.size.height - 64 - 51 - 10;
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
