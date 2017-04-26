//
//  QuestionModel.h
//  Aladdin
//
//  Created by luo on 2017/4/25.
//  Copyright © 2017年 wenqi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ALDQuestionModel : NSObject
//{
//    "id": "1",
//    "title": "应该怎么办啊飞asdf",
//    "is_top": "1",
//    "is_essence": "1",
//    "is_solve":1,
//    "add_time": "2016-10-30 05:49:37",
//    "mobile": "18201689539",
//    "real_name": "温彦磊啊",
//    "add_date": "2016-10-30",
//    "answer_count": "0"
//}

@property (assign, nonatomic) NSInteger ID;
@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *is_top;
@property (copy, nonatomic) NSString *is_essence;
@property (copy, nonatomic) NSString *is_solve;
@property (copy, nonatomic) NSString *add_time;
@property (copy, nonatomic) NSString *add_date;
@property (copy, nonatomic) NSString *mobile;
@property (copy, nonatomic) NSString *real_name;
@property (copy, nonatomic) NSString *answer_count;

@end
