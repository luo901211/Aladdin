//
//  MessageListViewModel.h
//  Aladdin
//
//  Created by luo on 2017/4/16.
//  Copyright © 2017年 wenqi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ALDMessageModel.h"

@interface MessageListViewModel : NSObject

@property (nonatomic, strong) NSMutableArray *list;

- (void)loadDataListWithPageIndex:(NSInteger)pageIndex type:(NSInteger)type success:(void (^)(BOOL noMoreData))success failure:(void (^)(NSError *error))failure;

@end
