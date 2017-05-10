//
//  FinanceChapterListViewModel.h
//  Aladdin
//
//  Created by luo on 2017/4/23.
//  Copyright © 2017年 wenqi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FinanceChapterListViewModel : NSObject

@property (nonatomic, strong) NSMutableArray *list;

- (void)loadDataWithID:(NSInteger)ID
               success:(VoidBlock)success
               failure:(VoidBlock)failure;
@end
