//
//  ALDAnswerModel.h
//  Aladdin
//
//  Created by luo on 2017/5/11.
//  Copyright © 2017年 wenqi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ALDAnswerModel : NSObject
//"id":1,
//"real_name": "温彦磊啊",
//"mobile": "18201689539",
//"pic_url": "http://api.caishui.com/Uploads/Picture/2017-03-22/58d281a8d3584.png",
//"content": "啥意思",
//"add_time": "2017-03-07 20:14:48",
//"add_date": "2017-03-07",
//"is_standard": "0"

@property (assign, nonatomic) NSInteger ID;
@property (copy, nonatomic) NSString *real_name;
@property (copy, nonatomic) NSString *mobile;
@property (copy, nonatomic) NSString *pic_url;
@property (copy, nonatomic) NSString *content;
@property (copy, nonatomic) NSString *add_time;
@property (copy, nonatomic) NSString *add_date;
@property (assign, nonatomic) BOOL is_standard;

@end
