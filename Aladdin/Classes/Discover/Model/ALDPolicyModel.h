//
//  ALDPolicyModel.h
//  Aladdin
//
//  Created by luo on 2017/4/21.
//  Copyright © 2017年 wenqi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ALDPolicyModel : NSObject
//{
//    "id": "1",
//    "title": "政策法规",
//    "number": "111111",
//    "publish_time": "2015-10-10"
//}
@property (nonatomic, assign) NSInteger ID;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *number;
@property (nonatomic, copy) NSString *publish_time;

@end
