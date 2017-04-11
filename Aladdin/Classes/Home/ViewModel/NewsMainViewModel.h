//
//  NewsMainViewModel.h
//  Aladdin
//
//  Created by luo on 2017/4/10.
//  Copyright © 2017年 wenqi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsMainViewModel : NSObject

@property (nonatomic, strong) NSMutableArray *newsTypeList;

/**
 *  获取新闻分类模型
 */
- (void)loadNewsTypeWithCompleted:(void (^)(NSError *error))completed;

@end
