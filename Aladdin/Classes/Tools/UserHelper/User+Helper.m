//
//  User+Helper.m
//  Aladdin
//
//  Created by luo on 2017/4/16.
//  Copyright © 2017年 wenqi. All rights reserved.
//

#import "User+Helper.h"

@implementation User (Helper)

- (void)getUserinfo {
    if (!self.token) return;
    
    NSDictionary *params = @{ @"token": self.token };
    [AFNManagerRequest postWithPath:API_USER_INFO params:params success:^(NSURLResponse *response, id responseObject) {
        
        self.mobile = responseObject[@"mobile"];
        self.real_name = responseObject[@"real_name"];
        self.address = responseObject[@"address"];
        self.company = responseObject[@"company"];
        self.position = responseObject[@"position"];
        self.pic_url = responseObject[@"pic_url"];
        
        [self save];
        
    } failure:^(NSError *error) {
        NSLog(@"拉去用户信息失败");
        NSLog(@"error: %@",error);
    }];
}

- (void)checkToken {
    NSDictionary *params = @{ @"token": self.token };
    [AFNManagerRequest postWithPath:API_TOKEN_CHECK params:params success:^(NSURLResponse *response, id responseObject) {
    } failure:^(NSError *error) {
        [self logout];
    }];
}

+ (void)presentLoginViewController {
    LoginVC *logInVc = [[LoginVC alloc] initWithNibName:@"LoginVC" bundle:[NSBundle mainBundle]];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:logInVc];
    [[UIApplication sharedApplication].delegate.window.rootViewController presentViewController:nav animated:YES completion:nil];
}

@end
