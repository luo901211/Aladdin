//
//  ServerListViewModel.h
//  Aladdin
//
//  Created by luo on 2017/4/16.
//  Copyright © 2017年 wenqi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ServerListViewModel : NSObject

@property (nonatomic, strong) NSMutableArray *serverList;

- (void)loadServerListWithPageIndex:(NSInteger)pageIndex success:(void (^)(BOOL noMoreData))success failure:(void (^)(NSError *error))failure;

@end
