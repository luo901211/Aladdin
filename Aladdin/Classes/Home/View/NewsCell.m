//
//  NewsCell.m
//  Aladdin
//
//  Created by luo on 2017/4/8.
//  Copyright © 2017年 wenqi. All rights reserved.
//

#import "NewsCell.h"
#import "UILabel+ChangeLineSpaceAndWordSpace.h"

@interface NewsCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imgIcon;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblTime;
@property (weak, nonatomic) IBOutlet UILabel *lblSource;

@end

@implementation NewsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.imgIcon.backgroundColor = HEXCOLOR(0xf2f2f2);
}

- (void)setModel:(ALDNewsModel *)model
{
    _model = model;
    [self.imgIcon sd_setImageWithURL:[NSURL URLWithString:model.pic_url] placeholderImage:nil];
    self.lblTitle.text = model.title;
    [UILabel changeLineSpaceForLabel:self.lblTitle WithSpace:4];
    self.lblSource.text = model.source;
    self.lblTime.text = model.add_date;
}

#pragma mark - /************************* 类方法返回行高 ***************************/
+ (CGFloat)heightForRow:(ALDNewsModel *)model {
    return 120;
}

@end
