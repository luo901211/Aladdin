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
#import "ExpertListVC.h"
#import "AnswerViewController.h"
#import "ALDBaseNavigationController.h"

@interface QuestionDetailVC ()

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
    self.bannerView.tapInviteBlock = ^(id obj) {
        
        if (![User sharedInstance].isLogin) {
            return [User presentLoginViewController];
        }
        
        @strongify(self);
        ExpertListVC *vc = [[ExpertListVC alloc] init];
        vc.level = 2;//知名专家
        vc.title = @"邀请回答";
        vc.inviteReplyBlock = ^(NSNumber *ID) {
            [MBProgressHUD showAutoMessage:[NSString stringWithFormat:@"邀请专家id： %@",ID]];
        };
        ALDBaseNavigationController *nav = [[ALDBaseNavigationController alloc] initWithRootViewController:vc];
        [self.navigationController presentViewController:nav animated:YES completion:nil];
    };
    self.bannerView.tapReplyBlock = ^(id obj) {
        if (![User sharedInstance].isLogin) {
            return [User presentLoginViewController];
        }
        
        @strongify(self);
        AnswerViewController *vc = [[AnswerViewController alloc]initWithNibName:@"AnswerViewController" bundle:nil];;
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
    return cell;
}

@end
