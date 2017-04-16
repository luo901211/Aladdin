//
//  MessageTypeViewModel.m
//  Aladdin
//
//  Created by luo on 2017/4/16.
//  Copyright © 2017年 wenqi. All rights reserved.
//

#import "MessageTypeViewModel.h"

@implementation MessageTypeViewModel

- (void)getMessageTypeWithSuccess:(VoidBlock)success
                          failure:(VoidBlock)failure {
    
    NSDictionary *params = @{ @"token": [User sharedInstance].token };
    
    [AFNManagerRequest postWithPath:API_USER_MSGTYPE params:params success:^(NSURLResponse *response, id responseObject) {
        
        self.messageTypeList = [ALDMessageTypeModel mj_objectArrayWithKeyValuesArray:responseObject];
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
