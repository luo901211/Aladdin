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

@property (nonatomic, copy) NSString *mobile;
@property (nonatomic, copy) NSString *real_name;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *company;
@property (nonatomic, copy) NSString *position;
@property (nonatomic, copy) NSString *pic_url;

@property (nonatomic, readonly, getter = isLogin) BOOL login;

+ (User *)sharedInstance;
- (void)save;
- (void)logout;
@end
