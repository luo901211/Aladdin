//
//  FinanceChapterListViewModel.m
//  Aladdin
//
//  Created by luo on 2017/4/23.
//  Copyright © 2017年 wenqi. All rights reserved.
//

#import "FinanceChapterListViewModel.h"
#import "ALDFinanceChapterModel.h"
@implementation FinanceChapterListViewModel

-(void)loadDataWithID:(NSInteger)ID success:(VoidBlock)success failure:(VoidBlock)failure {
    NSDictionary *params = @{ @"id": @(ID) };
    
    [AFNManagerRequest postWithPath:API_DISCOVER_FINANCE_CHAPTER params:params hudType:NetworkRequestGraceTimeTypeNormal success:^(NSURLResponse *response, id responseObject) {
        NSArray *arrayM = [ALDFinanceChapterModel mj_objectArrayWithKeyValuesArray:responseObject];
        self.list = arrayM.mutableCopy;
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
