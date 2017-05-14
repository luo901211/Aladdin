//
//  MessageListViewModel.m
//  Aladdin
//
//  Created by luo on 2017/4/16.
//  Copyright © 2017年 wenqi. All rights reserved.
//

#import "MessageListViewModel.h"

@implementation MessageListViewModel

- (NSMutableArray *)list {
    if (!_list) {
        _list = [NSMutableArray array];
    }
    return _list;
}

- (void)loadDataListWithPageIndex:(NSInteger)pageIndex type:(NSInteger)type success:(void (^)(BOOL noMoreData))success failure:(void (^)(NSError *error))failure {
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:@{ @"page_num": @(pageIndex)}];
    [params setObject:@(type) forKey:@"type"];
    [params setObject:[User sharedInstance].token forKey:@"token"];
    
    [AFNManagerRequest postWithPath:API_USER_MSGLIST params:params success:^(NSURLResponse *response, id responseObject) {
        NSArray *arrayM = [ALDMessageModel mj_objectArrayWithKeyValuesArray:responseObject];
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
