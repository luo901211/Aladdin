//
//  DiscoverCell.h
//  Aladdin
//
//  Created by luo on 2017/4/9.
//  Copyright © 2017年 wenqi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DiscoverModel.h"

@interface DiscoverCell : UITableViewCell

@property (nonatomic, strong) DiscoverModel *model;

+ (CGFloat)heightForRow:(DiscoverModel *)model;

@end
