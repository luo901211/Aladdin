//
//  LoginViewController.m
//  Aladdin
//
//  Created by luo on 2017/4/13.
//  Copyright © 2017年 wenqi. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "FindPwdViewController.h"
#import "UINavigationBar+Awesome.h"
#import "LoginViewModel.h"

#define kBannerHeight (238.0 * kScreenWidthRatio)
#define kTop (238.0 * kScreenWidthRatio) + 35
#define kLeft (Main_Screen_Width - kItemWidth) / 2
#define kItemWidth 261.0
#define kItemHeight 44.0

#define kMiniBtnWidth 80
#define kMiniBtnHeight 40

@interface LoginViewController ()

//@property (assign, nonatomic) NSInteger

@property (strong, nonatomic) UITextField *phoneTextField;
@property (strong, nonatomic) UITextField *codeTextField;
@property (strong, nonatomic) UITextField *pwdTextField;

@property (assign, nonatomic) BOOL loginTypePassword;
@property (weak, nonatomic) IBOutlet UIButton *passwordLoginBtn;
@property (weak, nonatomic) IBOutlet UIButton *codeLoginBtn;



@property (strong, nonatomic) UIView *inputContainerView;
@property (strong, nonatomic) UIView *loginContainerView;

@property (strong, nonatomic) LoginViewModel *viewModel;

@end

@implementation LoginViewController


#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor clearColor]];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
    [self initUI];
}

- (void)initUI {
    
    [self.view addSubview:self.phoneTextField];
    [self.view addSubview:self.pwdTextField];
    [self.view addSubview:self.codeTextField];
    [self.view addSubview:self.loginContainerView];
    
    self.passwordLoginBtn.selected = YES;
    self.loginTypePassword = YES;
    self.codeTextField.hidden = YES;
}

#pragma mark - 懒加载
- (LoginViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[LoginViewModel alloc] init];
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

- (UITextField *)pwdTextField {
    if (!_pwdTextField) {
        // 密码
        _pwdTextField = [self setupTextFieldWithFrame:CGRectMake(kLeft, kTop + (kItemHeight + 15), kItemWidth, kItemHeight) leftImageName:@"icon_pwd" placeholder:@"输入密码"];
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

- (UITextField *)codeTextField {
    if (!_codeTextField) {
        // 验证码
        _codeTextField = [self setupTextFieldWithFrame:CGRectMake(kLeft, kTop + (kItemHeight + 15), kItemWidth, kItemHeight) leftImageName:@"icon_auth_code" placeholder:@"验证码"];
        self.codeTextField.keyboardType = UIKeyboardTypeNumberPad;
        
        UIButton *getCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        getCodeBtn.frame = CGRectMake(kItemWidth - 78 - 10, (kItemHeight - 22)/2, 78, 22);
        getCodeBtn.titleLabel.font = [UIFont systemFontOfSize:11];
        [getCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [getCodeBtn setTitleColor:HEXCOLOR(0x76879f) forState:UIControlStateNormal];
        getCodeBtn.layer.borderColor = HEXCOLOR(0x76879f).CGColor;
        getCodeBtn.layer.borderWidth = 1;
        getCodeBtn.layer.cornerRadius = 11;
        [_codeTextField addSubview:getCodeBtn];
    }
    return _codeTextField;
}


- (UIView *)loginContainerView {
    if (!_loginContainerView) {
        
        _loginContainerView = [[UIView alloc] initWithFrame:CGRectMake(0, kTop + (kItemHeight + 15) * 2 + 5, Main_Screen_Width, 100)];
        
        UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        loginBtn.frame = CGRectMake(kLeft, 0, kItemWidth, 51);
        [loginBtn setBackgroundImage:[UIImage imageNamed:@"login_btn_bg"] forState:UIControlStateNormal];
        [loginBtn addTarget:self action:@selector(didPressedOnLoginButton:) forControlEvents:UIControlEventTouchUpInside];
        [_loginContainerView addSubview:loginBtn];
        
        UIButton *forgetPwdBtn = [self setupMiniButtonWithFrame:CGRectMake(kLeft, loginBtn.bottom, kMiniBtnWidth, kMiniBtnHeight) title:@"忘记密码?" titleColor:HEXCOLOR(0xc4c8d1)];
        [forgetPwdBtn addTarget:self action:@selector(didPressedOnFindPwdButton:) forControlEvents:UIControlEventTouchUpInside];
        [_loginContainerView addSubview:forgetPwdBtn];
        
        UIButton *registerBtn = [self setupMiniButtonWithFrame:CGRectMake(loginBtn.right - kMiniBtnWidth, loginBtn.bottom, kMiniBtnWidth, kMiniBtnHeight) title:@"我要注册" titleColor:GLOBAL_TINT_COLOR];
        [registerBtn addTarget:self action:@selector(didPressedOnRegisterButton:) forControlEvents:UIControlEventTouchUpInside];
        [_loginContainerView addSubview:registerBtn];
        
    }
    return _loginContainerView;
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

- (UIButton *)setupMiniButtonWithFrame:(CGRect)frame title:(NSString *)title titleColor:(UIColor *)titleColor{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:12];
    return button;
}

#pragma mark - Function

- (void)didPressedOnLoginButton:(UIButton *)button {
    
    NSString *phone = self.phoneTextField.text;
    NSString *password = self.pwdTextField.text;
    NSString *code = self.codeTextField.text;
    
    VoidBlock success = ^(id obj){
        NSLog(@"登录成功");
    };
    
    VoidBlock failure = ^(id obj){
        NSLog(@"登录失败");
    };
    
    if (self.loginTypePassword) {
        [self.viewModel loginWithPhone:phone password:password success:success failure:failure];
    }else{
        [self.viewModel loginWithPhone:phone code:code success:success failure:failure];
    }
}

- (IBAction)didPressedOnLoginTypeButton:(UIButton *)sender {
    if (sender.selected) {
        return;
    }
    self.loginTypePassword = !self.loginTypePassword;
    
    self.codeLoginBtn.selected = !self.loginTypePassword;
    self.codeTextField.hidden = self.loginTypePassword;
    
    self.passwordLoginBtn.selected = self.loginTypePassword;
    self.pwdTextField.hidden = !self.loginTypePassword;
}

- (void)didPressedOnPasswordButton:(UIButton *)button {
    button.selected = !button.selected;
    self.pwdTextField.secureTextEntry = button.selected;
}

- (void)didPressedOnFindPwdButton:(UIButton *)button {
    FindPwdViewController *vc = [[FindPwdViewController alloc] initWithNibName:@"FindPwdViewController" bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didPressedOnRegisterButton:(UIButton *)button {
    RegisterViewController *vc = [[RegisterViewController alloc] initWithNibName:@"RegisterViewController" bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:vc animated:YES];
}


@end
