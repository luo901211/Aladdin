//
//  ExpertNewsCell.h
//  Aladdin
//
//  Created by luo on 2017/4/25.
//  Copyright © 2017年 wenqi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ALDExpertNewsModel.h"

@interface ExpertNewsCell : UITableViewCell

@property (nonatomic, strong) ALDExpertNewsModel *model;

+ (CGFloat)heightForRow:(ALDExpertNewsModel *)model;

@end
