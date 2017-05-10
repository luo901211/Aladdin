//
//  DiscoverListViewController.m
//  Aladdin
//
//  Created by luo on 2017/4/9.
//  Copyright © 2017年 wenqi. All rights reserved.
//

#import "DiscoverListViewController.h"
#import "DiscoverCell.h"
#import "DiscoverModel.h"
#import "TeachingVideoContainerVC.h"
#import "FinanceListVC.h"
#import "PolicyListVC.h"
#import "ExpertContainerVC.h"
@interface DiscoverListViewController ()

@property (nonatomic, strong) NSMutableArray *arrayList;

@end

@implementation DiscoverListViewController

-(NSMutableArray *)arrayList {
    if (!_arrayList) {
        _arrayList = [NSMutableArray array];
        NSArray *array = @[
                           @{@"imageUrl": @"teaching_cell", @"title": @"教学视频"},
                           @{@"imageUrl": @"professor_cell", @"title": @"大咖专栏"},
                           @{@"imageUrl": @"finance_cell", @"title": @"财务秘籍"},
                           @{@"imageUrl": @"policies_cell", @"title": @"政策法规"}
                          ];
        for (int i = 0 ; i<array.count; i++) {
            DiscoverModel *model = [DiscoverModel modelWithDict:array[i]];
            [_arrayList addObject:model];
        }
    }
    return _arrayList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"发现";
    
    self.tableView.tableFooterView = [UIView new];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:@"DiscoverCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"DiscoverCell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 136 * kScreenWidthRatio;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrayList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DiscoverCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DiscoverCell"];
    cell.model = self.arrayList[indexPath.row];
    return cell;
}

#pragma mark - Table view delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
        {
            TeachingVideoContainerVC *vc = [[TeachingVideoContainerVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 1:
        {
            ExpertContainerVC *vc = [[ExpertContainerVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 2:
        {
            FinanceListVC *vc = [[FinanceListVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 3:
        {
            PolicyListVC *vc = [[PolicyListVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
            
        default:
            break;
    }
    
}

@end
