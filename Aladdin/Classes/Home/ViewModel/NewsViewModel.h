//
//  NewsViewModel.h
//  Aladdin
//
//  Created by luo on 2017/4/8.
//  Copyright © 2017年 wenqi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsViewModel : NSObject

/**
 *  获取新闻概要模型
 */
@property(nonatomic,strong)RACCommand *fetchNewsModelCommand;


@end
