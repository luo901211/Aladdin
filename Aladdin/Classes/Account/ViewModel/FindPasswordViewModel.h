//
//  FindPasswordViewModel.h
//  Aladdin
//
//  Created by luo on 2017/4/27.
//  Copyright © 2017年 wenqi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FindPasswordViewModel : NSObject

- (void)findPasswordWithPhone:(NSString *)phone
                     password:(NSString *)password
                         code:(NSString *)code
                      success:(VoidBlock)success
                      failure:(VoidBlock)failure;

- (void)getCodeWithPhone:(NSString *)phone
                 success:(VoidBlock)success
                 failure:(VoidBlock)failure;
@end
