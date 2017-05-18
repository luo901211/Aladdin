//
//  ALDMessageModel.h
//  Aladdin
//
//  Created by luo on 2017/4/16.
//  Copyright © 2017年 wenqi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ALDMessageModel : NSObject
//{
//    "title": "一个系统消息",
//    "content": "sss",
//    "add_time": "0",
//    "is_read": "1",
//    "pic_url": "http://api.caishui.com/Uploads/Picture/2017-03-22/58d281a8d3584.png"
//}

@property (nonatomic, assign) NSInteger ID;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *add_time;
@property (nonatomic, copy) NSString *is_read;
@property (nonatomic, copy) NSString *pic_url;
@end
