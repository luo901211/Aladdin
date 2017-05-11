//
//  MJExtensionConfig.m
//  MJExtensionExample
//
//  Created by MJ Lee on 15/4/22.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import "MJExtensionConfig.h"
#import "ALDFinanceChapterModel.h"
#import "ALDQuestionDetailModel.h"
#import "ALDAnswerModel.h"

@implementation MJExtensionConfig
/**
 *  这个方法会在MJExtensionConfig加载进内存时调用一次
 */
+ (void)load
{

#pragma mark 如果使用NSObject来调用这些方法，代表所有继承自NSObject的类都会生效
    
#pragma mark NSObject中的ID属性对应着字典中的id
    [NSObject mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{ @"ID" : @"id" };
    }];
    
    // Tell MJExtension what type model will be contained in statuses and ads.
    [ALDFinanceChapterModel mj_setupObjectClassInArray:^NSDictionary *{
        return @{
                 @"child" : @"ALDFinanceChapterModel"
                 };
    }];
    
    [ALDQuestionDetailModel mj_setupObjectClassInArray:^NSDictionary *{
        return @{
                 @"answer_list" : @"ALDAnswerModel"
                 };
    }];
}
@end
