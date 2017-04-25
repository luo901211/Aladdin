//
//  QuestionListViewModel.h
//  Aladdin
//
//  Created by luo on 2017/4/25.
//  Copyright © 2017年 wenqi. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, QuestionType) {
    QuestionTypeEssence,
    QuestionTypeNotEssence,
    QuestionTypeUser,
};

@interface QuestionListViewModel : NSObject

@property (nonatomic, strong) NSMutableArray *list;

- (void)loadDataListWithPageIndex:(NSInteger)pageIndex type:(QuestionType)type success:(void (^)(BOOL noMoreData))success failure:(void (^)(NSError *error))failure;

@end
