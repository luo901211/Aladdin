//
//  ALDExpertAnswerModel.h
//  Aladdin
//
//  Created by luo on 2017/4/25.
//  Copyright © 2017年 wenqi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ALDExpertAnswerModel : NSObject
//
//{
//    "title": "应该怎么办啊飞asdf",
//    "content": "这个这个应该怎么办",
//    "view_num": "5",
//    "add_time": "2016-10-30 05:49:37",
//    "add_date": "2016.10.30",
//    "answer_count": "2"
//}
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *view_num;
@property (nonatomic, copy) NSString *add_time;
@property (nonatomic, copy) NSString *add_date;
@property (nonatomic, copy) NSString *answer_count;

@end
