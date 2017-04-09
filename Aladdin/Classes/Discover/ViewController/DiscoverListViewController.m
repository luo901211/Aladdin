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

@interface DiscoverListViewController ()

@property (nonatomic, strong) NSMutableArray *arrayList;

@end

@implementation DiscoverListViewController

-(NSMutableArray *)arrayList {
    if (!_arrayList) {
        _arrayList = [NSMutableArray array];
        NSDictionary *dic = @{@"imageUrl": @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1492330959&di=1fb52e3d77abdd4eb2b194edf750a9a5&imgtype=jpg&er=1&src=http%3A%2F%2Fi.gtimg.cn%2Fqqlive%2Fimg%2Fjpgcache%2Ffiles%2Fqqvideo%2Fhori%2Fn%2Fn4bzy3vznfrz4xm_big.jpg"};
        
        DiscoverModel *model = [DiscoverModel modelWithDict:dic];
        [_arrayList addObjectsFromArray:@[model,model,model,model]];
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
    TeachingVideoContainerVC *vc = [[TeachingVideoContainerVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
