//
//  ExpertCell.h
//  Aladdin
//
//  Created by luo on 2017/4/23.
//  Copyright © 2017年 wenqi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ALDExpertModel.h"

@interface ExpertCell : UITableViewCell

@property (nonatomic, strong) ALDExpertModel *model;

+ (CGFloat)heightForRow:(ALDExpertModel *)model;

@end
