//
//  NewsCommentCell.h
//  Aladdin
//
//  Created by luo on 2017/5/19.
//  Copyright © 2017年 wenqi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ALDNewsCommentModel.h"

@interface NewsCommentCell : UITableViewCell

@property (strong, nonatomic) ALDNewsCommentModel  *model;

+ (CGFloat)heightForRow:(ALDNewsCommentModel *)model;

@end
