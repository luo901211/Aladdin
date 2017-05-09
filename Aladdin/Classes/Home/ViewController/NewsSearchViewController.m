//
//  NewsSearchViewController.m
//  Aladdin
//
//  Created by luo on 2017/5/9.
//  Copyright © 2017年 wenqi. All rights reserved.
//

#import "NewsSearchViewController.h"

@interface NewsSearchViewController ()<UISearchBarDelegate>

@property (nonatomic, strong) UISearchBar *searchBar;


@end

@implementation NewsSearchViewController

- (UISearchBar *)searchBar {
    if (!_searchBar) {
        _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 64, Main_Screen_Width, 44)];
        _searchBar.backgroundColor = [UIColor whiteColor];
        _searchBar.showsSearchResultsButton = YES;
        _searchBar.delegate = self;
        _searchBar.placeholder = @"请输入关键字";
    }
    return _searchBar;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"搜索";
    [self.view addSubview:self.searchBar];
    [self.searchBar becomeFirstResponder];
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
