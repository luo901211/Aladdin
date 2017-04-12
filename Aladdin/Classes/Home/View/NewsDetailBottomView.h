//
//  NewsDetailBottomView.h
//  Aladdin
//
//  Created by luo on 2017/4/12.
//  Copyright © 2017年 wenqi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsDetailBottomView : UIView

@property (nonatomic, copy) void (^commentBlock)();
@property (nonatomic, copy) void (^shareBlock)();
@property (nonatomic, copy) void (^commentListBlock)();

@end
