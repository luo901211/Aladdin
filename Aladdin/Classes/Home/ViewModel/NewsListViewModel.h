//
//  NewsViewModel.h
//  Aladdin
//
//  Created by luo on 2017/4/8.
//  Copyright © 2017年 wenqi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsListViewModel : NSObject

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, strong) NSMutableArray *bannerList;

@property (nonatomic, strong) NSMutableArray *list;


- (void)loadDataListWithPageIndex:(NSInteger)pageIndex success:(void (^)(BOOL noMoreData))success failure:(void (^)(NSError *error))failure;

/**
 *  获取轮播图模型
 */
- (void)loadBannerListWithCompleted:(void (^)(NSError *error))completed;



@end
