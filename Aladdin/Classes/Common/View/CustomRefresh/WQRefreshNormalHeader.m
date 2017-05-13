//
//  WQRefreshNormalHeader.m
//  Aladdin
//
//  Created by luo on 2017/5/13.
//  Copyright © 2017年 wenqi. All rights reserved.
//

#import "WQRefreshNormalHeader.h"

@implementation WQRefreshNormalHeader

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+ (instancetype)headerWithRefreshingTarget:(id)target refreshingAction:(SEL)action
{
    WQRefreshNormalHeader *cmp = [[self alloc] init];
    [cmp setRefreshingTarget:target refreshingAction:action];
    cmp.lastUpdatedTimeLabel.hidden = YES;
    return cmp;
}
@end
