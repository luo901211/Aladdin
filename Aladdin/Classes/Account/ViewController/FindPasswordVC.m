//
//  FindPwdViewController.m
//  Aladdin
//
//  Created by luo on 2017/4/13.
//  Copyright © 2017年 wenqi. All rights reserved.
//

#import "FindPasswordVC.h"
#import "FindPasswordViewModel.h"
#import "UINavigationBar+Awesome.h"

#define kTop 104.0
#define kLeft (Main_Screen_Width - kItemWidth) / 2
#define kItemWidth 261.0
#define kItemHeight 44.0

@interface FindPasswordVC ()
@property (strong, nonatomic) UITextField *phoneTextField;
@property (strong, nonatomic) UITextField *codeTextField;
@property (strong, nonatomic) UITextField *pwdTextField;

@property (strong, nonatomic) FindPasswordViewModel *viewModel;

@end

@implementation FindPasswordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = HEXCOLOR(0xf6f6f6);
    self.navigationItem.title = @"重置密码";
    [self initUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar lt_reset];
    
    self.navigationController.navigationBar.barTintColor = GLOBAL_TINT_COLOR;
    NSDictionary * dict = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
    self.navigationController.navigationBar.titleTextAttributes = dict;
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor clearColor]];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}

- (FindPasswordViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[FindPasswordViewModel alloc] init];
    }
    return _viewModel;
}


- (UITextField *)phoneTextField {
    if (!_phoneTextField) {
        // 手机号
        _phoneTextField = [self setupTextFieldWithFrame:CGRectMake(kLeft, kTop, kItemWidth, kItemHeight) leftImageName:@"icon_phone" placeholder:@"输入手机号"];
        _phoneTextField.keyboardType = UIKeyboardTypePhonePad;
    }
    return _phoneTextField;
}

- (UITextField *)codeTextField {
    if (!_codeTextField) {
        // 验证码
        _codeTextField = [self setupTextFieldWithFrame:CGRectMake(kLeft, kTop + (kItemHeight + 15), kItemWidth, kItemHeight) leftImageName:@"icon_auth_code" placeholder:@"验证码"];
        _codeTextField.keyboardType = UIKeyboardTypeNumberPad;
        _codeTextField.userInteractionEnabled = YES;
        
        UIButton *getCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        getCodeBtn.frame = CGRectMake(kItemWidth - 78 - 10, (kItemHeight - 22)/2, 78, 22);
        getCodeBtn.titleLabel.font = [UIFont systemFontOfSize:11];
        [getCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [getCodeBtn setTitleColor:HEXCOLOR(0x76879f) forState:UIControlStateNormal];
        getCodeBtn.layer.borderColor = HEXCOLOR(0x76879f).CGColor;
        getCodeBtn.layer.borderWidth = 1;
        getCodeBtn.layer.cornerRadius = 11;
        
        [getCodeBtn addTarget:self action:@selector(didPressedOnGetCodeButton:) forControlEvents:UIControlEventTouchUpInside];
        [_codeTextField addSubview:getCodeBtn];
    }
    return _codeTextField;
}

- (UITextField *)pwdTextField {
    if (!_pwdTextField) {
        // 密码
        _pwdTextField = [self setupTextFieldWithFrame:CGRectMake(kLeft, kTop + (kItemHeight + 15)*2, kItemWidth, kItemHeight) leftImageName:@"icon_pwd" placeholder:@"输入密码"];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, 0, 44, 44);
        [button setImage:[UIImage imageNamed:@"icon_pwd_show"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"icon_pwd_hidden"] forState:UIControlStateSelected];
        [button setContentMode:(UIViewContentModeCenter)];
        [button addTarget:self action:@selector(didPressedOnPasswordButton:) forControlEvents:UIControlEventTouchUpInside];
        button.selected = YES;
        _pwdTextField.rightViewMode = UITextFieldViewModeAlways;
        _pwdTextField.rightView = button;
        _pwdTextField.secureTextEntry = YES;
    }
    return _pwdTextField;
}


- (void)initUI {
    
    [self.view addSubview:self.phoneTextField];
    [self.view addSubview:self.codeTextField];
    [self.view addSubview:self.pwdTextField];
    // 重置密码按钮
    UIButton *resetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    resetBtn.frame = CGRectMake(kLeft, kTop + (kItemHeight + 15)*3 + 5, kItemWidth, 44);
    [resetBtn setBackgroundColor:GLOBAL_TINT_COLOR];
    resetBtn .layer.cornerRadius = 44/2;
    resetBtn.layer.masksToBounds = YES;
    [resetBtn setTitle:@"确定重置密码" forState:UIControlStateNormal];
    [resetBtn.titleLabel setFont:[UIFont systemFontOfSize:16]];
    [resetBtn addTarget:self action:@selector(didPressedOnResetButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:resetBtn];
    
}

- (UITextField *)setupTextFieldWithFrame:(CGRect)frame leftImageName:(NSString *)leftImageName placeholder:(NSString *)placeholder {
    
    UITextField *textField = [[UITextField alloc] initWithFrame:frame];
    textField.backgroundColor = HEXCOLOR(0xf9f9f9);
    textField.textColor = HEXCOLOR(0x76879f);
    textField.layer.cornerRadius = textField.height/2;
    textField.placeholder = placeholder;
    
    if (leftImageName) {
        UIImageView *imageV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:leftImageName]];
        imageV.frame = CGRectMake(0, 0, 44, 44);
        imageV.contentMode = UIViewContentModeCenter;
        textField.leftViewMode = UITextFieldViewModeAlways;
        textField.leftView = imageV;
    }
    
    return textField;
}

#pragma mark - Function

- (void)didPressedOnPasswordButton:(UIButton *)button {
    button.selected = !button.selected;
    self.pwdTextField.secureTextEntry = button.selected;
}

- (void)didPressedOnGetCodeButton:(UIButton *)button {
    NSString *phone = self.phoneTextField.text;
    
    [self.viewModel getCodeWithPhone:phone success:^(id obj) {
        [MBProgressHUD showAutoMessage:@"验证码已发送"];
    } failure:^(id obj) {
        [MBProgressHUD showAutoMessage:obj];
    }];
}

- (void)didPressedOnResetButton:(UIButton *)button {
    NSString *phone = self.phoneTextField.text;
    NSString *code = self.codeTextField.text;
    NSString *password = self.pwdTextField.text;
    
    [self.viewModel findPasswordWithPhone:phone password:password code:code success:^(id obj) {
        [MBProgressHUD showAutoMessage:@"已重置密码"];
    } failure:^(id obj) {
        [MBProgressHUD showAutoMessage:obj];
    }];
}

@end
