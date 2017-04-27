//
//  LoginViewModel.m
//  Aladdin
//
//  Created by luo on 2017/4/13.
//  Copyright © 2017年 wenqi. All rights reserved.
//

#import "LoginViewModel.h"
#import "NSString+Verify.h"
#import "ApiMacros.h"
#import <AFURLSessionManager.h>

@implementation LoginViewModel

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

- (void)loginWithPhone:(NSString *)phone
              password:(NSString *)password
               success:(VoidBlock)success
               failure:(VoidBlock)failure {
    
    // 检验 手机号 密码 的合法性
    if (![phone validateMobile]) {
        return failure(@"请输入有效的手机号");
    }
    if (![password validatePassword]) {
        return failure(@"请输入有效的密码");
    }
    
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
    if (![phone validateMobile]) {
        return failure(@"请输入有效的手机号");
    }
    if (![code validateMobileCode]) {
        return failure(@"请输入有效的验证码");
    }
    
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
    
    
    NSString *URLString = [SERVER_HOST stringByAppendingPathComponent:url];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"POST" URLString:URLString parameters:params error:nil];
    
    // 网络指示器
    MBProgressHUD *hud = [MBProgressHUD hudWithNetworkType:NetworkRequestGraceTimeTypeNormal];
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        
        // 任务结束，隐藏网络指示器
        [hud hideAnimated:YES];
        
        if (error) {
            if (failure) {
                failure(responseObject[@"msg"]);
            }
        } else {

            // 统一处理错误
            NSInteger code = [responseObject[@"code"] integerValue];
            if (code == 1) {
                if (success) {
                    NSDictionary *res = @{ @"token": responseObject[@"msg"] };
                    success(res);
                }
            } else {
                if (failure) {
                    failure(responseObject[@"msg"]);
                }
            }
            
        }
    }];
    [dataTask resume];
}


@end
