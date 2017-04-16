//
//  User.m
//  Aladdin
//
//  Created by luo on 2017/4/16.
//  Copyright © 2017年 wenqi. All rights reserved.
//

#import "User.h"

@implementation User
+ (User *)sharedInstance {
    static User *user = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        user = [[User alloc] init];
        NSMutableDictionary *data = [NSKeyedUnarchiver unarchiveObjectWithFile:UserInfoPath];
        if (data) {
            for (NSString *key in data.allKeys) {
                if ([data[key] isEqual:[NSNull null]]) {
                    [user setValue:nil forKey:key];
                } else {
                    [user setValue:data[key] forKey:key];
                }
            }
        }
    });
    return user;
}

- (void)save {
    NSArray *properties = @[ @"token" ];
    NSMutableDictionary *data = [NSMutableDictionary dictionary];
    for (NSString *key in properties) {
        if ([self valueForKey:key]) {
            [data setValue:[self valueForKey:key] forKey:key];
        } else {
            [data setValue:[NSNull null] forKey:key];
        }
    }
    [NSKeyedArchiver archiveRootObject:data toFile:UserInfoPath];
}

- (BOOL)isLogin {
    if (self.token && ![self.token isEqualToString:@""]) {
        return YES;
    }
    return NO;
}
- (void)logout {
    self.token = @"";
    [self save];
    [[NSNotificationCenter defaultCenter] postNotificationName:UserDidLogOutNotification object:nil userInfo:nil];
}

@end
