//
//  AnswerCell.m
//  Aladdin
//
//  Created by luo on 2017/5/11.
//  Copyright © 2017年 wenqi. All rights reserved.
//

#import "AnswerCell.h"

@interface AnswerCell()
@property (weak, nonatomic) IBOutlet UIImageView *imageV;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIImageView *bestImageV;
@property (weak, nonatomic) IBOutlet UILabel *bestLabel;

@end

@implementation AnswerCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.imageV.layer.cornerRadius = self.imageV.height / 2;
    self.imageV.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(ALDAnswerModel *)model {
    _model = model;
    self.nameLabel.text = model.real_name;
    self.contentLabel.text = model.content;
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:model.pic_url]];
    self.bestImageV.hidden = self.bestLabel.hidden = !model.is_standard;
}

@end
