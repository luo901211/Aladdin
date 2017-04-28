//
//  ChangePwdViewController.m
//  Aladdin
//
//  Created by luo on 2017/4/13.
//  Copyright © 2017年 wenqi. All rights reserved.
//

#import "ChangePasswordVC.h"
#import "ChangePasswordViewModel.h"

@interface ChangePasswordVC ()

@property (nonatomic, strong) ChangePasswordViewModel *viewModel;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *nPasswordTextField;
@property (weak, nonatomic) IBOutlet UITextField *rePasswordTextField;

@end

@implementation ChangePasswordVC

- (ChangePasswordViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[ChangePasswordViewModel alloc] init];
    }
    return _viewModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = HEXCOLOR(0xf6f6f6);
    
}
- (IBAction)changePassword:(UIButton *)sender {
    NSString *password = self.passwordTextField.text;
    NSString *newPassword = self.nPasswordTextField.text;
    NSString *rePassword = self.rePasswordTextField.text;
    [self.viewModel changePasswordWithPassword:password newPassword:newPassword rePassword:rePassword complete:^(NSString *msg) {
        if (msg) {
            [MBProgressHUD showAutoMessage:msg];
        }else{
            [MBProgressHUD showAutoMessage:@"修改成功"];
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
