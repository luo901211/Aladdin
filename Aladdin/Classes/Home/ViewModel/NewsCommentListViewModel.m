//
//  NewsCommentListViewModel.m
//  Aladdin
//
//  Created by luo on 2017/5/19.
//  Copyright © 2017年 wenqi. All rights reserved.
//

#import "NewsCommentListViewModel.h"
#import "ALDNewsCommentModel.h"

@implementation NewsCommentListViewModel

- (NSMutableArray *)list {
    if (!_list) {
        _list = [NSMutableArray array];
    }
    return _list;
}

- (void)loadCommentListWithCompleted:(void (^)(NSError *error))completed {

    NSDictionary *params = @{ @"id": @(self.ID) };
    
    [AFNManagerRequest getWithPath:NEWS_COMMENT_LIST params:params success:^(NSURLResponse *response, id responseObject) {
        NSArray *arrayM = [ALDNewsCommentModel mj_objectArrayWithKeyValuesArray:responseObject];
        self.list = arrayM.mutableCopy;
        if (completed) {
            completed(nil);
        }
    } failure:^(NSError *error) {
        completed(error);
    }];
}
/**
 *  获取资讯列表模型
 */
//- (void)loadDataListWithPageIndex:(NSInteger)pageIndex success:(void (^)(BOOL noMoreData))success failure:(void (^)(NSError *error))failure {
//    
//    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:@{ @"page_num": @(pageIndex)}];
//    if (self.ID) {
//        [params setObject:@(self.ID) forKey:@"id"];
//    }
//    [AFNManagerRequest getWithPath:NEWS_COMMENT_LIST params:params success:^(NSURLResponse *response, id responseObject) {
//        NSArray *arrayM = [ALDNewsCommentModel mj_objectArrayWithKeyValuesArray:responseObject];
//        if (pageIndex == 1) {
//            [self.list removeAllObjects];
//        }
//        [self.list addObjectsFromArray:arrayM];
//        BOOL noMoreData = arrayM.count < API_PAGE_SIZE;
//        success(noMoreData);
//    } failure:^(NSError *error) {
//        failure(error);
//    }];
//    
//}

@end
