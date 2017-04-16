//
//  RegisterViewModel.m
//  Aladdin
//
//  Created by luo on 2017/4/13.
//  Copyright © 2017年 wenqi. All rights reserved.
//

#import "RegisterViewModel.h"
#import "NSString+Verify.h"

@implementation RegisterViewModel

- (void)registerWithPhone:(NSString *)phone
                 password:(NSString *)password
                     code:(NSString *)code
                  success:(VoidBlock)success
                  failure:(VoidBlock)failure {
    
    // 检验参数合法性
    if (![phone validateMobile]) {
        return failure(@"请输入有效的手机号");
    }
    if (![password validatePassword]) {
        return failure(@"请输入有效的密码");
    }
    if (![code validateMobileCode]) {
        return failure(@"请输入有效的验证码");
    }
    
    NSDictionary *params = @{ @"mobile": phone, @"code": code, @"password": password };
    
    [AFNManagerRequest postWithPath:API_REGISTER params:params hudType:NetworkRequestGraceTimeTypeNormal success:^(NSURLResponse *response, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error.localizedDescription);
        }
    }];
    
}


- (void)getCodeWithPhone:(NSString *)phone
                 success:(VoidBlock)success
                 failure:(VoidBlock)failure {
    
    // 检验参数合法性
    if (![phone validateMobile]) {
        return failure(@"请输入有效的手机号");
    }
    NSDictionary *params = @{ @"mobile": phone};
    
    [AFNManagerRequest postWithPath:API_SENDCODE params:params hudType:NetworkRequestGraceTimeTypeNormal success:^(NSURLResponse *response, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error.localizedDescription);
        }
    }];
}

@end
