//
//  WQPopWindow.h
//  Aladdin
//
//  Created by luo on 2017/4/13.
//  Copyright © 2017年 wenqi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WQPopWindow : UIWindow

+ (WQPopWindow *)sharedWindow;
- (void)show;
- (void)hide;

@end
