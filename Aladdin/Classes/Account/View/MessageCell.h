//
//  MessageCell.h
//  Aladdin
//
//  Created by luo on 2017/4/16.
//  Copyright © 2017年 wenqi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ALDMessageModel.h"

@interface MessageCell : UITableViewCell

@property (strong, nonatomic) ALDMessageModel *model;

+ (CGFloat)heightForRow:(ALDMessageModel *)model;

@end
