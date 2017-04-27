//
//  UserInfoListViewModel.m
//  Aladdin
//
//  Created by luo on 2017/4/27.
//  Copyright © 2017年 wenqi. All rights reserved.
//

#import "UserInfoListViewModel.h"

@implementation UserInfoListViewModel

- (void)loadDataWithComplete:(void (^)(NSString *msg))complete {
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:[User sharedInstance].token forKey:@"token"];
    [AFNManagerRequest postWithPath:API_USER_INFO params:params hudType:(NetworkRequestGraceTimeTypeNormal) success:^(NSURLResponse *response, id responseObject) {
        self.userInfo = responseObject;
        complete(nil);
    } failure:^(NSError *error) {
        complete(error.localizedDescription);
    }];
}

@end

