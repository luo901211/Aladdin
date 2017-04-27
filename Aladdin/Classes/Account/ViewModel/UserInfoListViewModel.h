//
//  UserInfoListViewModel.h
//  Aladdin
//
//  Created by luo on 2017/4/27.
//  Copyright © 2017年 wenqi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfoListViewModel : NSObject

@property (nonatomic, strong) NSDictionary *userInfo;

- (void)loadDataWithComplete:(void (^)(NSString *msg))complete;

@end
