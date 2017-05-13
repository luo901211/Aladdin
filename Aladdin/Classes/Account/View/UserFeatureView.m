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
#import "User+Helper.h"

@interface UserFeatureView ()

@property (strong, nonatomic) NSArray *items;
@property (strong, nonatomic) UIButton *logoutBtn;

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

- (instancetype)init {
    NSArray *items = @[
                      @{ @"title": @"个人中心", @"image": @"user_mine_item" },
                      @{ @"title": @"我的收藏", @"image": @"user_collect_item" },
                      @{ @"title": @"我的问答", @"image": @"user_question_item" },
                      @{ @"title": @"系统消息", @"image": @"user_system_msg_item" },
                      @{ @"title": @"意见反馈", @"image": @"user_feedback_item" }
                      ];
    
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
        [logoutBtn setTitleColor:HEXCOLOR(0xffa02f) forState:UIControlStateNormal];
        [logoutBtn setFrame:CGRectMake(0, 14 + items.count * (44), buttonWidth, 44)];
        [logoutBtn addTarget:self action:@selector(logoutOrLogin) forControlEvents:UIControlEventTouchUpInside];
        [logoutBtn setTitle:[User sharedInstance].isLogin ? @"退出登录": @"登录" forState:UIControlStateNormal];
        self.logoutBtn = logoutBtn;
        [self addSubview:self.logoutBtn];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginNotificationAction) name:kNotification_Login object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(logoutNotificationAction) name:kNotification_Logout object:nil];

    }
    return self;
}

- (void)didPressedOnButton:(UIButton *)button {
    
    [[WQPopWindow sharedWindow] hide];
    
    NSInteger index = button.tag - 100;
    
    if (![User sharedInstance].isLogin && index != 4) {
        return [User presentLoginViewController];
    }
    
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

    UITabBarController *tabBarController = (UITabBarController *)[UIApplication sharedApplication].delegate.window.rootViewController;
    UINavigationController *navigationController = tabBarController.viewControllers[tabBarController.selectedIndex];
    [navigationController pushViewController:vc animated:YES];
}

- (void)logoutOrLogin {
    [[WQPopWindow sharedWindow] hide];
    
    if ([User sharedInstance].isLogin) {
        [[User sharedInstance] logout];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"已退出登录" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
    }else{
        [User presentLoginViewController];
    }
}

#pragma mark - 通知
- (void)loginNotificationAction {
    [self.logoutBtn setTitle:@"退出登录" forState:UIControlStateNormal];
}
- (void)logoutNotificationAction {
    [self.logoutBtn setTitle:@"登录" forState:UIControlStateNormal];
}
-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
