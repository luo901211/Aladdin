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

@property (nonatomic, strong) NSArray *messageList;

- (void)getMessageListWithType:(NSInteger)type
                       Success:(VoidBlock)success
                       failure:(VoidBlock)failure;
@end
