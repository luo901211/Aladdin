//
//  FinanceCell.h
//  Aladdin
//
//  Created by luo on 2017/4/23.
//  Copyright © 2017年 wenqi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ALDFinanceModel.h"

@interface FinanceCell : UITableViewCell

@property (nonatomic, strong) ALDFinanceModel *model;

+ (CGFloat)heightForRow:(ALDFinanceModel *)model;

@end
