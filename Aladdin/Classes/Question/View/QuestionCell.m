//
//  QuestionCell.m
//  Aladdin
//
//  Created by luo on 2017/4/25.
//  Copyright © 2017年 wenqi. All rights reserved.
//

#import "QuestionCell.h"
#import "UILabel+ChangeLineSpaceAndWordSpace.h"

#define kLineSpacing 4
@interface QuestionCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *essenceLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *answerCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *solveLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *spaceOfNameLabelToContentView;

@end

@implementation QuestionCell

+ (CGFloat)heightForRow:(ALDQuestionModel *)model {
    
    NSString *str = model.title;
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:str];
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.lineSpacing = kLineSpacing;
    UIFont *font = [UIFont systemFontOfSize:16];
    [attributeString addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, str.length)];
    [attributeString addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, str.length)];
    NSStringDrawingOptions options = NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    CGRect rect = [attributeString boundingRectWithSize:CGSizeMake(Main_Screen_Width - 30, CGFLOAT_MAX) options:options context:nil];
    
    return rect.size.height + 55;
}
- (void)setModel:(ALDQuestionModel *)model {
    _model = model;
    
    self.titleLabel.text = model.title;
    [UILabel changeLineSpaceForLabel:self.titleLabel WithSpace:kLineSpacing];
    self.essenceLabel.hidden = [model.is_essence isEqualToString:@"1"] ? NO : YES;
    self.spaceOfNameLabelToContentView.constant = [model.is_essence isEqualToString:@"1"] ? 36 : 15;
    self.nameLabel.text = model.real_name;
    self.timeLabel.text = model.add_date;
    self.answerCountLabel.text = model.answer_count;
    self.solveLabel.text = [model.is_solve isEqualToString:@"1"] ? @"已解决" : @"未解决";
    self.solveLabel.textColor = [model.is_solve isEqualToString:@"1"] ? HEXCOLOR(0xffa02f) : HEXCOLOR(0x999999);
    self.solveLabel.layer.borderColor = self.solveLabel.textColor.CGColor;

}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.essenceLabel.layer.cornerRadius = 3;
    self.essenceLabel.layer.masksToBounds = YES;
    self.essenceLabel.layer.borderWidth = 1;
    self.essenceLabel.layer.borderColor = HEXCOLOR(0xffa02f).CGColor;
    self.essenceLabel.textColor = HEXCOLOR(0xffa02f);
    
    self.solveLabel.layer.cornerRadius = self.solveLabel.height/2;
    self.solveLabel.layer.masksToBounds = YES;
    self.solveLabel.layer.borderWidth = 1;
}
@end
