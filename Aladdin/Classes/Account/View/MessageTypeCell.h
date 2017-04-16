//
//  MessageTypeCell.h
//  Aladdin
//
//  Created by luo on 2017/4/16.
//  Copyright © 2017年 wenqi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ALDMessageTypeModel.h"

@interface MessageTypeCell : UITableViewCell

@property (strong, nonatomic) ALDMessageTypeModel *model;

+ (CGFloat)heightForRow:(ALDMessageTypeModel *)model;

@end
