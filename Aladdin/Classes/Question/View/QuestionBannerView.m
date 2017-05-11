//
//  QuestionBannerView.m
//  Aladdin
//
//  Created by luo on 2017/5/11.
//  Copyright © 2017年 wenqi. All rights reserved.
//

#import "QuestionBannerView.h"
#import "UILabel+ChangeLineSpaceAndWordSpace.h"

#define kLineSpacing 2

@interface QuestionBannerView ()
@property (weak, nonatomic) IBOutlet UIButton *collectButton;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UILabel *scanLabel;
@property (weak, nonatomic) IBOutlet UILabel *replyLabel;

@end

@implementation QuestionBannerView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.collectButton.layer.cornerRadius = 3;
}

- (void)setModel:(ALDQuestionDetailModel *)model {
    _model = model;
    self.titleLabel.text = model.title;
    self.descLabel.text = model.content;
    self.scanLabel.text = model.view_num;
    self.replyLabel.text = model.answer_count;
    
    [UILabel changeLineSpaceForLabel:self.titleLabel WithSpace:kLineSpacing];
    [UILabel changeLineSpaceForLabel:self.descLabel WithSpace:kLineSpacing];

    CGFloat titleHeight = [self calculateHeightWithString:model.title font:self.titleLabel.font lineSpacing:kLineSpacing];
    CGFloat contentHeight = [self calculateHeightWithString:model.content font:self.descLabel.font lineSpacing:kLineSpacing];
    self.height = 20 + titleHeight + 15 + contentHeight + 126;
}

- (CGFloat)calculateHeightWithString:(NSString *)string font:(UIFont *)font lineSpacing:(CGFloat)lineSpacing {
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:string];
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.lineSpacing = lineSpacing;
    [attributeString addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, string.length)];
    [attributeString addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, string.length)];
    NSStringDrawingOptions options = NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    CGRect rect = [attributeString boundingRectWithSize:CGSizeMake(Main_Screen_Width - 30, CGFLOAT_MAX) options:options context:nil];
    return rect.size.height;
}


- (IBAction)didPressedOnCollectButton:(UIButton *)sender {
}
- (IBAction)didPressedOnInviteButton:(UIButton *)sender {
}
- (IBAction)didPressedOnReplyButton:(UIButton *)sender {
}

@end
