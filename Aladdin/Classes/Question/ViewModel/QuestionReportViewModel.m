//
//  QuestionReportViewModel.m
//  Aladdin
//
//  Created by luo on 2017/5/14.
//  Copyright © 2017年 wenqi. All rights reserved.
//

#import "QuestionReportViewModel.h"

@implementation QuestionReportViewModel

- (void)submitQuestionWithTitle:(NSString *)title
                        content:(NSString *)content
                       expertID:(NSInteger)expertID
                           pics:(NSMutableArray *)pics
                        success:(VoidBlock)success
                        failure:(VoidBlock)failure {
    NSMutableDictionary *params = @{
                              @"title": title,
                              @"content": content,
                              @"token": [User sharedInstance].token,
                              }.mutableCopy;
    if (expertID) {
        [params setObject:@(expertID) forKey:@"to_user_id"];
    }
    if (pics.count) {
        [params setObject:pics forKey:@"pics"];
    }
    //图片 pics
    
    [AFNManagerRequest postWithPath:API_QUESTION_ASK params:params hudType:NetworkRequestGraceTimeTypeNormal success:^(NSURLResponse *response, id responseObject) {
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
