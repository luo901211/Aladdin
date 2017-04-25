//
//  ExpertAnswerCell.h
//  Aladdin
//
//  Created by luo on 2017/4/25.
//  Copyright © 2017年 wenqi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ALDExpertAnswerModel.h"

@interface ExpertAnswerCell : UITableViewCell

@property (nonatomic, strong) ALDExpertAnswerModel *model;

+ (CGFloat)heightForRow:(ALDExpertAnswerModel *)model;

@end
