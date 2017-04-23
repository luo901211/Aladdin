//
//  ALDExpertModel.h
//  Aladdin
//
//  Created by luo on 2017/4/23.
//  Copyright © 2017年 wenqi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ALDExpertModel : NSObject
//"res": [{
//    "id": "2",
//    "real_name": "温彦磊啊",
//    "company": "无忧英语",
//    "position": "放顶顶顶顶顶",
//    "pic_url": "http://api.caishui.com/Uploads/Picture/2017-03-22/58d281a8d3584.png"
//}],
@property (nonatomic, assign) NSInteger ID;
@property (nonatomic, copy) NSString *real_name;
@property (nonatomic, copy) NSString *company;
@property (nonatomic, copy) NSString *position;
@property (nonatomic, copy) NSString *pic_url;


@end
