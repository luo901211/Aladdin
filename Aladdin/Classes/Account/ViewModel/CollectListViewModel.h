//
//  CollectListViewModel.h
//  Aladdin
//
//  Created by luo on 2017/4/19.
//  Copyright © 2017年 wenqi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CollectListViewModel : NSObject

@property (nonatomic, strong) NSMutableArray *list;

- (void)loadDataListWithPageIndex:(NSInteger)pageIndex success:(void (^)(BOOL noMoreData))success failure:(void (^)(NSError *error))failure;

@end
