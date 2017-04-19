//
//  UserFeatureView.m
//  Aladdin
//
//  Created by luo on 2017/4/17.
//  Copyright © 2017年 wenqi. All rights reserved.
//

#import "UserFeatureView.h"
#import "UserCenterVC.h"
#import "MemberInfoVC.h"
#import "CollectListVC.h"
#import "AnswerListVC.h"
#import "MessageTypeListVC.h"
#import "FeedbackVC.h"
#import "WQPopWindow.h"

@interface UserFeatureView ()

@property (strong, nonatomic) NSArray *items;

@end
static CGFloat buttonWidth = 164;
@implementation UserFeatureView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithItems:(NSArray *)items {
    self = [super initWithFrame:CGRectMake(0, 0, buttonWidth, 320)];
    if (self) {
        self.items = items;
        self.backgroundColor = [UIColor whiteColor];
        for (int i = 0; i < items.count; i++) {
            NSDictionary *item = items[i];
            NSString *title = item[@"title"];
            NSString *image = item[@"image"];
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setTitle:title forState:UIControlStateNormal];
            [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
            [button setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 35)];
            [button setFrame:CGRectMake(0, i * (44), buttonWidth, 44)];
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:15];
            [button addSubview:({
                UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 43.4, buttonWidth, 0.5)];
                line.backgroundColor = HEXCOLOR(0xdedfd0);
                line;
            })];
            button.tag = 100+i;
            [button addTarget:self action:@selector(didPressedOnButton:) forControlEvents:UIControlEventTouchUpInside];
            self.layer.cornerRadius = 6;
            [self addSubview:button];
        }
    }
    return self;
}

- (void)didPressedOnButton:(UIButton *)button {
//    if (self.tapBlock) {
//        self.tapBlock((button.tag-100));
//    }
    
    NSInteger index = button.tag - 100;
    UIViewController *vc;
    switch (index) {
        case 0:
        {
            vc = [[UserCenterVC alloc] init];
        }
            break;
        case 1:
        {
            vc = [[CollectListVC alloc] init];
        }
            break;
        case 2:
        {
            vc = [[AnswerListVC alloc] init];
        }
            break;
        case 3:
        {
            vc = [[MessageTypeListVC alloc] init];
        }
            break;
        case 4:
        {
            vc = [[FeedbackVC alloc] init];
        }
            break;
        default:
            break;
    }

    [[WQPopWindow sharedWindow] hide];
    UITabBarController *tabBarController = (UITabBarController *)[UIApplication sharedApplication].delegate.window.rootViewController;
    UINavigationController *navigationController = tabBarController.viewControllers[tabBarController.selectedIndex];
    [navigationController pushViewController:vc animated:YES];
}



@end
