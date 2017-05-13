//
//  AnswerViewModel.h
//  Aladdin
//
//  Created by luo on 2017/5/14.
//  Copyright © 2017年 wenqi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AnswerViewModel : NSObject

- (void)submitAnswer:(NSString *)content
                  id:(NSInteger)ID
             success:(VoidBlock)success
             failure:(VoidBlock)failure;

@end
