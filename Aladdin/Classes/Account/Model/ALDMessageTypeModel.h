//
//  ALDMessageTypeModel.h
//  Aladdin
//
//  Created by luo on 2017/4/16.
//  Copyright © 2017年 wenqi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ALDMessageTypeModel : NSObject

@property (nonatomic, assign) NSInteger type;
@property (nonatomic, copy) NSString *type_name;
@property (nonatomic, assign) BOOL is_new;
@property (nonatomic, copy) NSString *msg;

@end
