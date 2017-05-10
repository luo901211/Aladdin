//
//  NewsDetailViewController.m
//  Aladdin
//
//  Created by luo on 2017/4/12.
//  Copyright © 2017年 wenqi. All rights reserved.
//

#import "NewsDetailViewController.h"
#import <WebKit/WebKit.h>
#import "NewsDetailBottomView.h"
#import "WQInputView.h"
#import "NewsDetailViewModel.h"
#import "User+Helper.h"

@interface NewsDetailViewController ()<WKNavigationDelegate, WKUIDelegate>

@property (nonatomic, strong) WKWebView *webView;

@property (nonatomic, strong) NewsDetailBottomView *bottomView;

@property (nonatomic, strong) NewsDetailViewModel *viewModel;

@end

@implementation NewsDetailViewController

- (NewsDetailViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[NewsDetailViewModel alloc] init];
    }
    return _viewModel;
}

- (WKWebView *)webView {
    if (!_webView) {
        _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height - 49)];
        _webView.navigationDelegate = self;
    }
    return _webView;
}

- (NewsDetailBottomView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[NSBundle mainBundle] loadNibNamed:@"NewsDetailBottomView" owner:nil options:nil][0];
        _bottomView.frame = CGRectMake(0, self.view.height - 49, self.view.width, 49);
        
        @weakify(self)
        _bottomView.commentBlock = ^(){
            
            // 未登录
            if (![[User sharedInstance] isLogin]) {
                [User presentLoginViewController];
                return ;
            }
            
            // 已登录
            __block WQInputView *popInputView = [[NSBundle mainBundle] loadNibNamed:@"WQInputView" owner:nil options:nil][0];
            [popInputView showWithTitle:@"写评论" cancelHandler:^(id obj) {
                /// 取消评论
            } sendHandler:^(id obj) {
                @strongify(self)
                NSInteger ID = self.ID;
                [self.viewModel submitComment:obj newsID:ID complete:^(NSString *msg) {
                    if (msg) {
                        [MBProgressHUD showAutoMessage:msg];
                    }else{
                        [MBProgressHUD showAutoMessage:@"评论成功"];
                    }
                }];
                [popInputView hide];
            }];
        };
        _bottomView.shareBlock = ^(){
            NSLog(@"分享");
        };
        _bottomView.commentListBlock = ^(){
            NSLog(@"评论列表");
        };
    }
    return _bottomView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"文章详情";
    
    [self initUI];
    [self loadWebview];
    [self loadCommentCount];
    
}
- (void)initUI {
    [self.view addSubview:self.webView];
    [self.view addSubview:self.bottomView];
}

- (void)loadWebview {
    NSString *urlString = [NSString stringWithFormat:@"%@%@?id=%ld",SERVER_HOST, NEWS_DETAIL, (long)self.ID];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]]];
}
- (void)loadCommentCount {
    @weakify(self)
    [AFNManagerRequest getWithPath:NEWS_COMMENT_COUNT params:@{@"id": @(self.ID)} success:^(NSURLResponse *response, id responseObject) {
        @strongify(self)
        NSString *commentCount = responseObject;
        if (![commentCount isKindOfClass:[NSString class]]) {
            commentCount = @"";
        }
        self.bottomView.commentCount = commentCount;
    } failure:^(NSError *error) {
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
