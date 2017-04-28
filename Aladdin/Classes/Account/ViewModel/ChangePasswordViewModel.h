//
//  ChangePasswordViewModel.h
//  Aladdin
//
//  Created by luo on 2017/4/27.
//  Copyright © 2017年 wenqi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChangePasswordViewModel : NSObject

- (void)changePasswordWithPassword:(NSString *)password newPassword:(NSString *)newPassword rePassword:(NSString *)rePassword complete:(void (^)(NSString *msg))complete;


@end
