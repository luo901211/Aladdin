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

- (void)submitQuestionWithTitle:(NSString *)title
                        content:(NSString *)content
                       expertID:(NSInteger)expertID
                           pics:(NSMutableArray *)pics
                       progress:(VoidBlock)progressBlock
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

    [AFNManagerRequest uploadImagesWithPath:API_QUESTION_ASK params:params images:pics progress:^(CGFloat progress) {
        if (progressBlock) {
            progressBlock(@(progress));
        }
    } success:^(NSURLResponse *response, id responseObject) {
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
