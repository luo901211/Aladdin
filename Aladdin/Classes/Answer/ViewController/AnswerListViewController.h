//
//  AnswerListViewController.h
//  Aladdin
//
//  Created by luo on 2017/4/9.
//  Copyright © 2017年 wenqi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AnswerListViewController : UITableViewController
/**
 *  url端口
 */
@property(nonatomic,copy) NSString *urlString;

@property (nonatomic,assign) NSInteger index;

@end
