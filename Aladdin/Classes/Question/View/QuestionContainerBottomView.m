//
//  QuestionContainerBottomView.m
//  Aladdin
//
//  Created by luo on 2017/4/26.
//  Copyright © 2017年 wenqi. All rights reserved.
//

#import "QuestionContainerBottomView.h"

@interface QuestionContainerBottomView ()
@property (weak, nonatomic) IBOutlet UIButton *freeAskBtn;
@property (weak, nonatomic) IBOutlet UIButton *expertAskBtn;

@end

@implementation QuestionContainerBottomView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)awakeFromNib {
    [super awakeFromNib];
    self.freeAskBtn.layer.cornerRadius = 3;
    self.freeAskBtn.layer.masksToBounds = YES;
    self.expertAskBtn.layer.cornerRadius = 3;
    self.expertAskBtn.layer.masksToBounds = YES;
}
- (IBAction)onPressedFreeAskButton:(UIButton *)sender {
    if (self.freeAskBlock) {
        self.freeAskBlock(sender);
    }
}
- (IBAction)onPressedExpertAskButton:(UIButton *)sender {
    if (self.expertAskBlock) {
        self.expertAskBlock(sender);
    }
}

@end
