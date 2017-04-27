//
//  CollectCell.m
//  Aladdin
//
//  Created by luo on 2017/4/19.
//  Copyright © 2017年 wenqi. All rights reserved.
//

#import "CollectCell.h"

@interface CollectCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIButton *collectButton;

@end

@implementation CollectCell

+ (CGFloat)heightForRow:(ALDCollectModel *)model {
    return 120;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setModel:(ALDCollectModel *)model {
    _model = model;
    
    self.titleLabel.text = model.title;
    self.typeLabel.text = [NSString stringWithFormat:@"所属模块: %@", model.type];
    self.timeLabel.text = model.publish_time;
}
- (IBAction)onPressedCollectBtn:(UIButton *)sender {
    if (self.tapCollectBlock) {
        self.tapCollectBlock(sender);
    }
}

@end
