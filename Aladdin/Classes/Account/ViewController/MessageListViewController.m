//
//  MessageListViewController.m
//  Aladdin
//
//  Created by luo on 2017/4/16.
//  Copyright © 2017年 wenqi. All rights reserved.
//

#import "MessageListViewController.h"
#import "MessageListViewModel.h"
#import "MessageCell.h"

@interface MessageListViewController ()

@property (nonatomic, strong) MessageListViewModel *viewModel;

@end

@implementation MessageListViewController

- (MessageListViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[MessageListViewModel alloc] init];
    }
    return _viewModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"评论";
    
    self.tableView.tableFooterView = [UIView new];
    [self.tableView registerNib:[UINib nibWithNibName:@"MessageCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MessageCell"];
    
    __weak MessageListViewController *weakSelf = self;
    self.tableView.mj_header = [WQChiBaoZiHeader headerWithRefreshingBlock:^{
        [weakSelf loadDataWithType:WQFetchDataTypeRefresh];
    }];
    
    [self.tableView.mj_header beginRefreshing];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - /************************* 刷新数据 ***************************/

- (void)loadDataWithType:(WQFetchDataType)type
{
    @weakify(self);
    
    [self.viewModel getMessageListWithType:self.type Success:^(id obj) {
        
        @strongify(self);
        [self.tableView.mj_header endRefreshing];
        [self.tableView reloadData];
        
    } failure:^(id obj) {
        [self.tableView.mj_header endRefreshing];
        NSLog(@"error: %@",obj);

    }];
}

#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    ALDMessageModel *model = self.viewModel.messageList[indexPath.row];
//    return [MessageCell heightForRow:model];
    return 76;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return self.viewModel.messageList.count;
    return 12;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MessageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MessageCell"];
//    ALDMessageModel *model = self.viewModel.messageList[indexPath.row];
//    cell.model = model;
    return cell;
}

#pragma mark - Table view delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {


}



@end