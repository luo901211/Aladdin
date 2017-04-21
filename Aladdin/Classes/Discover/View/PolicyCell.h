//
//  PolicyCell.h
//  Aladdin
//
//  Created by luo on 2017/4/21.
//  Copyright © 2017年 wenqi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ALDPolicyModel.h"

@interface PolicyCell : UITableViewCell

@property (nonatomic, strong) ALDPolicyModel *model;

+ (CGFloat)heightForRow:(ALDPolicyModel *)model;
@end
