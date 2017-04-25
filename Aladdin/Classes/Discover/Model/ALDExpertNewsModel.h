//
//  ALDExpertNewsModel.h
//  Aladdin
//
//  Created by luo on 2017/4/25.
//  Copyright © 2017年 wenqi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ALDExpertNewsModel : NSObject

//"res": [{
//    "id": "1",
//    "title": "北京广州等4城同日出台限购 半月内已有16城加码",
//    "view_num": "0",
//    "add_time": "2017-03-18 14:00:34",
//    "add_date": "2017.03.18"
//}],

@property (nonatomic, assign) NSInteger ID;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *view_num;
@property (nonatomic, copy) NSString *add_time;
@property (nonatomic, copy) NSString *add_date;
@end
