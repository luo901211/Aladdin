//
//  MessageTypeListVC.m
//  Aladdin
//
//  Created by luo on 2017/4/16.
//  Copyright © 2017年 wenqi. All rights reserved.
//

#import "MessageTypeListVC.h"
#import "MessageTypeViewModel.h"
#import "ALDMessageTypeModel.h"
#import "MessageTypeCell.h"
#import "MessageListVC.h"

@interface MessageTypeListVC ()

@property (nonatomic, strong) MessageTypeViewModel *viewModel;

@end

@implementation MessageTypeListVC

- (MessageTypeViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[MessageTypeViewModel alloc] init];
    }
    return _viewModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"消息";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.tableView.tableFooterView = [UIView new];
    [self.tableView registerNib:[UINib nibWithNibName:@"MessageTypeCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MessageTypeCell"];
    
    __weak MessageTypeListVC *weakSelf = self;
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
    
    [self.viewModel getMessageTypeWithSuccess:^(id obj) {
        
        @strongify(self);
        [self.tableView.mj_header endRefreshing];
        [self.tableView reloadData];
        
    } failure:^(id obj) {
        [self.tableView.mj_header endRefreshing];
        [MBProgressHUD showAutoMessage:obj];

    }];
}

#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    ALDMessageTypeModel *model = self.viewModel.messageTypeList[indexPath.row];
    return [MessageTypeCell heightForRow:model];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.messageTypeList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MessageTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MessageTypeCell"];
    ALDMessageTypeModel *model = self.viewModel.messageTypeList[indexPath.row];
    cell.model = model;
    return cell;
}

#pragma mark - Table view delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MessageListVC *vc = [[MessageListVC alloc] init];
    ALDMessageTypeModel *model = self.viewModel.messageTypeList[indexPath.row];
    vc.type = model.type;
    [self.navigationController pushViewController:vc animated:YES];
}


@end
