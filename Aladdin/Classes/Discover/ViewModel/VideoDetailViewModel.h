//
//  VideoDetailViewModel.h
//  Aladdin
//
//  Created by luo on 2017/4/21.
//  Copyright © 2017年 wenqi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ALDVideoDetailModel.h"

@interface VideoDetailViewModel : NSObject


@property (nonatomic, strong) ALDVideoDetailModel *model;

- (void)loadDataWithID:(NSInteger)ID
               success:(VoidBlock)success
               failure:(VoidBlock)failure;
@end
