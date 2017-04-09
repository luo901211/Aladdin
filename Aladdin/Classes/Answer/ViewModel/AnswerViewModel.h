//
//  AnswerViewModel.h
//  Aladdin
//
//  Created by luo on 2017/4/9.
//  Copyright © 2017年 wenqi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AnswerViewModel : NSObject

/**
 *  获取问答模型
 */
@property(nonatomic,strong)RACCommand *fetchAnswerModelCommand;


@end
