//
//  MessageTypeViewModel.h
//  Aladdin
//
//  Created by luo on 2017/4/16.
//  Copyright © 2017年 wenqi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ALDMessageTypeModel.h"

@interface MessageTypeViewModel : NSObject

@property (nonatomic, strong) NSArray *messageTypeList;

- (void)getMessageTypeWithSuccess:(VoidBlock)success
                          failure:(VoidBlock)failure;
@end
