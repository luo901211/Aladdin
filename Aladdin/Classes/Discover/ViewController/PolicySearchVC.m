//
//  PolicySearchVC.m
//  Aladdin
//
//  Created by luo on 2017/5/10.
//  Copyright © 2017年 wenqi. All rights reserved.
//

#import "PolicySearchVC.h"
#import "PolicyListVC.h"
#import "PolicySearchResultVC.h"

@interface PolicySearchVC ()

@property (strong, nonatomic) UIScrollView *scrollView;

@property (strong, nonatomic) UITextField *keyworkTextfield;

@property (strong, nonatomic) UIButton *searchButton;

@property (strong, nonatomic) NSMutableArray *arrayList;

@end

@implementation PolicySearchVC

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        [_scrollView addSubview:self.keyworkTextfield];
        [_scrollView addSubview:self.searchButton];
    }
    return _scrollView;
}

- (UITextField *)keyworkTextfield {
    if (!_keyworkTextfield) {
        _keyworkTextfield = [[UITextField alloc] initWithFrame:CGRectMake(15, 20, Main_Screen_Width - 15-57, 31)];
        _keyworkTextfield.borderStyle = UITextBorderStyleRoundedRect;
        _keyworkTextfield.font = [UIFont systemFontOfSize:13];
        _keyworkTextfield.placeholder = @"请输入关键字";
        UIImageView *leftImageV =  [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 31, 31)];
        leftImageV.contentMode = UIViewContentModeCenter;
        leftImageV.image = [UIImage imageNamed:@"left_img_search"];
        _keyworkTextfield.leftView =leftImageV;
        _keyworkTextfield.leftViewMode = UITextFieldViewModeAlways;
    }
    return _keyworkTextfield;
}

- (UIButton *)searchButton {
    if (!_searchButton) {
        _searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _searchButton.frame = CGRectMake(Main_Screen_Width - 57, 20, 57, 31);
        [_searchButton setTitle:@"搜索" forState:(UIControlStateNormal)];
        _searchButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [_searchButton setTitleColor:HEXCOLOR(0x999999) forState:UIControlStateNormal];
        [_searchButton setTitleColor:HEXCOLOR(0x666666) forState:UIControlStateHighlighted];
        [_searchButton addTarget:self action:@selector(didPressedOnSearchButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _searchButton;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"搜索";
    self.view.backgroundColor = HEXCOLOR(0xf6f6f6);
    [self.view addSubview:self.scrollView];
    [self loadData];
}


- (void)loadData {
    
    @weakify(self);
    
    [AFNManagerRequest getWithPath:API_DISCOVER_POLICY_TYPE params:nil success:^(NSURLResponse *response, NSArray *responseObject) {
        
        @strongify(self);
        
        self.arrayList = [responseObject mutableCopy];
        [self setupTypeButtons];
        
    } failure:^(NSError *error) {
        
        [MBProgressHUD showAutoMessage:error.localizedDescription];
        
    }];
    
}

- (void)setupTypeButtons {
    [_scrollView addSubview:({
        UILabel *l = [[UILabel alloc] initWithFrame:CGRectMake(15, self.keyworkTextfield.bottom + 25, Main_Screen_Width - 30, 33)];
        l.text = @"热门搜索";
        l.textColor = HEXCOLOR(0x333333);
        l.font = [UIFont systemFontOfSize:14];
        l;
    })];
    
    [_scrollView addSubview:({
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(15, self.keyworkTextfield.bottom + 56, Main_Screen_Width - 30, 1)];
        line.backgroundColor = HEXCOLOR(0xe5e5e5);
        line;
    })];
    
    CGFloat space = 12;
    CGFloat x = 15;
    CGFloat y = self.keyworkTextfield.bottom + 56 + 1 + 20;
    CGFloat buttonWidth = (Main_Screen_Width - 30 - 2 * space) / 3;
    CGFloat buttonHeight = 39;
    
    for (int i = 0; i < self.arrayList.count; i++) {
        NSDictionary *item = self.arrayList[i];
        UIButton *b = [UIButton buttonWithType:UIButtonTypeCustom];
        b.frame = CGRectMake(x + (i % 3) * (buttonWidth + space), y + (int)(i / 3) * (buttonHeight + space), buttonWidth, buttonHeight);
        [b setTitle:item[@"title"] forState:UIControlStateNormal];
        [b setTitleColor:HEXCOLOR(0x666666) forState:UIControlStateNormal];
        b.titleLabel.font = [UIFont systemFontOfSize:15];
        b.layer.borderColor = HEXCOLOR(0xe5e5e5).CGColor;
        b.layer.borderWidth = 1;
        b.layer.cornerRadius = 2;
        b.tag = 1000 + i;
        [b addTarget:self action:@selector(didPressedOnButton:) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView addSubview:b];
    }
}

- (void)didPressedOnSearchButton:(UIButton *)button {
    
    NSString *keyword = self.keyworkTextfield.text;
    if (!keyword.length) {
        return [MBProgressHUD showAutoMessage:@"请输入关键字"];
    }
    
    PolicySearchResultVC *vc = [[PolicySearchResultVC alloc] init];
    vc.keyword = keyword;
//    vc.title = keyword;
    vc.title = @"搜索结果";
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didPressedOnButton:(UIButton *)button {
    NSInteger index = button.tag - 1000;
    NSDictionary *item = self.arrayList[index];
    PolicyListVC *vc = [[PolicyListVC alloc] init];
    vc.ID = [item[@"id"] integerValue];
//    vc.title = item[@"title"];
    vc.title = @"搜索结果";
    [self.navigationController pushViewController:vc animated:YES];
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
