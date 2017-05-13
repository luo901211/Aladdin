//
//  AnswerViewModel.m
//  Aladdin
//
//  Created by luo on 2017/5/14.
//  Copyright © 2017年 wenqi. All rights reserved.
//

#import "AnswerViewModel.h"

@implementation AnswerViewModel

- (void)submitAnswer:(NSString *)content
                  id:(NSInteger)ID
             success:(VoidBlock)success
             failure:(VoidBlock)failure {
    NSDictionary *params = @{ @"id": @(ID), @"token": [User sharedInstance].token, @"content": content };
    
    [AFNManagerRequest postWithPath:API_QUESTION_ANSWER params:params hudType:NetworkRequestGraceTimeTypeNormal success:^(NSURLResponse *response, id responseObject) {
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
