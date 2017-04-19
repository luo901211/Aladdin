//
//  XAspect-AppearenceConfigAppDelegate
//  Aladdin 设置统一样式
//
//  Created by luowenqi on 17/4/10.
//  Copyright © 2016年 luowenqi. All rights reserved.
//

#import "AppDelegate.h"
#import "XAspect.h"

#define AtAspect AppearanceConfigAppDelegate

#define AtAspectOfClass AppDelegate
@classPatchField(AppDelegate)
AspectPatch(-, BOOL, application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions)
{
    [[UIBarButtonItem appearance] setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60)
                                                         forBarMetrics:UIBarMetricsDefault];

    return XAMessageForward(application:application didFinishLaunchingWithOptions:launchOptions);
}

@end
#undef AtAspectOfClass


#define AtAspectOfClass UIViewController
@classPatchField(UIViewController)
AspectPatch(-, void, viewDidLoad)
{
    
    if (self.class == [UIViewController class] && self.class == [UITableViewController class]) {
        self.view.backgroundColor = [UIColor whiteColor];
    }
    
    return XAMessageForward(viewDidLoad);
}

@end
#undef AtAspectOfClass

#undef AtAspect
