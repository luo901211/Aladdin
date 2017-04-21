//
//  MessageTypeCell.m
//  Aladdin
//
//  Created by luo on 2017/4/16.
//  Copyright © 2017年 wenqi. All rights reserved.
//

#import "MessageTypeCell.h"

@interface MessageTypeCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imageV;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *msgLabel;

@end

@implementation MessageTypeCell

+ (CGFloat)heightForRow:(ALDMessageTypeModel *)model {
    return 92;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(ALDMessageTypeModel *)model {
    _model = model;
    
    self.imageV.image = [UIImage imageNamed:[NSString stringWithFormat:@"message_item_%ld", (long)model.type]];
    self.typeLabel.text = model.type_name;
    self.msgLabel.text = model.msg;
}

@end
