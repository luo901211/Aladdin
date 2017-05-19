//
//  NewsCommentListViewModel.h
//  Aladdin
//
//  Created by luo on 2017/5/19.
//  Copyright © 2017年 wenqi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsCommentListViewModel : NSObject

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, strong) NSMutableArray *list;

- (void)loadCommentListWithCompleted:(void (^)(NSError *error))completed;

//- (void)loadDataListWithPageIndex:(NSInteger)pageIndex success:(void (^)(BOOL noMoreData))success failure:(void (^)(NSError *error))failure;

@end
