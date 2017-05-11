//
//  TeachingVideoDetailVC.m
//  Aladdin
//
//  Created by luo on 2017/4/21.
//  Copyright © 2017年 wenqi. All rights reserved.
//

#import "TeachingVideoDetailVC.h"
#import "VideoDetailViewModel.h"
#import "ALDVideoDetailModel.h"
#import <WebKit/WebKit.h>
#import "TeachingVideoDetailBottomView.h"

@interface TeachingVideoDetailVC ()

@property (strong, nonatomic) VideoDetailViewModel *viewModel;
@property (strong, nonatomic) ALDVideoDetailModel *model;

@property (strong, nonatomic) WKWebView *webView;
@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) TeachingVideoDetailBottomView *bottomView;

@end

@implementation TeachingVideoDetailVC

#pragma mark - Setter & Getter
- (VideoDetailViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[VideoDetailViewModel alloc] init];
    }
    return _viewModel;
}

- (void)setModel:(ALDVideoDetailModel *)model {
    _model = model;
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:model.url]]];
    self.bottomView.model = model;
    self.scrollView.contentSize = CGSizeMake(Main_Screen_Width, self.bottomView.height);

}

- (WKWebView *)webView {
    if (!_webView) {
        _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 64, Main_Screen_Width, 210 * kScreenWidthRatio)];
    }
    return _webView;
}
- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64 + 210 * kScreenWidthRatio, Main_Screen_Width, Main_Screen_Height - 64 - 210 * kScreenWidthRatio)];
    }
    return _scrollView;
}

- (TeachingVideoDetailBottomView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[NSBundle mainBundle] loadNibNamed:@"TeachingVideoDetailBottomView" owner:nil options:nil][0];
        _bottomView.frame = CGRectMake(0, 0, self.scrollView.width, 0);
        @weakify(self);
        _bottomView.collectTapBlock = ^(id obj) {
            @strongify(self);

            if (!self.model.is_collect) {
                [self.viewModel collectDataWithID:self.ID success:^(id obj) {
                    [MBProgressHUD showAutoMessage:@"收藏成功"];
                    ALDVideoDetailModel *model = self.model;
                    model.is_collect = 1;
                    self.model = model;
                } failure:^(id obj) {
                    [MBProgressHUD showAutoMessage:obj];
                }];

            }else{
                /*
                 [self.viewModel cancelCollectDataWithID:self.ID success:^(id obj) {
                 [MBProgressHUD showAutoMessage:@"取消收藏成功"];
                 ALDVideoDetailModel *model = self.model;
                 model.is_collect = 0;
                 self.model = model;
                 } failure:^(id obj) {
                 [MBProgressHUD showAutoMessage:obj];
                 }];
                 */
            }
        };
    }
    return _bottomView;
}

#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"视频详情";
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self initUI];
    [self loadData];
}

- (void)initUI {
    [self.view addSubview:self.webView];
    
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.bottomView];
}

- (void)loadData {
    @weakify(self);
    [self.viewModel loadDataWithID:self.ID success:^(id obj) {
        @strongify(self);
        ALDVideoDetailModel *model = [ALDVideoDetailModel mj_objectWithKeyValues:obj];
        self.model = model;
    } failure:^(id obj) {
        NSLog(@"error: %@",obj);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
