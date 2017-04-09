//
//  TeachingVideoVC.m
//  Aladdin
//
//  Created by luo on 2017/4/9.
//  Copyright © 2017年 wenqi. All rights reserved.
//

#import "TeachingVideoContainerVC.h"
#import "SGSegmentedControl.h"

@interface TeachingVideoContainerVC ()<SGSegmentedControlDefaultDelegate, UIScrollViewDelegate>

@property (strong, nonatomic) NSMutableArray *arrayList;

@property (nonatomic, strong) SGSegmentedControlDefault *topSView;
@property (nonatomic, strong) SGSegmentedControlBottomView *bottomSView;

@end

@implementation TeachingVideoContainerVC

- (NSMutableArray *)arrayList {
    if (!_arrayList) {
        _arrayList = [NSMutableArray array];
    }
    return _arrayList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self loadData];
}

- (void)loadData {
    
    @weakify(self);
    [[[WQNetworkTools sharedNetworkTools]GET:@"/video/type" parameters:nil success:^(NSURLSessionDataTask *task, NSDictionary* responseObject) {
        @strongify(self);
        NSLog(@"responseObject: %@",responseObject);
        if ([responseObject[@"code"] integerValue] == 1) {
            NSArray *temArray = responseObject[@"res"];
            self.arrayList = [temArray mutableCopy];
            [self initUI];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",error);
    }] resume];
}

- (void)initUI {
    
    NSMutableArray *titleArr = [NSMutableArray arrayWithCapacity:self.arrayList.count];
    for (int i = 0; i < self.arrayList.count; i++) {
        NSDictionary *dic = self.arrayList[i];
        [titleArr addObject:dic[@"title"]];
    }
    
    NSMutableArray *childVC = [NSMutableArray array];
    for (int i = 0; i < titleArr.count; i++) {
        UIViewController *vc = [[UIViewController alloc] init];
        [childVC addObject:vc];
        [self addChildViewController:vc];
    }
    self.bottomSView = [[SGSegmentedControlBottomView alloc] initWithFrame:CGRectMake(0, 64 + 38, self.view.frame.size.width, self.view.frame.size.height - 64 - 38)];
    _bottomSView.childViewController = childVC;
    _bottomSView.delegate = self;
    [self.view addSubview:_bottomSView];
    
    self.topSView = [SGSegmentedControlDefault segmentedControlWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 38) delegate:self childVcTitle:titleArr isScaleText:NO];
    self.topSView.backgroundColor = [UIColor whiteColor];
    self.topSView.titleColorStateNormal = COLOR_WORD_GRAY_2;
    self.topSView.titleColorStateSelected = GLOBAL_TINT_COLOR;
    self.topSView.indicatorColor = GLOBAL_TINT_COLOR;
    [self.view addSubview:_topSView];

}


- (void)SGSegmentedControlDefault:(SGSegmentedControlDefault *)segmentedControlDefault didSelectTitleAtIndex:(NSInteger)index {
    // 计算滚动的位置
    CGFloat offsetX = index * self.view.frame.size.width;
    self.bottomSView.contentOffset = CGPointMake(offsetX, 0);
    [self.bottomSView showChildVCViewWithIndex:index outsideVC:self];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    // 计算滚动到哪一页
    NSInteger index = scrollView.contentOffset.x / scrollView.frame.size.width;
    
    // 1.添加子控制器view
    [self.bottomSView showChildVCViewWithIndex:index outsideVC:self];
    
    // 2.把对应的标题选中
    [self.topSView changeThePositionOfTheSelectedBtnWithScrollView:scrollView];
}


@end
