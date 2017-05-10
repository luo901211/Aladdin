//
//  FinanceChapterListVC.m
//  Aladdin
//
//  Created by luo on 2017/4/23.
//  Copyright © 2017年 wenqi. All rights reserved.
//

#import "FinanceChapterListVC.h"
#import <RATreeView.h>
#import "FinanceChapterCell.h"
#import "ALDFinanceChapterModel.h"
#import "FinanceChapterListViewModel.h"
#import "FinanceDetailVC.h"

@interface FinanceChapterListVC ()<RATreeViewDelegate, RATreeViewDataSource>

@property (strong, nonatomic) FinanceChapterListViewModel *viewModel;
@property (strong, nonatomic) RATreeView *treeView;
@end

@implementation FinanceChapterListVC

- (FinanceChapterListViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[FinanceChapterListViewModel alloc] init];
    }
    return _viewModel;
}

- (RATreeView *)treeView {
    if (!_treeView) {
        _treeView = [[RATreeView alloc] initWithFrame:self.view.bounds];
        _treeView.delegate = self;
        _treeView.dataSource = self;
        _treeView.treeFooterView = [UIView new];
        _treeView.separatorStyle = RATreeViewCellSeparatorStyleSingleLine;
        _treeView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;

        [_treeView registerNib:[UINib nibWithNibName:NSStringFromClass([FinanceChapterCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([FinanceChapterCell class])];

    }
    return _treeView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.treeView];
    
    [self loadData];
}

- (void)loadData {
    [self.viewModel loadDataWithID:self.ID success:^(id obj) {
        [self.treeView reloadData];
    } failure:^(id obj) {
        [MBProgressHUD showAutoMessage:obj];
    }];
}

#pragma mark TreeView Delegate methods

- (CGFloat)treeView:(RATreeView *)treeView heightForRowForItem:(id)item
{
    return 52;
}
- (void)treeView:(RATreeView *)treeView didSelectRowForItem:(id)item {
    NSInteger level = [self.treeView levelForCellForItem:item];
    if (level == 2) {
        
        if ([User sharedInstance].isLogin) {
            ALDFinanceChapterModel *model = item;
            FinanceDetailVC *vc = [[FinanceDetailVC alloc] init];
            vc.ID = model.ID;
            vc.title = model.title;
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            // 请先登录
            [User presentLoginViewController];
        }
    }

}
#pragma mark TreeView Data Source

- (UITableViewCell *)treeView:(RATreeView *)treeView cellForItem:(id)item
{
    ALDFinanceChapterModel *model = item;
    NSInteger level = [self.treeView levelForCellForItem:item];
    FinanceChapterCell *cell = [self.treeView dequeueReusableCellWithIdentifier:NSStringFromClass([FinanceChapterCell class])];
    cell.model = model;
    cell.level = level;
    return cell;
}

- (NSInteger)treeView:(RATreeView *)treeView numberOfChildrenOfItem:(id)item
{
    if (item == nil) {
        return [self.viewModel.list count];
    }
    
    ALDFinanceChapterModel *data = item;
    return [data.child count];
}

- (id)treeView:(RATreeView *)treeView child:(NSInteger)index ofItem:(id)item
{
    ALDFinanceChapterModel *data = item;
    if (item == nil) {
        return [self.viewModel.list objectAtIndex:index];
    }
    
    return data.child[index];
}

@end
