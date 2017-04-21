//
//  ALDVideoDetailModel.h
//  Aladdin
//
//  Created by luo on 2017/4/21.
//  Copyright © 2017年 wenqi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ALDVideoDetailModel : NSObject

@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *teacher;
@property (nonatomic, copy) NSString *source;
@property (nonatomic, copy) NSString *view_num;
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, assign) NSInteger is_collect;

@end
