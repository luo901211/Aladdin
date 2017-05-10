//
//  PolicyListViewModel.m
//  Aladdin
//
//  Created by luo on 2017/4/21.
//  Copyright © 2017年 wenqi. All rights reserved.
//

#import "PolicyListViewModel.h"
#import "ALDPolicyModel.h"

@implementation PolicyListViewModel
- (NSMutableArray *)list {
    if (!_list) {
        _list = [NSMutableArray array];
    }
    return _list;
}

- (void)loadDataListWithID:(NSInteger)ID pageIndex:(NSInteger)pageIndex success:(void (^)(BOOL noMoreData))success failure:(void (^)(NSError *error))failure {
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:@{ @"page_num": @(pageIndex)}];
    [params setObject:@(API_PAGE_SIZE) forKey:@"page_size"];
    if (ID) {
        [params setObject:@(ID) forKey:@"id"];
    }
    [AFNManagerRequest getWithPath:API_DISCOVER_POLICY_LIST params:params success:^(NSURLResponse *response, id responseObject) {
        NSArray *arrayM = [ALDPolicyModel mj_objectArrayWithKeyValuesArray:responseObject];
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
