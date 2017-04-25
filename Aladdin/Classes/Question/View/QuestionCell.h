//
//  QuestionCell.h
//  Aladdin
//
//  Created by luo on 2017/4/25.
//  Copyright © 2017年 wenqi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ALDQuestionModel.h"

@interface QuestionCell : UITableViewCell

@property (nonatomic, strong) ALDQuestionModel *model;

+ (CGFloat)heightForRow:(ALDQuestionModel *)model;

@end
