//
//  DiscoverCell.m
//  Aladdin
//
//  Created by luo on 2017/4/9.
//  Copyright © 2017年 wenqi. All rights reserved.
//

#import "DiscoverCell.h"

@interface DiscoverCell()
@property (weak, nonatomic) IBOutlet UIImageView *imageV;

@end

@implementation DiscoverCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.imageV.layer.cornerRadius = 2;
    self.imageV.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(DiscoverModel *)model {
    _model = model;
    
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:self.model.imageUrl] placeholderImage:nil];
}

@end
