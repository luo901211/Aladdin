//
//  QuestionDetailVC.m
//  Aladdin
//
//  Created by luo on 2017/5/11.
//  Copyright © 2017年 wenqi. All rights reserved.
//

#import "QuestionDetailVC.h"
#import "ALDQuestionDetailModel.h"
#import "QuestionDetailViewModel.h"
#import "AnswerCell.h"
#import "QuestionBannerView.h"
#import "ExpertContainerVC.h"
#import "AnswerViewController.h"
#import "ALDBaseNavigationController.h"
#import "ALDExpertModel.h"

@interface QuestionDetailVC ()<UIAlertViewDelegate>

@property (nonatomic, strong) QuestionDetailViewModel *viewModel;

@property (nonatomic, strong) ALDQuestionDetailModel *model;
@property (nonatomic, strong) QuestionBannerView *bannerView;

@end

@implementation QuestionDetailVC

- (QuestionDetailViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[QuestionDetailViewModel alloc] init];
    }
    return _viewModel;
}

- (QuestionBannerView *)bannerView {
    if (!_bannerView) {
        _bannerView = [[NSBundle mainBundle] loadNibNamed:@"QuestionBannerView" owner:nil options:nil][0];
    }
    return _bannerView;
}

- (void)setModel:(ALDQuestionDetailModel *)model {
    _model = model;
    self.bannerView.model = model;
    
    @weakify(self);
    self.bannerView.tapCollectBlock = ^(id obj) {
        if (![User sharedInstance].isLogin) {
            return [User presentLoginViewController];
        }
        
        @strongify(self);
        
        [self.viewModel collectDataWithID:self.ID success:^(id obj) {
            [MBProgressHUD showAutoMessage:@"收藏成功"];
        } failure:^(id obj) {
            [MBProgressHUD showAutoMessage:obj];
        }];
    };
    
    // 邀请回答
    self.bannerView.tapInviteBlock = ^(id obj) {
        
        if (![User sharedInstance].isLogin) {
            return [User presentLoginViewController];
        }
        
        @strongify(self);
        ExpertContainerVC *vc = [[ExpertContainerVC alloc] init];
        vc.title = @"邀请回答";
        vc.expertTapBlock = ^(ALDExpertModel *model) {
            [MBProgressHUD showAutoMessage:[NSString stringWithFormat:@"邀请专家id： %ld",(long)model.ID]];
        };
        ALDBaseNavigationController *nav = [[ALDBaseNavigationController alloc] initWithRootViewController:vc];
        [self.navigationController presentViewController:nav animated:YES completion:nil];
    };
    // 添加回答
    self.bannerView.tapReplyBlock = ^(id obj) {
        if (![User sharedInstance].isLogin) {
            return [User presentLoginViewController];
        }
        
        @strongify(self);
        AnswerViewController *vc = [[AnswerViewController alloc]initWithNibName:@"AnswerViewController" bundle:nil];;
        vc.ID = self.ID;
        vc.questionTitle = self.model.title;
        ALDBaseNavigationController *nav = [[ALDBaseNavigationController alloc] initWithRootViewController:vc];
        [self.navigationController presentViewController:nav animated:YES completion:nil];
    };
    
    self.tableView.tableHeaderView = self.bannerView;
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"问答详情";
    self.tableView.tableFooterView = [UIView new];
    self.tableView.backgroundColor = HEXCOLOR(0xf6f6f6);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:@"AnswerCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"AnswerCell"];
    [self loadData];
}

- (void)loadData {
    @weakify(self);
    [self.viewModel loadDataWithID:self.ID success:^(id obj) {
        @strongify(self);
        ALDQuestionDetailModel *model = [ALDQuestionDetailModel mj_objectWithKeyValues:obj];
        self.model = model;
    } failure:^(id obj) {
        [MBProgressHUD showAutoMessage:obj];
    }];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.model.answer_list.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    ALDAnswerModel *model = self.model.answer_list[indexPath.row];
    return [AnswerCell heightForRow:model];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AnswerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AnswerCell"];
    ALDAnswerModel *model = self.model.answer_list[indexPath.row];
    cell.model = model;
    cell.longPressedBlock = ^(id obj){
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"设置最佳回答" message:@"是否将该回答设为最佳回答" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alertView.tag = indexPath.row + 100;
        [alertView show];
    };
    return cell;
}
#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        NSInteger modelIndex = alertView.tag - 100;
        ALDAnswerModel *model = self.model.answer_list[modelIndex];
        NSLog(@"设为最佳答案");
    }
}
@end
