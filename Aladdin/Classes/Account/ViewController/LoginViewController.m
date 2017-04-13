//
//  LoginViewController.m
//  Aladdin
//
//  Created by luo on 2017/4/13.
//  Copyright © 2017年 wenqi. All rights reserved.
//

#import "LoginViewController.h"

#define kBannerHeight (238.0 * kScreenWidthRatio)
#define kItemWidth 261.0
#define kItemHeight 44.0

#define kMiniBtnWidth 60

@interface LoginViewController ()

@property (strong, nonatomic) UITextField *phoneTextField;
@property (strong, nonatomic) UITextField *pwdTextField;

@property (strong, nonatomic) UIView *inputContainerView;
@property (strong, nonatomic) UIView *loginContainerView;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self initUI];
}

- (UIView *)loginContainerView {
    if (!_loginContainerView) {

        _loginContainerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 100)];
        
        CGFloat left = (Main_Screen_Width - kItemWidth) / 2;

        UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        loginBtn.frame = CGRectMake(left, 0, kItemWidth, kItemHeight);
        [loginBtn setBackgroundImage:[UIImage imageNamed:@"login_btn_bg"] forState:UIControlStateNormal];
        [_loginContainerView addSubview:loginBtn];

        UIButton *forgetPwdBtn = [self setupMiniButtonWithFrame:CGRectMake(left, loginBtn.bottom, kMiniBtnWidth, 30) title:@"忘记密码?" titleColor:HEXCOLOR(0xc4c8d1)];
        [_loginContainerView addSubview:forgetPwdBtn];
        
        UIButton *registerBtn = [self setupMiniButtonWithFrame:CGRectMake(loginBtn.right - kMiniBtnWidth, loginBtn.bottom, kMiniBtnWidth, 30) title:@"我要注册" titleColor:GLOBAL_TINT_COLOR];
        [_loginContainerView addSubview:registerBtn];
        
    }
    return _loginContainerView;
}

- (void)initUI {

    CGFloat left = (Main_Screen_Width - kItemWidth) / 2;
    CGFloat top = kBannerHeight + 35;
    
    self.phoneTextField = [self setupTextFieldWithFrame:CGRectMake(left, top, kItemWidth, kItemHeight) leftImageName:@"icon_phone" placeholder:@"输入手机号"];
    self.phoneTextField.keyboardType = UIKeyboardTypePhonePad;
    [self.view addSubview:self.phoneTextField];
    
    self.pwdTextField = [self setupTextFieldWithFrame:CGRectMake(left, top + kItemHeight + 15, kItemWidth, kItemHeight) leftImageName:@"icon_pwd" placeholder:@"输入密码"];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 44, 44);
    [button setImage:[UIImage imageNamed:@"icon_pwd_show"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"icon_pwd_hidden"] forState:UIControlStateSelected];
    [button setContentMode:(UIViewContentModeCenter)];
    [button addTarget:self action:@selector(didPressedOnPasswordButton:) forControlEvents:UIControlEventTouchUpInside];
    button.selected = YES;
    self.pwdTextField.rightViewMode = UITextFieldViewModeAlways;
    self.pwdTextField.rightView = button;
    self.pwdTextField.secureTextEntry = YES;
    [self.view addSubview:self.pwdTextField];
    
    
    self.loginContainerView.top = self.pwdTextField.bottom + 20;
    [self.view addSubview:self.loginContainerView];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)didPressedOnPasswordButton:(UIButton *)button {
    button.selected = !button.selected;
    self.pwdTextField.secureTextEntry = button.selected;
}

@end
