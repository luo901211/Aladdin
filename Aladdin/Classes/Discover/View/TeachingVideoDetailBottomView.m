//
//  TeachingVideoDetailBottomView.m
//  Aladdin
//
//  Created by luo on 2017/4/24.
//  Copyright © 2017年 wenqi. All rights reserved.
//

#import "TeachingVideoDetailBottomView.h"

@interface TeachingVideoDetailBottomView ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *teacherLabel;
@property (weak, nonatomic) IBOutlet UILabel *viewCountLabel;
@property (weak, nonatomic) IBOutlet UIButton *collectButton;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;

@end

@implementation TeachingVideoDetailBottomView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)setModel:(ALDVideoDetailModel *)model {
    _model = model;
    self.titleLabel.text = model.title;
    self.teacherLabel.text = model.teacher;
    self.viewCountLabel.text = model.view_num;
    self.collectButton.selected = model.is_collect;
    self.descLabel.text = model.desc;

    CGFloat height = [self.descLabel.text heightForFont:self.descLabel.font width:self.descLabel.width];
    self.height = self.descLabel.top + height + 15;
    
}

- (IBAction)onPressed:(UIButton *)sender {
    if (self.collectTapBlock) {
        self.collectTapBlock(sender);
    }
}

@end
