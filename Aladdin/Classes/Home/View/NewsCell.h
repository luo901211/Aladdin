//
//  NewsCell.h
//  Aladdin
//
//  Created by luo on 2017/4/8.
//  Copyright © 2017年 wenqi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsModel.h"

@interface NewsCell : UITableViewCell

@property(nonatomic,strong) NewsModel *model;

/**
 *  类方法返回行高
 */
+ (CGFloat)heightForRow:(NewsModel *)model;

@end
