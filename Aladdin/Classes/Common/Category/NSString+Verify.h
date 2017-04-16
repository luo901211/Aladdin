//
//  NSString+Verify.h
//  Aladdin
//
//  Created by luo on 2017/4/16.
//  Copyright © 2017年 wenqi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Verify)
//邮箱
- (BOOL) validateEmail;

//手机号码验证
- (BOOL) validateMobile;

//用户名
- (BOOL) validateUserName;

//密码
- (BOOL) validatePassword;

//昵称
- (BOOL) validateNickname;

//身份证号
- (BOOL) validateIdentityCard;

//手机验证码
- (BOOL) validateMobileCode;

@end
