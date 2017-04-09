//
//  NewsModel.m
//  Aladdin
//
//  Created by luo on 2017/4/8.
//  Copyright © 2017年 wenqi. All rights reserved.
//

#import "ALDNewsModel.h"

@implementation ALDNewsModel

+ (instancetype)modelWithDict:(NSDictionary *)dict
{
    ALDNewsModel *model = [[self alloc]init];
    
    [model setValuesForKeysWithDictionary:dict];
    
    return model;
}

@end
