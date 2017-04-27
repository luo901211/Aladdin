//
//  UserFeatureView.m
//  Aladdin
//
//  Created by luo on 2017/4/17.
//  Copyright © 2017年 wenqi. All rights reserved.
//

#import "UserFeatureView.h"
#import "UserCenterVC.h"
#import "CollectListVC.h"
#import "MessageTypeListVC.h"
#import "FeedbackVC.h"
#import "WQPopWindow.h"
#import "QuestionListVC.h"

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
    self = [super initWithFrame:CGRectMake(0, 0, buttonWidth, 44 * items.count + 44 + 14)];
    if (self) {
        self.items = items;
        UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, buttonWidth, 44 * items.count + 44 + 14)];
        UIImage *bgImage = [[UIImage imageNamed:@"user_feature_bg"] stretchableImageWithLeftCapWidth:50 topCapHeight:50];

        bgImageView.image = bgImage;
        [self addSubview:bgImageView];
        
        for (int i = 0; i < items.count; i++) {
            NSDictionary *item = items[i];
            NSString *title = item[@"title"];
            NSString *image = item[@"image"];
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setTitle:title forState:UIControlStateNormal];
            [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
            [button setImage:[UIImage imageNamed:image] forState:UIControlStateHighlighted];
            [button setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 35)];
            [button setFrame:CGRectMake(0, 14 + i * (44), buttonWidth, 44)];
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
        
        // log out
        UIButton *logoutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [logoutBtn setTitle:@"退出登录" forState:UIControlStateNormal];
        [logoutBtn setTitleColor:HEXCOLOR(0xffa02f) forState:UIControlStateNormal];
        [logoutBtn setFrame:CGRectMake(0, 14 + items.count * (44), buttonWidth, 44)];
        [logoutBtn addTarget:self action:@selector(logout) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:logoutBtn];
    }
    return self;
}

- (void)didPressedOnButton:(UIButton *)button {
    
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
            vc = [[QuestionListVC alloc] init];
            [(QuestionListVC *)vc setType:QuestionTypeUser];
            vc.title = @"我的问答";
        }
            break;
        case 3:
        {
            vc = [[MessageTypeListVC alloc] init];
        }
            break;
        case 4:
        {
            vc = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"FeedbackVC"];
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

- (void)logout {
    
}

@end
