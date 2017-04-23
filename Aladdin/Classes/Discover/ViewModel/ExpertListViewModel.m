//
//  ExpertListViewModel.m
//  Aladdin
//
//  Created by luo on 2017/4/23.
//  Copyright © 2017年 wenqi. All rights reserved.
//

#import "ExpertListViewModel.h"
#import "ALDExpertModel.h"

@implementation ExpertListViewModel
- (NSMutableArray *)list {
    if (!_list) {
        _list = [NSMutableArray array];
    }
    return _list;
}

- (void)loadDataListWithLevel:(NSInteger)level pageIndex:(NSInteger)pageIndex success:(void (^)(BOOL noMoreData))success failure:(void (^)(NSError *error))failure {
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:@{ @"page_num": @(pageIndex)}];
    [params setObject:@(API_PAGE_SIZE) forKey:@"page_size"];
    [params setObject:@(level) forKey:@"level"];
    [AFNManagerRequest getWithPath:API_DISCOVER_EXPERT_LIST params:params success:^(NSURLResponse *response, id responseObject) {
        NSArray *arrayM = [ALDExpertModel mj_objectArrayWithKeyValuesArray:responseObject];
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
