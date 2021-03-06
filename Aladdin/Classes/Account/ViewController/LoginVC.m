//
//  LoginViewController.m
//  Aladdin
//
//  Created by luo on 2017/4/13.
//  Copyright © 2017年 wenqi. All rights reserved.
//

#import "LoginVC.h"
#import "RegisterVC.h"
#import "FindPasswordVC.h"
#import "UINavigationBar+Awesome.h"
#import "LoginViewModel.h"
#import "User+Helper.h"

#define kBannerHeight (238.0 * kScreenWidthRatio)
#define kTop (238.0 * kScreenWidthRatio) + 35
#define kLeft (Main_Screen_Width - kItemWidth) / 2
#define kItemWidth 261.0
#define kItemHeight 44.0

#define kMiniBtnWidth 80
#define kMiniBtnHeight 40

@interface LoginVC ()

@property (strong, nonatomic) UITextField *phoneTextField;
@property (strong, nonatomic) UITextField *codeTextField;
@property (strong, nonatomic) UITextField *pwdTextField;

@property (assign, nonatomic) BOOL loginTypePassword;
@property (weak, nonatomic) IBOutlet UIButton *passwordLoginBtn;
@property (weak, nonatomic) IBOutlet UIButton *codeLoginBtn;

@property (strong, nonatomic) UIView *inputContainerView;
@property (strong, nonatomic) UIView *loginContainerView;

@property (strong, nonatomic) LoginViewModel *viewModel;
@property (strong, nonatomic) UIImage *selectedButtonImage;

@end

@implementation LoginVC

- (void)dismiss {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor clearColor]];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
    [self initUI];
}

- (void)initUI {
    
    UIBarButtonItem *dismissBarItem = [[UIBarButtonItem alloc] initWithTitle:@"关闭" style:(UIBarButtonItemStylePlain) target:self action:@selector(dismiss)];
    self.navigationItem.leftBarButtonItem = dismissBarItem;
    
    [self.view addSubview:self.phoneTextField];
    [self.view addSubview:self.pwdTextField];
    [self.view addSubview:self.codeTextField];
    [self.view addSubview:self.loginContainerView];
    
    [self.passwordLoginBtn setBackgroundImage:self.selectedButtonImage forState:UIControlStateSelected];
    [self.codeLoginBtn setBackgroundImage:self.selectedButtonImage forState:UIControlStateSelected];

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

- (UIImage *)selectedButtonImage {
    if (!_selectedButtonImage) {
        CGFloat width = Main_Screen_Width / 2;
        CGGlyph height = 44;
        
        CGFloat triangleWidth = 12;
        CGFloat triangleHeight = 8;
        UIColor *tintColor = [UIColor whiteColor];
        
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(width, height), NO, [UIScreen mainScreen].scale);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextBeginPath(UIGraphicsGetCurrentContext());
        {
            CGPoint sPoints[3];//坐标点
            sPoints[0] =CGPointMake(width/2 - triangleWidth/2, height);//坐标1
            sPoints[1] =CGPointMake((width/2) , height - triangleHeight);//坐标2
            sPoints[2] =CGPointMake(width/2 + triangleWidth/2, height);//坐标3
            CGContextAddLines(context, sPoints,3);//添加线
            CGContextClosePath(context);//封起来
            CGContextSetStrokeColorWithColor(context, tintColor.CGColor);
            CGContextSetFillColorWithColor(context, tintColor.CGColor);
            CGContextDrawPath(context,kCGPathFillStroke);//根据坐标绘制路径

        }
        _selectedButtonImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
    }
    return _selectedButtonImage;
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
        [getCodeBtn addTarget:self action:@selector(didPressedOnGetCodeButton:) forControlEvents:(UIControlEventTouchUpInside)];
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

- (void)didPressedOnGetCodeButton:(UIButton *)button {
    
    NSString *phone = self.phoneTextField.text;
    
    [self.viewModel getCodeWithPhone:phone success:^(id obj) {
        [MBProgressHUD showAutoMessage:@"验证码已发送"];
    } failure:^(id obj) {
        [MBProgressHUD showAutoMessage:obj];
    }];
}

- (void)didPressedOnLoginButton:(UIButton *)button {
    
    NSString *phone = self.phoneTextField.text;
    NSString *password = self.pwdTextField.text;
    NSString *code = self.codeTextField.text;
    
    @weakify(self);
    
    VoidBlock success = ^(id obj){
        @strongify(self);
        [User sharedInstance].token = obj[@"token"];
        [[User sharedInstance] save];
        [[User sharedInstance] getUserinfo];
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotification_Login object:nil];
        [self dismissViewControllerAnimated:YES completion:nil];
    };
    
    VoidBlock failure = ^(id obj){
        [MBProgressHUD showAutoMessage:obj];
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
    FindPasswordVC *vc = [[FindPasswordVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didPressedOnRegisterButton:(UIButton *)button {
    RegisterVC *vc = [[RegisterVC alloc] initWithNibName:@"RegisterVC" bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
