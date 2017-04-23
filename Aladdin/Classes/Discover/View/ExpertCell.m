//
//  ExpertCell.m
//  Aladdin
//
//  Created by luo on 2017/4/23.
//  Copyright © 2017年 wenqi. All rights reserved.
//

#import "ExpertCell.h"

@interface ExpertCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imageV;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *companyLabel;
@property (weak, nonatomic) IBOutlet UILabel *positionLabel;

@end

@implementation ExpertCell

+ (CGFloat)heightForRow:(ALDExpertModel *)model {
    return 76;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.imageV.layer.cornerRadius = self.imageV.height/2;
    self.imageV.contentMode = UIViewContentModeScaleAspectFill;
    self.imageV.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(ALDExpertModel *)model {
    _model = model;
    
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:model.pic_url]];
    self.nameLabel.text = model.real_name;
    self.companyLabel.text = model.company;
    self.positionLabel.text = model.position;
}

@end
