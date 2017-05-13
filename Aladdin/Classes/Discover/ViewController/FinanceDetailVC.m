//
//  FinanceDetailVC.m
//  Aladdin
//
//  Created by luo on 2017/4/23.
//  Copyright © 2017年 wenqi. All rights reserved.
//

#import "FinanceDetailVC.h"

@interface FinanceDetailVC ()

@property (strong, nonatomic) UIWebView *webView;

@end

@implementation FinanceDetailVC

- (UIWebView *)webView {
    if (!_webView) {
        _webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
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
    NSString *urlString = [NSString stringWithFormat:@"%@%@?id=%ld&token=%@",SERVER_HOST, API_DISCOVER_FINANCE_DETAIL, (long)self.ID, [User sharedInstance].token];
    urlString = [urlString stringByAppendingString:@"&show_download=false"];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
