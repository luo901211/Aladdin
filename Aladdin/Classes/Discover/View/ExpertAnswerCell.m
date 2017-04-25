//
//  ExpertAnswerCell.m
//  Aladdin
//
//  Created by luo on 2017/4/25.
//  Copyright © 2017年 wenqi. All rights reserved.
//

#import "ExpertAnswerCell.h"

@interface ExpertAnswerCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *viewCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end

@implementation ExpertAnswerCell

+ (CGFloat)heightForRow:(ALDExpertAnswerModel *)model {
    return 81;
}

- (void)setModel:(ALDExpertAnswerModel *)model {
    _model = model;
    self.titleLabel.text = model.title;
    self.viewCountLabel.text = [NSString stringWithFormat:@"浏览: %@",model.view_num];
    self.timeLabel.text = [NSString stringWithFormat:@"发布: %@",model.add_date];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

@end
