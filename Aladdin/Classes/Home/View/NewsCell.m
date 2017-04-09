//
//  NewsCell.m
//  Aladdin
//
//  Created by luo on 2017/4/8.
//  Copyright © 2017年 wenqi. All rights reserved.
//

#import "NewsCell.h"

@interface NewsCell ()

/**
 *  图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *imgIcon;
/**
 *  标题
 */
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;

/**
 *  描述
 */
@property (weak, nonatomic) IBOutlet UILabel *lblSubtitle;

@end

@implementation NewsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(NewsModel *)model
{
    _model = model;
    
    [self.imgIcon sd_setImageWithURL:[NSURL URLWithString:self.model.imgsrc] placeholderImage:[UIImage imageNamed:@"302"]];
    self.lblTitle.text = self.model.title;
    self.lblSubtitle.text = self.model.source;
}

#pragma mark - /************************* 类方法返回行高 ***************************/
+ (CGFloat)heightForRow:(NewsModel *)model {
    return 100;
}

@end
