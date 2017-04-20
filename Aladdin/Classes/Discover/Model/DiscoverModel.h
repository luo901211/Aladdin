//
//  DiscoverModel.h
//  Aladdin
//
//  Created by luo on 2017/4/9.
//  Copyright © 2017年 wenqi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DiscoverModel : NSObject

@property (nonatomic, copy) NSString *imageUrl;
@property (nonatomic, copy) NSString *title;

+ (instancetype)modelWithDict:(NSDictionary *)dict;

@end
