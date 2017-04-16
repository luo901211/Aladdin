//
//  ServerCell.h
//  Aladdin
//
//  Created by luo on 2017/4/16.
//  Copyright © 2017年 wenqi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ALDServerModel.h"

@interface ServerCell : UITableViewCell

@property (strong, nonatomic) ALDServerModel *model;

+ (CGFloat)heightForRow:(ALDServerModel *)model;

@end
