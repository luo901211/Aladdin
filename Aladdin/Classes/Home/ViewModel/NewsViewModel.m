//
//  NewsViewModel.m
//  Aladdin
//
//  Created by luo on 2017/4/8.
//  Copyright © 2017年 wenqi. All rights reserved.
//

#import "NewsViewModel.h"
#import "NewsModel.h"

@implementation NewsViewModel

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
    _fetchNewsModelCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            @strongify(self);
            [self requestForNewsEntityWithUrl:input success:^(NSArray *array) {
                NSArray *arrayM = [NewsModel objectArrayWithKeyValuesArray:array];
                [subscriber sendNext:arrayM];
                [subscriber sendCompleted];
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                [subscriber sendError:error];
            }];
            return nil;
        }];
    }];
}

- (void)requestForNewsEntityWithUrl:(NSString *)url success:(void (^)(NSArray *array))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure{
    NSString *fullUrl = [@"http://c.m.163.com/" stringByAppendingString:url];
    [[WQHTTPManager manager]GET:fullUrl parameters:nil success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        NSString *key = [responseObject.keyEnumerator nextObject];
        NSArray *temArray = responseObject[key];
        success(temArray);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(operation,error);
    }];
}

@end
