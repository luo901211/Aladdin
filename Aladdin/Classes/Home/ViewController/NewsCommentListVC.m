//
//  NewsCommentListVC.m
//  Aladdin
//
//  Created by luo on 2017/5/19.
//  Copyright © 2017年 wenqi. All rights reserved.
//

#import "NewsCommentListVC.h"
#import "NewsCommentListViewModel.h"
#import "ALDNewsCommentModel.h"
#import "NewsCommentCell.h"

@interface NewsCommentListVC ()

@property(strong, nonatomic) NewsCommentListViewModel *viewModel;

@end

@implementation NewsCommentListVC

- (NewsCommentListViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[NewsCommentListViewModel alloc] init];
        _viewModel.ID = self.ID;
    }
    return _viewModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"资讯评论";
    self.tableView.tableFooterView = [UIView new];
    [self.tableView registerNib:[UINib nibWithNibName:@"NewsCommentCell" bundle:[NSBundle mainBundle]]forCellReuseIdentifier:@"NewsCommentCell"];
    self.tableView.backgroundColor = HEXCOLOR(0xf6f6f6);
    [self loadData];
}

- (void)loadData {
    [self.viewModel loadCommentListWithCompleted:^(NSError *error) {
        if (error) {
            [MBProgressHUD showAutoMessage:error.localizedDescription];
        }else{
            [self.tableView reloadData];
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    ALDNewsCommentModel *model = self.viewModel.list[indexPath.row];
    return [NewsCommentCell heightForRow:model];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NewsCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NewsCommentCell"];
    ALDNewsCommentModel *model = self.viewModel.list[indexPath.row];
    cell.model = model;
    return cell;
}

@end
