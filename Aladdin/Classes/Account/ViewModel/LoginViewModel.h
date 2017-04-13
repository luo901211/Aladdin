//
//  LoginViewModel.h
//  Aladdin
//
//  Created by luo on 2017/4/13.
//  Copyright © 2017年 wenqi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginViewModel : NSObject

- (void)loginWithPhone:(NSString *)phone
              password:(NSString *)password
               success:(VoidBlock)success
               failure:(VoidBlock)failure;

- (void)loginWithPhone:(NSString *)phone
                  code:(NSString *)code
               success:(VoidBlock)success
               failure:(VoidBlock)failure;

- (void)getCodeWithPhone:(NSString *)phone
                 success:(VoidBlock)success
                 failure:(VoidBlock)failure;

@end
