//
//  TeachingVideoDetailBottomView.h
//  Aladdin
//
//  Created by luo on 2017/4/24.
//  Copyright © 2017年 wenqi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ALDVideoDetailModel.h"

@interface TeachingVideoDetailBottomView : UIView

@property (nonatomic, strong) ALDVideoDetailModel *model;

@property (nonatomic, copy) VoidBlock collectTapBlock;

@end
