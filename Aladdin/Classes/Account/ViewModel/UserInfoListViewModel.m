//
//  UserInfoListViewModel.m
//  Aladdin
//
//  Created by luo on 2017/4/27.
//  Copyright © 2017年 wenqi. All rights reserved.
//

#import "UserInfoListViewModel.h"

@implementation UserInfoListViewModel

- (void)loadDataWithComplete:(void (^)(NSString *msg))complete {
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:[User sharedInstance].token forKey:@"token"];
    [AFNManagerRequest postWithPath:API_USER_INFO params:params hudType:(NetworkRequestGraceTimeTypeNormal) success:^(NSURLResponse *response, id responseObject) {
        self.userInfo = responseObject;
        complete(nil);
    } failure:^(NSError *error) {
        complete(error.localizedDescription);
    }];
}

- (void)saveDataWithParams:(NSDictionary *)params
                     image:(UIImage *)image
                  complete:(void (^)(NSString *msg))complete {
    
//    token：必传，用户标识
//    real_name：必传
//    address：必传
//    company：必传
//    position：必传
//    pic ： 必传，name=pic, 使用file方式上传图像
    
    NSMutableDictionary *mParams = [NSMutableDictionary dictionaryWithDictionary:params];
    [mParams setObject:[User sharedInstance].token forKey:@"token"];
    
    if (image) {
        [AFNManagerRequest uploadImageWithPath:API_USER_SAVEINFO params:mParams image:image progress:nil success:^(NSURLResponse *response, id responseObject) {
            complete(nil);
        } failure:^(NSError *error) {
            complete(error.localizedDescription);
        }];
    }else{
        [AFNManagerRequest postWithPath:API_USER_SAVEINFO params:mParams success:^(NSURLResponse *response, id responseObject) {
            complete(nil);
        } failure:^(NSError *error) {
            complete(error.localizedDescription);
        }];
    }    
}
@end

