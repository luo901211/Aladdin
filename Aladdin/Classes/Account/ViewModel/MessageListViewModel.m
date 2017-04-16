//
//  MessageListViewModel.m
//  Aladdin
//
//  Created by luo on 2017/4/16.
//  Copyright © 2017年 wenqi. All rights reserved.
//

#import "MessageListViewModel.h"

@implementation MessageListViewModel

- (void)getMessageListWithType:(NSInteger)type
                       Success:(VoidBlock)success
                       failure:(VoidBlock)failure {
    NSDictionary *params = @{ @"token": [User sharedInstance].token, @"type": @(type) };
    
    [AFNManagerRequest postWithPath:API_USER_MSGLIST params:params success:^(NSURLResponse *response, id responseObject) {
        
        self.messageList = [ALDMessageModel mj_objectArrayWithKeyValuesArray:responseObject];
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
