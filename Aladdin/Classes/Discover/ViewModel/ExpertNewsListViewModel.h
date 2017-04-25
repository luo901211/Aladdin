//
//  ExpertNewsListViewModel.h
//  Aladdin
//
//  Created by luo on 2017/4/25.
//  Copyright © 2017年 wenqi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ExpertNewsListViewModel : NSObject

@property (nonatomic, strong) NSMutableArray *list;

- (void)loadDataListWithID:(NSInteger)ID pageIndex:(NSInteger)pageIndex success:(void (^)(BOOL noMoreData))success failure:(void (^)(NSError *error))failure;

@end
