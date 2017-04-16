//
//  MBProgressHUD+WQ.h
//  Aladdin
//
//  Created by luo on 2017/4/16.
//  Copyright © 2017年 wenqi. All rights reserved.
//

#import <MBProgressHUD/MBProgressHUD.h>

#pragma mark 指示器 网络请求XX秒内，不显示
typedef NS_ENUM(NSUInteger, NetworkRequestGraceTimeType) {
    NetworkRequestGraceTimeTypeNormal, //0.5s
    NetworkRequestGraceTimeTypeLong, // 1s
    NetworkRequestGraceTimeTypeShort, // 0.1s
    NetworkRequestGraceTimeTypeNone, // 没有提示框
    NetworkRequestGraceTimeTypeAlways, // 总是有提示框
};

@interface MBProgressHUD (Network)

+ (instancetype)hudWithNetworkType:(NetworkRequestGraceTimeType)type;

@end
