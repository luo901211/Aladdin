//
//  ExpertDetailViewModel.m
//  Aladdin
//
//  Created by luo on 2017/4/25.
//  Copyright © 2017年 wenqi. All rights reserved.
//

#import "ExpertDetailViewModel.h"
#import "ALDExpertNewsModel.h"
#import "ALDExpertAnswerModel.h"

@implementation ExpertDetailViewModel

- (NSMutableArray *)newsList {
    if (!_newsList) {
        _newsList = [NSMutableArray array];
    }
    return _newsList;
}

- (NSMutableArray *)answerList {
    if (!_answerList) {
        _answerList = [NSMutableArray array];
    }
    return _answerList;
}

-(void)loadDataWithID:(NSInteger)ID success:(VoidBlock)success failure:(VoidBlock)failure {
    NSDictionary *params = @{ @"id": @(ID) };
    
    [AFNManagerRequest postWithPath:API_DISCOVER_EXPERT_DETAIL params:params hudType:NetworkRequestGraceTimeTypeNormal success:^(NSURLResponse *response, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error.localizedDescription);
        }
    }];
}

- (void)loadAnswerListWithID:(NSInteger)ID pageIndex:(NSInteger)pageIndex success:(void (^)(BOOL noMoreData))success failure:(void (^)(NSError *error))failure {
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:@{ @"page_num": @(pageIndex)}];
    [params setObject:@(API_PAGE_SIZE) forKey:@"page_size"];
    [params setObject:@(ID) forKey:@"id"];
    [AFNManagerRequest getWithPath:API_DISCOVER_EXPERT_NEWS_LIST params:params success:^(NSURLResponse *response, id responseObject) {
        NSArray *arrayM = [ALDExpertNewsModel mj_objectArrayWithKeyValuesArray:responseObject];
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

- (void)loadNewsListWithID:(NSInteger)ID pageIndex:(NSInteger)pageIndex success:(void (^)(BOOL noMoreData))success failure:(void (^)(NSError *error))failure {
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:@{ @"page_num": @(pageIndex)}];
    [params setObject:@(API_PAGE_SIZE) forKey:@"page_size"];
    [params setObject:@(ID) forKey:@"id"];
    [AFNManagerRequest getWithPath:API_DISCOVER_EXPERT_ANSWER_LIST params:params success:^(NSURLResponse *response, id responseObject) {
        NSArray *arrayM = [ALDExpertNewsModel mj_objectArrayWithKeyValuesArray:responseObject];
        if (pageIndex == 1) {
            [self.answerList removeAllObjects];
        }
        [self.answerList addObjectsFromArray:arrayM];
        BOOL noMoreData = arrayM.count < API_PAGE_SIZE;
        success(noMoreData);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

@end
