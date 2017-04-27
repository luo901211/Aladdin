//
//  NewsDetailBottomView.m
//  Aladdin
//
//  Created by luo on 2017/4/12.
//  Copyright © 2017年 wenqi. All rights reserved.
//

#import "NewsDetailBottomView.h"
#import "UIView+CustomBorder.h"
#import "UIView+BlockGesture.h"

@interface NewsDetailBottomView ()

@property (weak, nonatomic) IBOutlet UILabel *commentLabel;
@property (weak, nonatomic) IBOutlet UIImageView *shareImageV;
@property (weak, nonatomic) IBOutlet UILabel *commentCountLabel;

@end

@implementation NewsDetailBottomView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.backgroundColor = HEXCOLOR(0xf6f6f6);
    
    self.commentLabel.userInteractionEnabled = self.shareImageV.userInteractionEnabled = self.commentCountLabel.userInteractionEnabled = YES;
    
    @weakify(self)
    [self.commentLabel addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        @strongify(self);
        if (self.commentBlock) {
            self.commentBlock();
        }
    }];
    
    [self.shareImageV addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        @strongify(self);
        if (self.shareBlock) {
            self.shareBlock();
        }
    }];
    
    [self.commentCountLabel addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        @strongify(self);
        if (self.commentListBlock) {
            self.commentListBlock();
        }
    }];
}

- (void)setCommentCount:(NSString *)commentCount {
    _commentCount = commentCount;
    self.commentCountLabel.text = commentCount;
}

@end
