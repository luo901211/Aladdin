//
//  FinanceChapterCell.h
//  Aladdin
//
//  Created by luo on 2017/5/10.
//  Copyright © 2017年 wenqi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ALDFinanceChapterModel.h"

@interface FinanceChapterCell : UITableViewCell

@property (strong, nonatomic) ALDFinanceChapterModel *model;

@property (assign, nonatomic) NSInteger level;

@end
