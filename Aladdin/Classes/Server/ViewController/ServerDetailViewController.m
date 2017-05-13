//
//  ServerDetailViewController.m
//  Aladdin
//
//  Created by luo on 2017/4/16.
//  Copyright © 2017年 wenqi. All rights reserved.
//

#import "ServerDetailViewController.h"

@interface ServerDetailViewController ()
@property (strong, nonatomic) UIWebView *webView;

@end

@implementation ServerDetailViewController

- (UIWebView *)webView {
    if (!_webView) {
        _webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    }
    return _webView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"服务详情";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.webView];
    [self loadData];
    
}

- (void)loadData {
    NSString *urlString = [NSString stringWithFormat:@"%@%@?id=%ld",SERVER_HOST, API_SERVER_DETAIL, (long)self.ID];
    urlString = [urlString stringByAppendingString:@"&show_download=false"];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
