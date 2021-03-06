//
//  NewsCommentCell.m
//  Aladdin
//
//  Created by luo on 2017/5/19.
//  Copyright © 2017年 wenqi. All rights reserved.
//

#import "NewsCommentCell.h"
#import "UILabel+ChangeLineSpaceAndWordSpace.h"
#define kLabelMaxWidth Main_Screen_Width - 15 - 42 - 25 - 25

@interface NewsCommentCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imageV;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIImageView *bubbleImageV;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bubbleWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bubbleHeight;

@end

@implementation NewsCommentCell

+ (CGFloat)heightForRow:(ALDNewsCommentModel *)model {
    UIFont *font = [UIFont systemFontOfSize:14];
    
    CGSize size = [NewsCommentCell calculateHeightWithString:model.content font:font lineSpacing:5];
    
    return size.height + 70;
};

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.contentView.backgroundColor = HEXCOLOR(0xf6f6f6);
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.imageV.layer.cornerRadius = self.imageV.height / 2;
    self.imageV.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)setModel:(ALDNewsCommentModel *)model {
    _model = model;
    self.nameLabel.text = model.real_name;
    self.contentLabel.text = model.content;
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:model.pic_url]];
    
    [UILabel changeLineSpaceForLabel:self.contentLabel WithSpace:5];
    CGSize size = [NewsCommentCell calculateHeightWithString:self.contentLabel.text font:self.contentLabel.font lineSpacing:5];
    self.bubbleWidth.constant = size.width + 15 * 2;
    self.bubbleHeight.constant = size.height + 10 * 2;
    UIImage *bubbleImage = [[UIImage imageNamed:@"bubble_bg"] stretchableImageWithLeftCapWidth:30 topCapHeight:30];
    self.bubbleImageV.image = bubbleImage;
}

+ (CGSize)calculateHeightWithString:(NSString *)string font:(UIFont *)font lineSpacing:(CGFloat)lineSpacing {
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:string];
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.lineSpacing = lineSpacing;
    [attributeString addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, string.length)];
    [attributeString addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, string.length)];
    NSStringDrawingOptions options = NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    CGRect rect = [attributeString boundingRectWithSize:CGSizeMake(kLabelMaxWidth, CGFLOAT_MAX) options:options context:nil];
    return rect.size;
}

@end
