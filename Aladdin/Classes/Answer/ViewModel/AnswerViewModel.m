//
//  AnswerViewModel.m
//  Aladdin
//
//  Created by luo on 2017/4/9.
//  Copyright © 2017年 wenqi. All rights reserved.
//

#import "AnswerViewModel.h"
#import "AnswerModel.h"

@implementation AnswerViewModel

- (instancetype)init
{
    if (self = [super init]) {
        [self setupRACCommand];
    }
    return self;
}

- (void)setupRACCommand
{
    @weakify(self);
    _fetchAnswerModelCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            @strongify(self);
            [self requestForNewsEntityWithUrl:input success:^(NSArray *array) {
                NSArray *arrayM = [AnswerModel mj_objectArrayWithKeyValuesArray:array];
                [subscriber sendNext:arrayM];
                [subscriber sendCompleted];
            } failure:^(NSError *error) {
                [subscriber sendError:error];
            }];
            return nil;
        }];
    }];
}

- (void)requestForNewsEntityWithUrl:(NSString *)url success:(void (^)(NSArray *array))success failure:(void (^)(NSError *error))failure{

    [AFNManagerRequest getWithPath:url params:nil success:^(NSURLResponse *response, id responseObject) {
        
        success(responseObject);

    } failure:^(NSError *error) {
        failure(error);

    }];
}

@end
