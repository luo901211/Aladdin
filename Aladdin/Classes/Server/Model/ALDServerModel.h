//
//  ServerModel.h
//  Aladdin
//
//  Created by luo on 2017/4/16.
//  Copyright © 2017年 wenqi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ALDServerModel : NSObject
//{
//    "id": "1",
//    "title": "标题标题",
//    "desc": "描述描述",
//    "pic_url": "http://api.caishui.com/Uploads/Picture/2017-03-22/58d281a8d3584.png"
//}
@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, copy) NSString *pic_url;

@end
