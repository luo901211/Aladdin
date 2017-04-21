//
//  VideoDetailViewModel.m
//  Aladdin
//
//  Created by luo on 2017/4/21.
//  Copyright © 2017年 wenqi. All rights reserved.
//

#import "VideoDetailViewModel.h"

@implementation VideoDetailViewModel

-(void)loadDataWithID:(NSInteger)ID success:(VoidBlock)success failure:(VoidBlock)failure {
    NSDictionary *params = @{ @"id": @(ID), @"token": [User sharedInstance].token };
    
    [AFNManagerRequest postWithPath:API_DISCOVER_VIDEO_DETAIL params:params hudType:NetworkRequestGraceTimeTypeNormal success:^(NSURLResponse *response, id responseObject) {
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
