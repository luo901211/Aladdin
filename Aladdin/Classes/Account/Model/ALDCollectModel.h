//
//  ALDCollectModel.h
//  Aladdin
//
//  Created by luo on 2017/4/19.
//  Copyright © 2017年 wenqi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ALDCollectModel : NSObject
//{
//    "id": "2",
//    "collect_time": "2017-04-02",
//    "type": "资讯新闻",
//    "title": "北京广州等4城同日出台限购 半月内已有16城加码",
//    "publish_time": "2017-03-18"
//}

@property (nonatomic, assign) NSInteger ID;
@property (nonatomic, copy) NSString *collect_time;
@property (nonatomic, copy) NSString *add_time;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *publish_time;


@end
