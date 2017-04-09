//
//  AnswerModel.m
//  Aladdin
//
//  Created by luo on 2017/4/9.
//  Copyright © 2017年 wenqi. All rights reserved.
//

#import "AnswerModel.h"

@implementation AnswerModel

+ (instancetype)modelWithDict:(NSDictionary *)dict
{
    AnswerModel *model = [[self alloc]init];
    
    [model setValuesForKeysWithDictionary:dict];
    
    return model;
}

@end
