//
//  ALDFinanceModel.h
//  Aladdin
//
//  Created by luo on 2017/4/23.
//  Copyright © 2017年 wenqi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ALDFinanceModel : NSObject
//{
//    "id": "1",
//    "title": "秘籍1",
//    "desc": "这是秘籍1",
//    "collect_num": "0",
//    "pic_url": "http://api.caishui.com/Uploads/Picture/2017-03-22/58d281a8d3584.png"
//}
@property (nonatomic, assign) NSInteger ID;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, copy) NSString *collect_num;
@property (nonatomic, copy) NSString *pic_url;


@end
