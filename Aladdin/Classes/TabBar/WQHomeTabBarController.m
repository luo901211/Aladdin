//
//  WQHomeTabBarController.m
//  Aladdin
//
//  Created by luowenqi on 16/7/1.
//  Copyright © 2016年 luowenqi. All rights reserved.
//

#import "WQHomeTabBarController.h"
#import "ALDBaseNavigationController.h"
#import "NewsMainViewController.h"
#import "AnswerMainViewController.h"
#import "DiscoverListViewController.h"

@implementation WQHomeTabBarController

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setupTabBarController];
        
        self.tabBar.tintColor = GLOBAL_TINT_COLOR;
        
        //显示未读
//        UINavigationController  *discoverNav =(UINavigationController *)self.viewControllers[1];
//        UITabBarItem *curTabBarItem=discoverNav.tabBarItem;
//        [curTabBarItem setBadgeValue:@"2"];
    }
    return self;
}


- (void)setupTabBarController {
    /// 设置TabBar属性数组
    self.tabBarItemsAttributes =[self tabBarItemsAttributesForController];
    
    /// 设置控制器数组
    self.viewControllers =[self mpViewControllers];
    
    self.delegate = self;
    self.moreNavigationController.navigationBarHidden = YES;
}


//控制器设置
- (NSArray *)mpViewControllers {
    NewsMainViewController *firstViewController = [[NewsMainViewController alloc] init];
    ALDBaseNavigationController *firstNavigationController = [[ALDBaseNavigationController alloc]
                                                   initWithRootViewController:firstViewController];
    
    AnswerMainViewController *secondViewController = [[AnswerMainViewController alloc] init];
    ALDBaseNavigationController *secondNavigationController = [[ALDBaseNavigationController alloc]
                                                    initWithRootViewController:secondViewController];
    
    DiscoverListViewController *thirdViewController = [[DiscoverListViewController alloc] init];
    ALDBaseNavigationController *thirdNavigationController = [[ALDBaseNavigationController alloc]
                                                   initWithRootViewController:thirdViewController];
    
    UIViewController *fourthViewController = [[UIViewController alloc] init];
    ALDBaseNavigationController *fourthNavigationController = [[ALDBaseNavigationController alloc]
                                                    initWithRootViewController:fourthViewController];
    
    NSArray *viewControllers = @[
                                 firstNavigationController,
                                 secondNavigationController,
                                 thirdNavigationController,
                                 fourthNavigationController
                                 ];
    return viewControllers;
}

//TabBar文字跟图标设置
- (NSArray *)tabBarItemsAttributesForController {
    NSDictionary *firstTabBarItemsAttributes = @{
                                                 CYLTabBarItemTitle : @"新闻",
                                                 CYLTabBarItemImage : @"tab_news_n",
                                                 CYLTabBarItemSelectedImage : @"tab_news_h",
                                                 };
    NSDictionary *secondTabBarItemsAttributes = @{
                                                  CYLTabBarItemTitle : @"问答",
                                                  CYLTabBarItemImage : @"tab_answer_n",
                                                  CYLTabBarItemSelectedImage : @"tab_answer_h",
                                                  };
    NSDictionary *thirdTabBarItemsAttributes = @{
                                                 CYLTabBarItemTitle : @"发现",
                                                 CYLTabBarItemImage : @"tab_discover_n",
                                                 CYLTabBarItemSelectedImage : @"tab_discover_h",
                                                 };
    NSDictionary *fourthTabBarItemsAttributes = @{
                                                  CYLTabBarItemTitle : @"服务",
                                                  CYLTabBarItemImage : @"tab_server_n",
                                                  CYLTabBarItemSelectedImage : @"tab_server_h"
                                                  };
    NSArray *tabBarItemsAttributes = @[
                                       firstTabBarItemsAttributes,
                                       secondTabBarItemsAttributes,
                                       thirdTabBarItemsAttributes,
                                       fourthTabBarItemsAttributes
                                       ];
    return tabBarItemsAttributes;
}


#pragma mark - UITabBarControllerDelegate

- (BOOL)tabBarController:(UITabBarController*)tabBarController shouldSelectViewController:(UINavigationController*)viewController {
    /// 特殊处理 - 是否需要登录
//    BOOL isBaiDuService = [viewController.topViewController isKindOfClass:[MPDiscoverViewController class]];
//    if (isBaiDuService) {
//        NSLog(@"你点击了TabBar第二个");
//    }
    return YES;
}
@end
