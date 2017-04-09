//
//  AnswerListViewController.m
//  Aladdin
//
//  Created by luo on 2017/4/9.
//  Copyright © 2017年 wenqi. All rights reserved.
//

#import "AnswerListViewController.h"
#import "AnswerViewModel.h"
#import "AnswerModel.h"
#import "AnswerCell.h"
#import "WQChiBaoZiHeader.h"

@interface AnswerListViewController ()

@property(nonatomic,strong) NSMutableArray *arrayList;

@property (nonatomic, strong) AnswerViewModel *viewModel;

@end

@implementation AnswerListViewController

- (AnswerViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[AnswerViewModel alloc] init];
    }
    return _viewModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.tableFooterView = [UIView new];
    [self.tableView registerNib:[UINib nibWithNibName:@"AnswerCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"AnswerCell"];
    self.urlString = @"headline/T1348647853363";
    
    __weak AnswerListViewController *weakSelf = self;
    self.tableView.mj_header = [WQChiBaoZiHeader headerWithRefreshingBlock:^{
        [weakSelf loadData];
    }];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf loadMoreData];
    }];
    
    [self.tableView.mj_header beginRefreshing];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - /************************* 刷新数据 ***************************/
// ------下拉刷新
- (void)loadData
{
    // http://c.m.163.com//nc/article/headline/T1348647853363/0-30.html
    NSString *allUrlstring = [NSString stringWithFormat:@"/nc/article/%@/0-20.html",self.urlString];
    [self loadDataForType:1 withURL:allUrlstring];
}

// ------上拉加载
- (void)loadMoreData
{
    //    NSString *allUrlstring = [NSString stringWithFormat:@"/nc/article/%@/%ld-20.html",self.urlString,self.arrayList.count];
    NSString *allUrlstring = [NSString stringWithFormat:@"/nc/article/%@/%ld-20.html",self.urlString,(long)(self.arrayList.count - self.arrayList.count%10)];
    [self loadDataForType:2 withURL:allUrlstring];
}

// ------公共方法
- (void)loadDataForType:(int)type withURL:(NSString *)allUrlstring
{
    @weakify(self)
    [[self.viewModel.fetchAnswerModelCommand execute:allUrlstring]subscribeNext:^(NSArray *arrayM) {
        @strongify(self)
        if (type == 1) {
            self.arrayList = [arrayM mutableCopy];
            [self.tableView.mj_header endRefreshing];
            [self.tableView reloadData];
        }else if(type == 2){
            [self.arrayList addObjectsFromArray:arrayM];
            [self.tableView.mj_footer endRefreshing];
            [self.tableView reloadData];
        }
    } error:^(NSError *error) {
        NSLog(@"%@",error.userInfo);
    }];
}

#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    AnswerModel *model = self.arrayList[indexPath.row];
    return [AnswerCell heightForRow:model];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrayList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AnswerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AnswerCell"];
    AnswerModel *model = self.arrayList[indexPath.row];
    cell.model = model;
    return cell;
}

@end
