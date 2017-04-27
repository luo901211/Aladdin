//
//  FeedbackVC.m
//  Aladdin
//
//  Created by luo on 2017/4/27.
//  Copyright © 2017年 wenqi. All rights reserved.
//

#import "FeedbackVC.h"

@interface FeedbackVC ()
@property (weak, nonatomic) IBOutlet UILabel *contributionLabel;
@property (weak, nonatomic) IBOutlet UILabel *joinLabel;
@property (weak, nonatomic) IBOutlet UILabel *businessLabel;
@property (weak, nonatomic) IBOutlet UILabel *suggestLabel;

@end

@implementation FeedbackVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"意见反馈";
    
    [self loadData];
}

- (void)loadData {
    @weakify(self)
    [AFNManagerRequest getWithPath:API_USER_OPINION params:nil success:^(NSURLResponse *response, id responseObject) {
        @strongify(self)
        
        self.contributionLabel.attributedText = [self configText:responseObject[@"zxtg"]];
        self.joinLabel.attributedText = [self configText:responseObject[@"rzpt"]];
        self.businessLabel.attributedText = [self configText:responseObject[@"swhz"]];
        self.suggestLabel.attributedText = [self configText:responseObject[@"tsjy"]];
        
    } failure:^(NSError *error) {
        [MBProgressHUD showAutoMessage:error.localizedDescription];
    }];
}

- (NSMutableAttributedString *)configText:(NSString *)string {
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:string];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:1];
    paragraphStyle.alignment = NSTextAlignmentCenter;//设置对齐方式

    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [string length])];
    [attributedString addAttribute:NSForegroundColorAttributeName value:HEXCOLOR(0x666666) range:NSMakeRange(0, [string length])];

    return attributedString;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
