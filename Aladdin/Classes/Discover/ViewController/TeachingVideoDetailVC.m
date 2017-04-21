//
//  TeachingVideoDetailVC.m
//  Aladdin
//
//  Created by luo on 2017/4/21.
//  Copyright © 2017年 wenqi. All rights reserved.
//

#import "TeachingVideoDetailVC.h"
#import "VideoDetailViewModel.h"
#import "ALDVideoDetailModel.h"

@interface TeachingVideoDetailVC ()

@property (strong, nonatomic) VideoDetailViewModel *viewModel;
@property (strong, nonatomic) ALDVideoDetailModel *model;

@end

@implementation TeachingVideoDetailVC

- (VideoDetailViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[VideoDetailViewModel alloc] init];
    }
    return _viewModel;
}

- (void)setModel:(ALDVideoDetailModel *)model {
    _model = model;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"视频详情";
    
    [self loadData];
}

- (void)loadData {
    @weakify(self);
    [self.viewModel loadDataWithID:self.ID success:^(id obj) {
        @strongify(self);
        NSLog(@"视频详情： %@",obj);
        ALDVideoDetailModel *model = [ALDVideoDetailModel mj_objectWithKeyValues:obj];
        self.model = model;
    } failure:^(id obj) {
        NSLog(@"error: %@",obj);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
