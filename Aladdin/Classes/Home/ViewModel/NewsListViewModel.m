//
//  NewsViewModel.m
//  Aladdin
//
//  Created by luo on 2017/4/8.
//  Copyright © 2017年 wenqi. All rights reserved.
//

#import "NewsListViewModel.h"
#import "ALDNewsModel.h"
#import "ALDNewsBannerModel.h"

@implementation NewsListViewModel

- (NSMutableArray *)newsList {
    if (!_newsList) {
        _newsList = [NSMutableArray array];
    }
    return _newsList;
}

- (NSMutableArray *)bannerList {
    if (!_bannerList) {
        _bannerList = [NSMutableArray array];
    }
    return _bannerList;
}

/**
 *  获取资讯列表模型
 */
- (void)loadNewsListWithPageIndex:(NSInteger)pageIndex success:(void (^)(BOOL noMoreData))success failure:(void (^)(NSError *error))failure {
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:@{ @"page_num": @(pageIndex)}];
    if (self.ID) {
        [params setObject:@(self.ID) forKey:@"type"];
    }
    [AFNManagerRequest getWithPath:NEWS_LIST params:params success:^(NSURLResponse *response, id responseObject) {
        NSArray *arrayM = [ALDNewsModel mj_objectArrayWithKeyValuesArray:responseObject];
        if (pageIndex == 1) {
            [self.newsList removeAllObjects];
        }
        [self.newsList addObjectsFromArray:arrayM];
        BOOL noMoreData = arrayM.count < API_PAGE_SIZE;
        success(noMoreData);
    } failure:^(NSError *error) {
        failure(error);
    }];

}

/**
 *  获取轮播图模型
 */
- (void)loadBannerListWithCompleted:(void (^)(NSError *error))completed {
    
    [AFNManagerRequest getWithPath:NEWS_BANNER_LIST params:nil success:^(NSURLResponse *response, id responseObject) {
        NSArray *arrayM = [ALDNewsBannerModel mj_objectArrayWithKeyValuesArray:responseObject];
        self.bannerList = [arrayM mutableCopy];
        completed(nil);
    } failure:^(NSError *error) {
        completed(error);
    }];
}

@end
