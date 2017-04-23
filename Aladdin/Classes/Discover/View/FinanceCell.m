//
//  FinanceCell.m
//  Aladdin
//
//  Created by luo on 2017/4/23.
//  Copyright © 2017年 wenqi. All rights reserved.
//

#import "FinanceCell.h"

@interface FinanceCell()
@property (weak, nonatomic) IBOutlet UIImageView *imageV;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;

@end

@implementation FinanceCell

+ (CGFloat)heightForRow:(ALDFinanceModel *)model {
    return 120;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.imageV.contentMode = UIViewContentModeScaleAspectFill;
    self.imageV.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(ALDFinanceModel *)model {
    _model = model;
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:model.pic_url]];
    self.titleLabel.text = model.title;
    self.descLabel.text = model.desc;
}

@end
