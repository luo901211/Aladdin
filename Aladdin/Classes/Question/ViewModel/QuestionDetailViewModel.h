//
//  QuestionDetailViewModel.h
//  Aladdin
//
//  Created by luo on 2017/5/11.
//  Copyright © 2017年 wenqi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QuestionDetailViewModel : NSObject

- (void)loadDataWithID:(NSInteger)ID
               success:(VoidBlock)success
               failure:(VoidBlock)failure;

- (void)setStandardAnswerWithID:(NSInteger)ID
                        success:(VoidBlock)success
                        failure:(VoidBlock)failure;

- (void)collectDataWithID:(NSInteger)ID
                  success:(VoidBlock)success
                  failure:(VoidBlock)failure;

- (void)cancelCollectDataWithID:(NSInteger)ID
                        success:(VoidBlock)success
                        failure:(VoidBlock)failure;
@end
