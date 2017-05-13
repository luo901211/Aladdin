//
//  User.m
//  Aladdin
//
//  Created by luo on 2017/4/16.
//  Copyright © 2017年 wenqi. All rights reserved.
//

#import "User.h"

@implementation User

-(NSString *)token {
    if (!_token) {
        _token = @"";
    }
    return _token;
}

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
    
    NSArray *properties = @[ @"token", @"mobile", @"real_name", @"address", @"company", @"position", @"pic_url" ];
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
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotification_Logout object:nil];
}

@end
