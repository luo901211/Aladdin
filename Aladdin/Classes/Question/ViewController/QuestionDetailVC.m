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
    self.tableView.tableHeaderView = self.bannerView;
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"问答详情";
    self.tableView.tableFooterView = [UIView new];
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
    return 90;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AnswerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AnswerCell"];
    ALDAnswerModel *model = self.model.answer_list[indexPath.row];
    cell.model = model;
    return cell;
}

@end
