//
//  ChangePasswordViewModel.m
//  Aladdin
//
//  Created by luo on 2017/4/27.
//  Copyright © 2017年 wenqi. All rights reserved.
//

#import "ChangePasswordViewModel.h"

@implementation ChangePasswordViewModel

- (void)changePasswordWithPassword:(NSString *)password newPassword:(NSString *)newPassword rePassword:(NSString *)rePassword complete:(void (^)(NSString *msg))complete {
//    token：必传，用户标识
//    old：必传，旧密码
//    new：必传，新密码
//    confirm：必传，确认密码
    
    if (!password.length) {
        return complete(@"请输入原密码");
    }
    if (!newPassword.length) {
        return complete(@"请输入新密码");
    }
    if (!rePassword.length) {
        return complete(@"请输入确认密码");
    }
    if (![rePassword isEqualToString:newPassword]) {
        return complete(@"确认密码输入不一致");
    }
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:[User sharedInstance].token forKey:@"token"];
    [params setObject:password forKey:@"old"];
    [params setObject:newPassword forKey:@"new"];
    [params setObject:rePassword forKey:@"confirm"];
    
    [AFNManagerRequest postWithPath:API_CHANGE_PASSWORD params:params hudType:(NetworkRequestGraceTimeTypeNormal) success:^(NSURLResponse *response, id responseObject) {
        complete(nil);
    } failure:^(NSError *error) {
        complete(error.localizedDescription);
    }];

}

@end
