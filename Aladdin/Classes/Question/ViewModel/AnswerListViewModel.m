//
//  AnswerListViewModel.m
//  Aladdin
//
//  Created by luo on 2017/5/14.
//  Copyright © 2017年 wenqi. All rights reserved.
//

#import "AnswerListViewModel.h"
#import "ALDQuestionModel.h"

@implementation AnswerListViewModel
- (NSMutableArray *)list {
    if (!_list) {
        _list = [NSMutableArray array];
    }
    return _list;
}

- (void)loadDataListWithPageIndex:(NSInteger)pageIndex
                          success:(void (^)(BOOL noMoreData))success
                          failure:(void (^)(NSError *error))failure {
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:@{ @"page_num": @(pageIndex)}];
    [params setObject:[User sharedInstance].token forKey:@"token"];
    
    [AFNManagerRequest postWithPath:API_QUESTION_ANSWER_LIST_USER params:params success:^(NSURLResponse *response, id responseObject) {
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
