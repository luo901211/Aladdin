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

@end
