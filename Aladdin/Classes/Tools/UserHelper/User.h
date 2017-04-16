//
//  User.h
//  Aladdin
//
//  Created by luo on 2017/4/16.
//  Copyright © 2017年 wenqi. All rights reserved.
//

#import <Foundation/Foundation.h>

#define UserInfoPath ([NSString stringWithFormat:@"%@/Documents/userinfo.xml", NSHomeDirectory()])
#define UserDidLogInNotification @"UserDidLogInNotification"
#define UserDidLogOutNotification @"UserDidLogOutNotification"

@interface User : NSObject

@property (nonatomic, copy) NSString *token;

@property (nonatomic, readonly, getter = isLogin) BOOL login;

+ (User *)sharedInstance;

@end
