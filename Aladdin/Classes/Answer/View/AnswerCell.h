//
//  AnswerCell.h
//  Aladdin
//
//  Created by luo on 2017/4/9.
//  Copyright © 2017年 wenqi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AnswerModel.h"

@interface AnswerCell : UITableViewCell

@property(nonatomic,strong) AnswerModel *model;

/**
 *  类方法返回行高
 */
+ (CGFloat)heightForRow:(AnswerModel *)model;

@end
