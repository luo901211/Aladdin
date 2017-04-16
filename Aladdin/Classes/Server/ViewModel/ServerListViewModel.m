//
//  ServerListViewModel.m
//  Aladdin
//
//  Created by luo on 2017/4/16.
//  Copyright © 2017年 wenqi. All rights reserved.
//

#import "ServerListViewModel.h"
#import "ALDServerModel.h"

@implementation ServerListViewModel

- (NSMutableArray *)serverList {
    if (!_serverList) {
        _serverList = [NSMutableArray array];
    }
    return _serverList;
}

/**
 *  获取平台服务列表模型
 */
- (void)loadServerListWithPageIndex:(NSInteger)pageIndex success:(void (^)(BOOL noMoreData))success failure:(void (^)(NSError *error))failure {
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:@{ @"page_num": @(pageIndex)}];
    [AFNManagerRequest getWithPath:API_SERVER_LIST params:params success:^(NSURLResponse *response, id responseObject) {
        NSArray *arrayM = [ALDServerModel mj_objectArrayWithKeyValuesArray:responseObject];
        if (pageIndex == 1) {
            [self.serverList removeAllObjects];
        }
        [self.serverList addObjectsFromArray:arrayM];
        BOOL noMoreData = arrayM.count < API_PAGE_SIZE;
        success(noMoreData);
    } failure:^(NSError *error) {
        failure(error);
    }];
    
}


@end
