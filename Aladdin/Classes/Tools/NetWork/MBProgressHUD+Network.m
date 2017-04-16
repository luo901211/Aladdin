//
//  MBProgressHUD+WQ.m
//  Aladdin
//
//  Created by luo on 2017/4/16.
//  Copyright © 2017年 wenqi. All rights reserved.
//

#import "MBProgressHUD+Network.h"

@implementation MBProgressHUD (Network)

+ (instancetype)hud {
    MBProgressHUD *hud = objc_getAssociatedObject(self, _cmd);
    if (!hud) {
        hud = [[MBProgressHUD alloc] initWithView:[UIApplication sharedApplication].keyWindow];
        
        objc_setAssociatedObject(self, _cmd, hud, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return hud;
}


+ (instancetype)hudWithNetworkType:(NetworkRequestGraceTimeType)type {
    
    NSTimeInterval graceTime = 0;
    switch (type) {
        case NetworkRequestGraceTimeTypeNone:
            return nil;
            break;
        case NetworkRequestGraceTimeTypeNormal:
            graceTime = 0.5;
            break;
        case NetworkRequestGraceTimeTypeLong:
            graceTime = 1.0;
            break;
        case NetworkRequestGraceTimeTypeShort:
            graceTime = 0.1;
            break;
        case NetworkRequestGraceTimeTypeAlways:
            graceTime = 0;
            break;
        default:
            break;
    }
    
    MBProgressHUD *hud = [MBProgressHUD hud];
    [[UIApplication sharedApplication].keyWindow addSubview:hud];
    hud.graceTime = graceTime;
    [hud showAnimated:YES];
    return hud;
}

@end
