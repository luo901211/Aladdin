//
//  AnswerCell.m
//  Aladdin
//
//  Created by luo on 2017/4/9.
//  Copyright © 2017年 wenqi. All rights reserved.
//

#import "AnswerCell.h"

@implementation AnswerCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
#pragma mark - /************************* 类方法返回行高 ***************************/
+ (CGFloat)heightForRow:(AnswerModel *)model {
    return 120;
}
@end
