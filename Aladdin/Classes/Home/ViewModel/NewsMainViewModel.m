//
//  NewsMainViewModel.m
//  Aladdin
//
//  Created by luo on 2017/4/10.
//  Copyright © 2017年 wenqi. All rights reserved.
//

#import "NewsMainViewModel.h"
#import "ALDNewsTypeModel.h"

@implementation NewsMainViewModel

- (NSMutableArray *)newsTypeList {
    if (!_newsTypeList) {
        _newsTypeList = [NSMutableArray array];
    }
    return _newsTypeList;
}

// 请求资讯分类
- (void)loadNewsTypeWithCompleted:(void (^)(NSError *error))complete {
    
    @weakify(self);
    
    [AFNManagerRequest getWithPath:NEWS_TYPE params:nil success:^(NSURLResponse *response, id responseObject) {
        @strongify(self)
        NSArray *arrayM = [ALDNewsTypeModel mj_objectArrayWithKeyValuesArray:responseObject];
        self.newsTypeList = [arrayM mutableCopy];
        complete(nil);
    } failure:^(NSError *error) {
        complete(error);
    }];
}

@end
