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

@end
