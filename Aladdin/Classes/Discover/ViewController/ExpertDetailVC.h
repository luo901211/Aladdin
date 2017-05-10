//
//  ExpertDetailVC.h
//  Aladdin
//
//  Created by luo on 2017/4/25.
//  Copyright © 2017年 wenqi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExpertDetailVC : UIViewController

//[_arrayList addObject:@{@"title": @"知名专家", @"level": @(2)}];
//[_arrayList addObject:@{@"title": @"优秀回答者", @"level": @(1)}];
@property (nonatomic, assign) NSInteger level;

@property (assign, nonatomic) NSInteger ID;

@end
