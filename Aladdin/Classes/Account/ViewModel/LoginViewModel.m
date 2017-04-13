//
//  LoginViewModel.m
//  Aladdin
//
//  Created by luo on 2017/4/13.
//  Copyright © 2017年 wenqi. All rights reserved.
//

#import "LoginViewModel.h"

@implementation LoginViewModel

- (void)loginWithPhone:(NSString *)phone
              password:(NSString *)password
               success:(VoidBlock)success
               failure:(VoidBlock)failure {
    
    // 检验 手机号 密码 的合法性
    
    NSDictionary *params = @{ @"mobile": phone, @"password": password };
    
    [self postLoginWithUrl:API_LOGIN_PASSWORD params:params success:^(id obj) {
        if (success) {
            success(obj);
        }
    } failure:^(id obj) {
        if (failure) {
            failure(obj);
        }
    }];
}

- (void)loginWithPhone:(NSString *)phone
                  code:(NSString *)code
               success:(VoidBlock)success
               failure:(VoidBlock)failure {
    
    // 检验 手机号 验证码 的合法性
    
    NSDictionary *params = @{ @"mobile": phone, @"code": code };

    [self postLoginWithUrl:API_LOGIN_CODE params:params success:^(id obj) {
        if (success) {
            success(obj);
        }
    } failure:^(id obj) {
        if (failure) {
            failure(obj);
        }
    }];
}

- (void)postLoginWithUrl:(NSString *)url params:(NSDictionary *)params success:(VoidBlock)success failure:(VoidBlock)failure {
    
    [AFNManagerRequest postWithPath:url params:params success:^(NSURLResponse *response, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

- (void)getCodeWithPhone:(NSString *)phone
                 success:(VoidBlock)success
                 failure:(VoidBlock)failure {
    
    // 检验参数合法性
    
    NSDictionary *params = @{ @"mobile": phone};
    
    
    [AFNManagerRequest postWithPath:API_SENDCODE params:params success:^(NSURLResponse *response, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
