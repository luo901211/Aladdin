//
//  ExpertDetailHeaderView.m
//  Aladdin
//
//  Created by luo on 2017/4/25.
//  Copyright © 2017年 wenqi. All rights reserved.
//

#import "ExpertDetailHeaderView.h"

@interface ExpertDetailHeaderView ()
@property (weak, nonatomic) IBOutlet UIImageView *imageV;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *companyLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;

@end

@implementation ExpertDetailHeaderView

-(void)awakeFromNib {
    [super awakeFromNib];
    self.imageV.layer.cornerRadius = self.imageV.height/2;
    self.imageV.layer.masksToBounds = YES;
    self.imageV.layer.borderColor = HEXCOLOR(0x8fdaff).CGColor;
    self.imageV.layer.borderWidth = 4;
}

- (void)setModel:(ALDExpertDetailModel *)model {
    _model = model;
    
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:model.pic_url]];
    self.nameLabel.text = model.real_name;
    self.companyLabel.text = [NSString stringWithFormat:@"%@ %@",model.company, model.position];
    self.descLabel.text = model.desc;
    
    CGFloat height = [self.descLabel.text heightForFont:self.descLabel.font width:self.descLabel.width];
    self.height = self.descLabel.top + height + 20;
}

@end
