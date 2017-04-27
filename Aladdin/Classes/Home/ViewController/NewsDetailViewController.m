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

@interface NewsDetailViewController ()<WKNavigationDelegate, WKUIDelegate>

@property (nonatomic, strong) WKWebView *webView;

@property (nonatomic, strong) NewsDetailBottomView *bottomView;

@end

@implementation NewsDetailViewController

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
        _bottomView.commentBlock = ^(){
            NSLog(@"评论");
            __block WQInputView *popInputView = [[NSBundle mainBundle] loadNibNamed:@"WQInputView" owner:nil options:nil][0];
            [popInputView showWithTitle:@"写评论" cancelHandler:^(id obj) {
                NSLog(@"取消评论");
            } sendHandler:^(id obj) {
                NSLog(@"发送评论");
                
                
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
    
    [self loadCommentCount];
    
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

- (void)initUI {
    
    NSURL *url = [NSURL URLWithString:@"http://www.taobao.com"];
    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
    [self.view addSubview:self.webView];
    
    [self.view addSubview:self.bottomView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
