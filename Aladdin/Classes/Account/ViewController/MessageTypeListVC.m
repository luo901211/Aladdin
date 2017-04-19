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
#import "SystemMessageListVC.h"
#import "AnswerListVC.h"
#import "CommentListVC.h"

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
        NSLog(@"error: %@",obj);
        
    }];
}

#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    ALDMessageTypeModel *model = self.viewModel.messageTypeList[indexPath.row];
//    return [MessageTypeCell heightForRow:model];
    return 92;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return self.viewModel.messageTypeList.count;
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MessageTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MessageTypeCell"];
//    ALDMessageTypeModel *model = self.viewModel.messageTypeList[indexPath.row];
//    cell.model = model;
    return cell;
}

#pragma mark - Table view delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //    ALDMessageTypeModel *model = self.viewModel.messageTypeList[indexPath.row];
    //    vc.type = model.type;

    switch (indexPath.row) {
        case 0:
        {
            SystemMessageListVC *vc = [[SystemMessageListVC alloc] init];
            vc.type = 1;
            [self.navigationController pushViewController:vc animated:YES];

        }
            break;
        case 1:
        {
            CommentListVC *vc = [[CommentListVC alloc] init];
            vc.type = 1;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 2:
        {
            AnswerListVC *vc = [[AnswerListVC alloc] init];
            vc.type = 1;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        default:
            break;
    }
}


@end
