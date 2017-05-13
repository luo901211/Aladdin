//
//  QuestionReportViewModel.h
//  Aladdin
//
//  Created by luo on 2017/5/14.
//  Copyright © 2017年 wenqi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QuestionReportViewModel : NSObject

- (void)submitQuestionWithTitle:(NSString *)title
                        content:(NSString *)content
                       expertID:(NSInteger)expertID
                           pics:(NSMutableArray *)pics
                        success:(VoidBlock)success
                        failure:(VoidBlock)failure;
@end
