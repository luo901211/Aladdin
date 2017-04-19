//
//  CollectListViewModel.m
//  Aladdin
//
//  Created by luo on 2017/4/19.
//  Copyright © 2017年 wenqi. All rights reserved.
//

#import "CollectListViewModel.h"
#import "ALDCollectModel.h"

@implementation CollectListViewModel

- (NSMutableArray *)collectList {
    if (!_collectList) {
        _collectList = [NSMutableArray array];
    }
    return _collectList;
}

- (void)loadCollectListWithPageIndex:(NSInteger)pageIndex success:(void (^)(BOOL noMoreData))success failure:(void (^)(NSError *error))failure {
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:@{ @"page_num": @(pageIndex)}];
    [params setObject:[User sharedInstance].token forKey:@"token"];
    
    [AFNManagerRequest getWithPath:API_USER_COLLECT_LIST params:params success:^(NSURLResponse *response, id responseObject) {
        NSArray *arrayM = [ALDCollectModel mj_objectArrayWithKeyValuesArray:responseObject];
        if (pageIndex == 1) {
            [self.collectList removeAllObjects];
        }
        [self.collectList addObjectsFromArray:arrayM];
        BOOL noMoreData = arrayM.count < API_PAGE_SIZE;
        success(noMoreData);
    } failure:^(NSError *error) {
        failure(error);
    }];
    
}



@end
