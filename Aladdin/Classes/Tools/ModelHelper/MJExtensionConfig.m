//
//  MJExtensionConfig.m
//  MJExtensionExample
//
//  Created by MJ Lee on 15/4/22.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import "MJExtensionConfig.h"

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
    

    // 相当于在MJDog.m中实现了+(NSDictionary *)mj_replacedKeyFromPropertyName121:方法
    
//#pragma mark MJStatusResult类中的statuses数组中存放的是MJStatus模型
//#pragma mark MJStatusResult类中的ads数组中存放的是MJAd模型
//    [MJStatusResult mj_setupObjectClassInArray:^NSDictionary *{
//        return @{
//                 @"statuses" : @"MJStatus", // @"statuses" : [MJStatus class],
//                 @"ads" : @"MJAd" // @"ads" : [MJAd class]
//                 };
//    }];
//    // 相当于在MJStatusResult.m中实现了+(NSDictionary *)mj_objectClassInArray方法
//    
//#pragma mark MJStudent中的desc属性对应着字典中的desciption
//#pragma mark ....
//    [MJStudent mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
//        return @{
//                 @"desc" : @"desciption",
//                 @"oldName" : @"name.oldName",
//                 @"nowName" : @"name.newName",
//                 @"otherName" : @[@"otherName", @"name.newName", @"name.oldName"],
//                 @"nameChangedTime" : @"name.info[1].nameChangedTime",
//                 @"bag" : @"other.bag"
//                 };
//    }];
//    // 相当于在MJStudent.m中实现了+(NSDictionary *)mj_replacedKeyFromPropertyName方法
//    
}
@end
