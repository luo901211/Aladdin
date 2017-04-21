//
//  TeachingVideoCollectionViewCell.m
//  Aladdin
//
//  Created by luo on 2017/4/9.
//  Copyright © 2017年 wenqi. All rights reserved.
//

#import "TeachingVideoCollectionViewCell.h"

@interface TeachingVideoCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imageV;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *collectCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *scanCountLabel;

@end

@implementation TeachingVideoCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setModel:(ALDVideoModel *)model {
    _model = model;
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:model.pic_url]];
    self.titleLabel.text = model.title;
//    self.collectCountLabel.text = [NSString stringWithFormat:@"收藏： %@",model.view_num];
    self.scanCountLabel.text = [NSString stringWithFormat:@"%@ 浏览",model.view_num];
}

@end
