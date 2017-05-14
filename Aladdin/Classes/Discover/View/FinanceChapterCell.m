//
//  FinanceChapterCell.m
//  Aladdin
//
//  Created by luo on 2017/5/10.
//  Copyright © 2017年 wenqi. All rights reserved.
//

#import "FinanceChapterCell.h"

@interface FinanceChapterCell()
@property (weak, nonatomic) IBOutlet UIImageView *imageV;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leadingToImageV;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageViewLeft;

@end

@implementation FinanceChapterCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setModel:(ALDFinanceChapterModel *)model {
    _model = model;
    self.titleLabel.text = model.title;
}

- (void)setLevel:(NSInteger)level {
    _level = level;
//    self.leadingToImageV.constant = level * 10;
    self.imageViewLeft.constant = 25 * level;
    self.imageV.image = [UIImage imageNamed:[NSString stringWithFormat:@"chapter_%ld",(long)level + 1]];
    self.backgroundColor = level == 0 ? HEXCOLOR(0xf7f9fc) : [UIColor whiteColor];
    self.accessoryType = level == 2 ? UITableViewCellAccessoryDisclosureIndicator : UITableViewCellAccessoryNone;
    
    if (level == 0) {
        self.titleLabel.font = [UIFont systemFontOfSize:14];
        self.titleLabel.textColor = HEXCOLOR(0x333333);
    }else if (level == 1) {
        self.titleLabel.font = [UIFont systemFontOfSize:13];
        self.titleLabel.textColor = HEXCOLOR(0x333333);
    }else {
        self.titleLabel.font = [UIFont systemFontOfSize:13];
        self.titleLabel.textColor = HEXCOLOR(0x666666);
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
