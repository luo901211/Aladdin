//
//  PolicyDetailVC.m
//  Aladdin
//
//  Created by luo on 2017/4/21.
//  Copyright © 2017年 wenqi. All rights reserved.
//

#import "PolicyDetailVC.h"
#import "ApiMacros.h"
#import <WebKit/WebKit.h>

@interface PolicyDetailVC () <WKNavigationDelegate, WKUIDelegate>

@property (strong, nonatomic) WKWebView *webView;

@end

@implementation PolicyDetailVC

- (WKWebView *)webView {
    if (!_webView) {
        _webView = [[WKWebView alloc] initWithFrame:self.view.bounds];
        _webView.UIDelegate = self;
        _webView.navigationDelegate = self;
    }
    return _webView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.webView];
    [self loadData];
    
}

- (void)loadData {
    NSString *urlString = [NSString stringWithFormat:@"%@%@?id=%ld",SERVER_HOST, API_DISCOVER_POLICY_DETAIL, (long)self.ID];
    urlString = [urlString stringByAppendingString:@"&show_download=false"];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - WKUIDelegate
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [alert show];
    completionHandler();    
}
@end
