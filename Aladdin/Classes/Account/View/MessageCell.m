//
//  MessageCell.m
//  Aladdin
//
//  Created by luo on 2017/4/16.
//  Copyright © 2017年 wenqi. All rights reserved.
//

#import "MessageCell.h"

@interface MessageCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imageV;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end

@implementation MessageCell

+ (CGFloat)heightForRow:(ALDMessageModel *)model {
    return 76;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(ALDMessageModel *)model {
    _model = model;
    
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:model.pic_url]];
    self.titleLabel.text = model.title;
    self.contentLabel.text = model.content;
    self.timeLabel.text = model.add_time;
}

@end
