//
//  WQRefreshNormalHeader.m
//  Aladdin
//
//  Created by luo on 2017/5/13.
//  Copyright © 2017年 wenqi. All rights reserved.
//

#import "WQRefreshNormalHeader.h"

@implementation WQRefreshNormalHeader

#pragma mark - 重写方法
#pragma mark 基本设置
- (void)prepare
{
    [super prepare];
    // 隐藏时间
    self.lastUpdatedTimeLabel.hidden = YES;
    // 隐藏状态
    self.stateLabel.hidden = YES;
}
@end
