//
//  MessageDetailVC.m
//  Aladdin
//
//  Created by luo on 2017/5/18.
//  Copyright © 2017年 wenqi. All rights reserved.
//

#import "MessageDetailVC.h"

@interface MessageDetailVC ()

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *contentLabel;

@end

@implementation MessageDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"消息详情";
    self.view.backgroundColor = [UIColor whiteColor];
    [self initUI];
    
    [self loadData];
}

- (void)loadData {
    NSDictionary *params = @{@"token": [User sharedInstance].token, @"id": @(self.ID)};
    [AFNManagerRequest getWithPath:API_USER_MSGDETAIL params:params success:^(NSURLResponse *response, id responseObject) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self reloadUI:responseObject];
        });
    } failure:^(NSError *error) {
        [MBProgressHUD showAutoMessage:error.localizedDescription];
    }];
}
- (void)initUI {
    
    [self.view addSubview:({
        UIScrollView *v = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        self.scrollView = v;
        self.scrollView;
    })];
    
    [self.scrollView addSubview:({
        UILabel *l = [[UILabel alloc] initWithFrame:CGRectMake(15, 20, Main_Screen_Width - 30, 0)];
        l.textColor = HEXCOLOR(0x333333);
        l.font = [UIFont systemFontOfSize:16];
        l.numberOfLines = 0;
        self.titleLabel = l;
        self.titleLabel;
    })];
    
    [self.scrollView addSubview:({
        UILabel *l = [[UILabel alloc] initWithFrame:CGRectMake(15, 20, Main_Screen_Width - 30, 0)];
        l.textColor = HEXCOLOR(0x666666);
        l.font = [UIFont systemFontOfSize:15];
        l.numberOfLines = 0;
        self.contentLabel = l;
        self.contentLabel;
    })];

}

- (void)reloadUI:(NSDictionary *)data {
    NSString *title = data[@"title"];
    NSString *content = data[@"content"];

    self.titleLabel.text = title;
    self.contentLabel.text = content;
    
    CGFloat titleHeight = [title heightForFont:self.titleLabel.font width:self.titleLabel.width];
    CGFloat contentHeight = [content heightForFont:self.contentLabel.font width:self.contentLabel.width];
    
    self.titleLabel.height = titleHeight;
    self.contentLabel.height = contentHeight;
    self.contentLabel.top = self.titleLabel.bottom + 20;
    
    self.scrollView.contentSize = CGSizeMake(Main_Screen_Width, self.contentLabel.bottom + 20);    
    
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
