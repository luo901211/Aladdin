//
//  ExpertDetailVC.m
//  Aladdin
//
//  Created by luo on 2017/4/25.
//  Copyright © 2017年 wenqi. All rights reserved.
//

#import "ExpertDetailVC.h"
#import "ExpertDetailViewModel.h"
#import "ALDExpertDetailModel.h"
#import "ExpertDetailHeaderView.h"
#import "UINavigationBar+Awesome.h"
#import "ExpertNewsListVC.h"
#import "ExpertAnswerListVC.h"
#import "SGPageView.h"
#import "QuestionReportVC.h"
#import "ALDBaseNavigationController.h"

@interface ExpertDetailVC ()<SGPageTitleViewDelegate, SGPageContentViewDelegare>

@property (strong, nonatomic) ExpertDetailViewModel *viewModel;
@property (strong, nonatomic) ALDExpertDetailModel *model;

@property (strong, nonatomic) ExpertDetailHeaderView *headerView;
@property (nonatomic, strong) SGPageTitleView *pageTitleView;
@property (nonatomic, strong) SGPageContentView *pageContentView;

@property (strong, nonatomic) ExpertNewsListVC *newsListVC;
@property (strong, nonatomic) ExpertAnswerListVC *answerListVC;

@property (strong, nonatomic) UIView *footerView;

@end

@implementation ExpertDetailVC

- (ExpertDetailViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[ExpertDetailViewModel alloc] init];
    }
    return _viewModel;
}

- (ExpertNewsListVC *)newsListVC {
    if (!_newsListVC) {
        _newsListVC = [[ExpertNewsListVC alloc] init];
        _newsListVC.ID = self.ID;
    }
    return _newsListVC;
}

- (ExpertAnswerListVC *)answerListVC {
    if (!_answerListVC) {
        _answerListVC = [[ExpertAnswerListVC alloc] init];
        _answerListVC.ID = self.ID;
    }
    return _answerListVC;
}

- (ExpertDetailHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [[NSBundle mainBundle] loadNibNamed:@"ExpertDetailHeaderView" owner:nil options:nil][0];
        _headerView.frame = CGRectMake(0, 0, Main_Screen_Width, 350);
    }
    return _headerView;
}

- (UIView *)footerView {
    if (!_footerView) {
        _footerView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.height - 50, Main_Screen_Width, 50)];
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 1)];
        line.backgroundColor = HEXCOLOR(0xececec);
        [_footerView addSubview:line];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(15, 7, Main_Screen_Width - 30, 36);
        [button setBackgroundColor:GLOBAL_TINT_COLOR];
        [button setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        [button setTitle:@"提问" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(didPressedOnSubmitButton:) forControlEvents:UIControlEventTouchUpInside];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        button.layer.cornerRadius = 4;
        button.layer.masksToBounds = YES;
        [_footerView addSubview:button];
    }
    return _footerView;
}

- (void)didPressedOnSubmitButton:(UIButton *)button {
    if (!self.model) {
        return;
    }
    QuestionReportVC *vc = [[QuestionReportVC alloc] initWithNibName:@"QuestionReportVC" bundle:[NSBundle mainBundle]];
    ALDExpertModel *model = [[ALDExpertModel alloc] init];
    model.ID = self.model.ID;
    model.real_name = self.model.real_name;
    model.pic_url = self.model.pic_url;
    model.company = self.model.company;
    model.position = self.model.position;
    vc.expertModel = model;
    
    ALDBaseNavigationController *nav = [[ALDBaseNavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:nav animated:YES completion:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"大咖详情";
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self loadData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor clearColor]];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar lt_reset];
}

- (void)initUI {
    self.headerView.model = self.model;
    [self.view addSubview:self.headerView];

    [self.view addSubview:({
        UIView *lineV = [[UIView alloc] initWithFrame:CGRectMake(0, self.headerView.bottom, Main_Screen_Width, 10)];
        lineV.backgroundColor = HEXCOLOR(0xf6f6f6);
        lineV;
    })];
    
    
    NSArray *titles;
    NSArray *childVC;
    if (self.level == 2) {
        // 专家观点 + 专家解答
        titles = @[@"专家观点", @"专家解答"];
        childVC = @[self.newsListVC, self.answerListVC];
    }else if (self.level == 1) {
        // 大咖解答
        titles = @[@"大咖解答"];
        childVC = @[self.answerListVC];
    }
    
    /// pageTitleView
    self.pageTitleView = [SGPageTitleView pageTitleViewWithFrame:CGRectMake(0, self.headerView.bottom + 10, self.view.frame.size.width, 51) delegate:self titleNames:titles];
    [self.view addSubview:_pageTitleView];
    _pageTitleView.selectedIndex = 0;
    _pageTitleView.titleColorStateNormal = COLOR_WORD_GRAY_2;
    _pageTitleView.titleColorStateSelected = GLOBAL_TINT_COLOR;
    _pageTitleView.indicatorColor = GLOBAL_TINT_COLOR;
    _pageTitleView.indicatorStyle = SGIndicatorTypeEqual;
    
    [_pageTitleView insertSubview:({
        UIView *lineV = [[UIView alloc] initWithFrame:CGRectMake(0, 50, Main_Screen_Width, 1)];
        lineV.backgroundColor = HEXCOLOR(0xf6f6f6);
        lineV;
    }) atIndex:0];
    
    if (self.level == 1) {
        
        // 大咖解答 隐藏 titleView
        self.pageTitleView.hidden = YES;
        
        UILabel *l = [[UILabel alloc] initWithFrame:self.pageTitleView.frame];
        l.text = @"    大咖解答";
        l.font = [UIFont systemFontOfSize:16];
        l.textColor = GLOBAL_TINT_COLOR;
        [self.view addSubview:l];
        
        [l insertSubview:({
            UIView *lineV = [[UIView alloc] initWithFrame:CGRectMake(0, 50, Main_Screen_Width, 1)];
            lineV.backgroundColor = HEXCOLOR(0xf6f6f6);
            lineV;
        }) atIndex:0];
    }

    
    /// pageContentView
    CGFloat contentViewHeight = self.view.frame.size.height - self.pageTitleView.bottom - 50;
    self.pageContentView = [[SGPageContentView alloc] initWithFrame:CGRectMake(0, self.pageTitleView.bottom, self.view.frame.size.width, contentViewHeight) parentVC:self childVCs:childVC];
    _pageContentView.delegatePageContentView = self;
    [self.view addSubview:_pageContentView];

    // footer view
    [self.view addSubview:self.footerView];
}

- (void)loadData {
    @weakify(self);
    [self.viewModel loadDataWithID:self.ID success:^(id obj) {
        @strongify(self);
        ALDExpertDetailModel *model = [ALDExpertDetailModel mj_objectWithKeyValues:obj];
        self.model = model;
        [self initUI];
    } failure:^(id obj) {
        [MBProgressHUD showAutoMessage:obj];
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - SGPageContentViewDelegare

- (void)SGPageTitleView:(SGPageTitleView *)SGPageTitleView selectedIndex:(NSInteger)selectedIndex {
    [self.pageContentView setPageCententViewCurrentIndex:selectedIndex];
}

- (void)SGPageContentView:(SGPageContentView *)SGPageContentView progress:(CGFloat)progress originalIndex:(NSInteger)originalIndex targetIndex:(NSInteger)targetIndex {
    [self.pageTitleView setPageTitleViewWithProgress:progress originalIndex:originalIndex targetIndex:targetIndex];
}

@end
