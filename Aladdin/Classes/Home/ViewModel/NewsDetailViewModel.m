//
//  NewsDetailViewModel.m
//  Aladdin
//
//  Created by luo on 2017/4/12.
//  Copyright © 2017年 wenqi. All rights reserved.
//

#import "NewsDetailViewModel.h"

@implementation NewsDetailViewModel

- (void)submitComment:(NSString *)comment newsID:(NSInteger)ID complete:(void (^)(NSString *msg))complete {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:[User sharedInstance].token forKey:@"token"];
    [params setObject:comment forKey:@"comment"];
    [params setObject:@(ID) forKey:@"id"];
    
    [AFNManagerRequest postWithPath:NEWS_COMMENT_SUBMIT params:params hudType:(NetworkRequestGraceTimeTypeNormal) success:^(NSURLResponse *response, id responseObject) {
        complete(nil);
    } failure:^(NSError *error) {
        complete(error.localizedDescription);
    }];
}


@end
