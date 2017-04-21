//
//  PolicyCell.m
//  Aladdin
//
//  Created by luo on 2017/4/21.
//  Copyright © 2017年 wenqi. All rights reserved.
//

#import "PolicyCell.h"

@interface PolicyCell()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end

@implementation PolicyCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (CGFloat)heightForRow:(ALDPolicyModel *)model {
    return 90;
}

- (void)setModel:(ALDPolicyModel *)model {
    _model = model;
    self.titleLabel.text = model.title;
    self.numberLabel.text = [NSString stringWithFormat:@"法律编号: %@",model.number];
    self.timeLabel.text = [NSString stringWithFormat:@"颁布时间: %@",model.publish_time];
}

@end
