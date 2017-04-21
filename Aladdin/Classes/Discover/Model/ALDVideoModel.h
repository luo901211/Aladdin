//
//  ALDVideoModel.h
//  Aladdin
//
//  Created by luo on 2017/4/21.
//  Copyright © 2017年 wenqi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ALDVideoModel : NSObject
//{
//    "id": "1",
//    "title": "北京医药分开综合改革下月实施 取消药品加成和挂号费",
//    "view_num": "0",
//    "pic_url": "http://api.caishui.com/Uploads/Picture/2017-03-22/58d281a8d3584.png"
//}

@property (nonatomic, assign) NSInteger ID;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *view_num;
@property (nonatomic, copy) NSString *pic_url;
@end
