//
//  QuestionBannerView.h
//  Aladdin
//
//  Created by luo on 2017/5/11.
//  Copyright © 2017年 wenqi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ALDQuestionDetailModel.h"

@interface QuestionBannerView : UIView

@property (strong, nonatomic) ALDQuestionDetailModel *model;
@property (copy, nonatomic) VoidBlock tapCollectBlock;
@property (copy, nonatomic) VoidBlock tapInviteBlock;
@property (copy, nonatomic) VoidBlock tapReplyBlock;

@end
