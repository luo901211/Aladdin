//
//  QuestionListViewModel.m
//  Aladdin
//
//  Created by luo on 2017/4/25.
//  Copyright © 2017年 wenqi. All rights reserved.
//

#import "QuestionListViewModel.h"
#import "ALDQuestionModel.h"

@implementation QuestionListViewModel

- (NSMutableArray *)list {
    if (!_list) {
        _list = [NSMutableArray array];
    }
    return _list;
}

- (void)loadDataListWithPageIndex:(NSInteger)pageIndex type:(QuestionType)type success:(void (^)(BOOL noMoreData))success failure:(void (^)(NSError *error))failure {
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:@{ @"page_num": @(pageIndex)}];
    switch (type) {
        case QuestionTypeEssence:
        {
            [params setObject:@(1) forKey:@"is_essence"];
        }
            break;
        case QuestionTypeNotEssence:
        {
            [params setObject:@(0) forKey:@"is_essence"];
        }
            break;
        case QuestionTypeUser:
        {
            [params setObject:[User sharedInstance].token forKey:@"token"];
        }
            break;
            
        default:
            break;
    }
    
    NSLog(@"params: %@", params);
    
    [AFNManagerRequest getWithPath:API_SERVER_LIST params:params success:^(NSURLResponse *response, id responseObject) {
        NSArray *arrayM = [ALDQuestionModel mj_objectArrayWithKeyValuesArray:responseObject];
        if (pageIndex == 1) {
            [self.list removeAllObjects];
        }
        [self.list addObjectsFromArray:arrayM];
        BOOL noMoreData = arrayM.count < API_PAGE_SIZE;
        success(noMoreData);
    } failure:^(NSError *error) {
        failure(error);
    }];
    
}

@end
