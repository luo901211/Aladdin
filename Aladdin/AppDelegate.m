//
//  AppDelegate.m
//  Aladdin
//
//  Created by luo on 2017/4/7.
//  Copyright © 2017年 wenqi. All rights reserved.
//

#import "AppDelegate.h"
#import "SYSafeCategory.h"
#import "IQKeyboardManager.h"
#import "WQHomeTabBarController.h"
#import "LoginVC.h"

//TEST
#import "MessageTypeListVC.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.

    //启动友盟统计
    [MPUmengHelper UMAnalyticStart];
    
    //统一处理一些为数组、集合等对nil插入会引起闪退
    [SYSafeCategory callSafeCategory];
    
    //键盘统一收回处理
    [self configureBoardManager];
    
    [self setupHomeViewController];

    if ([User sharedInstance].isLogin) {
        [[User sharedInstance] checkToken];
    }
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark 键盘收回管理
-(void)configureBoardManager
{
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    manager.shouldResignOnTouchOutside = YES;
    manager.shouldToolbarUsesTextFieldTintColor = YES;
    manager.keyboardDistanceFromTextField=60;
    manager.enableAutoToolbar = NO;
}

#pragma mark 自定义跳转不同的页面
//登录页面
- (void)presentLoginViewController {
    LoginVC *logInVc = [[LoginVC alloc] initWithNibName:@"LoginVC" bundle:[NSBundle mainBundle]];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:logInVc];
    [self.window.rootViewController presentViewController:nav animated:YES completion:nil];
}

//首页
-(void)setupHomeViewController
{
    WQHomeTabBarController *tabBarController = [[WQHomeTabBarController alloc] init];
    [self.window setRootViewController:tabBarController];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
}


@end
