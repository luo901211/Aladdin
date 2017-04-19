//
//  CollectCell.h
//  Aladdin
//
//  Created by luo on 2017/4/19.
//  Copyright © 2017年 wenqi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ALDCollectModel.h"

@interface CollectCell : UITableViewCell

@property (nonatomic, strong) ALDCollectModel *model;

+ (CGFloat)heightForRow:(ALDCollectModel *)model;

@end
