//
//  UserInfoListVC.m
//  Aladdin
//
//  Created by luo on 2017/4/19.
//  Copyright © 2017年 wenqi. All rights reserved.
//

#import "UserInfoListVC.h"
#import "UserInfoListViewModel.h"

@interface UserInfoListVC ()

@property (nonatomic, strong) UserInfoListViewModel *viewModel;
@property (weak, nonatomic) IBOutlet UITextField *accountTextField;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *addressTextField;
@property (weak, nonatomic) IBOutlet UITextField *companyTextField;
@property (weak, nonatomic) IBOutlet UITextField *positionTextField;
@property (weak, nonatomic) IBOutlet UIButton *avatarButton;

@end

@implementation UserInfoListVC

- (UserInfoListViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[UserInfoListViewModel alloc] init];
    }
    return _viewModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = HEXCOLOR(0xf6f6f6);
    self.accountTextField.enabled = NO;
    [self loadData];
}

- (void)loadData {
    @weakify(self)
    [self.viewModel loadDataWithComplete:^(NSString *msg) {
        @strongify(self)
        if (msg) {
            [MBProgressHUD showAutoMessage:msg];
        }else{
            self.accountTextField.text = self.viewModel.userInfo[@"mobile"];
            self.nameTextField.text = self.viewModel.userInfo[@"real_name"];
            self.addressTextField.text = self.viewModel.userInfo[@"address"];
            self.companyTextField.text = self.viewModel.userInfo[@"company"];
            self.positionTextField.text = self.viewModel.userInfo[@"position"];
        }
    }];
}

- (IBAction)save:(UIButton *)sender {
    //    token：必传，用户标识
    //    real_name：必传
    //    address：必传
    //    company：必传
    //    position：必传
    //    pic ： 必传，name=pic, 使用file方式上传图像
    NSDictionary *params = @{
                             @"real_name": self.nameTextField.text,
                             @"address": self.addressTextField.text,
                             @"company": self.companyTextField.text,
                             @"position": self.positionTextField.text,
                             @"pic": @""
                             };
    [self.viewModel saveDataWithParams:params complete:^(NSString *msg) {
        if (msg) {
            [MBProgressHUD showAutoMessage:msg];
        }else{
            [MBProgressHUD showAutoMessage:@"保存成功"];
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
//section头部间距
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20.f;//section头部高度
}
//section底部间距
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01f;
}
@end
