//
//  UIViewController+WQAdd.m
//  Aladdin
//
//  Created by luo on 2017/5/17.
//  Copyright © 2017年 wenqi. All rights reserved.
//

#import "UIViewController+WQAdd.h"

@implementation UIViewController (WQAdd)

- (BOOL)isModelPresent {
    
    NSArray *viewcontrollers=self.navigationController.viewControllers;
    if (viewcontrollers.count>1) {
        if ([viewcontrollers objectAtIndex:viewcontrollers.count-1]==self) {
            //push方式
            return NO;
        }
    }
    // present
    return YES;
}
@end
