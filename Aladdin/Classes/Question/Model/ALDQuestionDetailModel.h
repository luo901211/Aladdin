//
//  ALDQuestionDetailModel.h
//  Aladdin
//
//  Created by luo on 2017/5/11.
//  Copyright © 2017年 wenqi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ALDAnswerModel.h"

@interface ALDQuestionDetailModel : NSObject
//"title": "应该怎么办啊飞asdf",
//"content": "这个这个应该怎么办",
//"view_num": "4",
//"answer_count": "1",
@property (assign, nonatomic) NSInteger ID;
@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *content;
@property (copy, nonatomic) NSString *view_num;
@property (copy, nonatomic) NSString *answer_count;
@property (nonatomic, strong) NSArray <ALDAnswerModel *>*answer_list;

@end
