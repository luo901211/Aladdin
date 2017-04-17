//
//  UserFeatureView.h
//  Aladdin
//
//  Created by luo on 2017/4/17.
//  Copyright © 2017年 wenqi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserFeatureView : UIView

@property (nonatomic, copy) void(^tapBlock)(NSInteger index);

- (instancetype)initWithItems:(NSArray *)items;

@end
