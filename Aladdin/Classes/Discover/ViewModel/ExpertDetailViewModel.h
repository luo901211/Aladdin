//
//  ExpertDetailViewModel.h
//  Aladdin
//
//  Created by luo on 2017/4/25.
//  Copyright © 2017年 wenqi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ExpertDetailViewModel : NSObject

@property (nonatomic, strong) NSMutableArray *answerList;
@property (nonatomic, strong) NSMutableArray *newsList;

- (void)loadDataWithID:(NSInteger)ID
               success:(VoidBlock)success
               failure:(VoidBlock)failure;


- (void)loadAnswerListWithID:(NSInteger)ID pageIndex:(NSInteger)pageIndex success:(void (^)(BOOL noMoreData))success failure:(void (^)(NSError *error))failure;

- (void)loadNewsListWithID:(NSInteger)ID pageIndex:(NSInteger)pageIndex success:(void (^)(BOOL noMoreData))success failure:(void (^)(NSError *error))failure;

@end
