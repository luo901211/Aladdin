//
//  User+Helper.h
//  Aladdin
//
//  Created by luo on 2017/4/16.
//  Copyright © 2017年 wenqi. All rights reserved.
//

#import "User.h"
#import "LoginVC.h"

@interface User (Helper)

- (void)getUserinfo;

+ (void)presentLoginViewController;

@end
