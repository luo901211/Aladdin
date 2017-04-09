//
//  DiscoverModel.m
//  Aladdin
//
//  Created by luo on 2017/4/9.
//  Copyright © 2017年 wenqi. All rights reserved.
//

#import "DiscoverModel.h"

@implementation DiscoverModel

+ (instancetype)modelWithDict:(NSDictionary *)dict
{
    DiscoverModel *model = [[self alloc]init];
    
    [model setValuesForKeysWithDictionary:dict];
    
    return model;
}

@end
