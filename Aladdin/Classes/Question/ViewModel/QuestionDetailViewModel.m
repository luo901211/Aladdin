//
//  QuestionDetailViewModel.m
//  Aladdin
//
//  Created by luo on 2017/5/11.
//  Copyright © 2017年 wenqi. All rights reserved.
//

#import "QuestionDetailViewModel.h"

@implementation QuestionDetailViewModel

-(void)loadDataWithID:(NSInteger)ID success:(VoidBlock)success failure:(VoidBlock)failure {
    
    NSDictionary *params = @{ @"id": @(ID) };
    
    [AFNManagerRequest getWithPath:API_QUESTION_DETAIL params:params hudType:NetworkRequestGraceTimeTypeNormal success:^(NSURLResponse *response, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error.localizedDescription);
        }
    }];
}

- (void)setStandardAnswerWithID:(NSInteger)ID
                        success:(VoidBlock)success
                        failure:(VoidBlock)failure {
    NSDictionary *params = @{ @"id": @(ID), @"token": [User sharedInstance].token };
    
    [AFNManagerRequest postWithPath:API_QUESTION_STANDARD params:params hudType:NetworkRequestGraceTimeTypeNormal success:^(NSURLResponse *response, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error.localizedDescription);
        }
    }];
}


- (void)inviteAnswerWithQuestionID:(NSInteger)questionID
                            userID:(NSInteger)userID
                   success:(VoidBlock)success
                   failure:(VoidBlock)failure {
    
    NSDictionary *params = @{ @"question_id": @(questionID), @"user_id": @(userID), @"token": [User sharedInstance].token };
    
    [AFNManagerRequest postWithPath:API_QUESTION_INVITE params:params hudType:NetworkRequestGraceTimeTypeNormal success:^(NSURLResponse *response, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error.localizedDescription);
        }
    }];

}

//token：必传，用户标识
//type：必传，收藏内容分类标识
//id：必传，收藏内容id
- (void)collectDataWithID:(NSInteger)ID
                  success:(VoidBlock)success
                  failure:(VoidBlock)failure {
    NSDictionary *params = @{ @"id": @(ID), @"token": [User sharedInstance].token, @"type": @"question" };
    
    [AFNManagerRequest postWithPath:API_USER_COLLECT_ADD params:params hudType:NetworkRequestGraceTimeTypeNormal success:^(NSURLResponse *response, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error.localizedDescription);
        }
    }];
}

- (void)cancelCollectDataWithID:(NSInteger)ID
                        success:(VoidBlock)success
                        failure:(VoidBlock)failure {
    NSDictionary *params = @{ @"id": @(ID), @"token": [User sharedInstance].token };
    
    [AFNManagerRequest postWithPath:API_USER_COLLECT_CANCEL params:params hudType:NetworkRequestGraceTimeTypeNormal success:^(NSURLResponse *response, id responseObject) {
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
