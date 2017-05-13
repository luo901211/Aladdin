//
//  AnswerCell.h
//  Aladdin
//
//  Created by luo on 2017/5/11.
//  Copyright © 2017年 wenqi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ALDQuestionDetailModel.h"

@interface AnswerCell : UITableViewCell

@property (nonatomic, strong) ALDAnswerModel *model;

+ (CGFloat)heightForRow:(ALDAnswerModel *)model;

@end
