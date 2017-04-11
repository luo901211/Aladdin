//
//  NewsListViewController.h
//  Aladdin
//
//  Created by luo on 2017/4/8.
//  Copyright © 2017年 wenqi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsListViewModel.h"

@interface NewsListViewController : UITableViewController

@property (nonatomic, strong) NewsListViewModel *viewModel;

@end
