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

@property (weak, nonatomic) IBOutlet UILabel *contributionEmailLabel;
@property (weak, nonatomic) IBOutlet UILabel *joinEmailLabel;
@property (weak, nonatomic) IBOutlet UILabel *businessEmailLabel;
@property (weak, nonatomic) IBOutlet UILabel *suggestEmailLabel;

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
        
        NSDictionary *zxtg = responseObject[@"zxtg"];
        NSDictionary *rzpt = responseObject[@"rzpt"];
        NSDictionary *swhz = responseObject[@"swhz"];
        NSDictionary *tsjy = responseObject[@"tsjy"];
        
        self.contributionLabel.text = [NSString stringWithFormat:@"联系人: %@ %@",zxtg[@"name"], zxtg[@"mobile"]];
        self.joinLabel.text = [NSString stringWithFormat:@"联系人: %@ %@",rzpt[@"name"], rzpt[@"mobile"]];
        self.businessLabel.text = [NSString stringWithFormat:@"联系人: %@ %@",swhz[@"name"], swhz[@"mobile"]];
        self.suggestLabel.text = [NSString stringWithFormat:@"联系人: %@ %@",tsjy[@"name"], tsjy[@"mobile"]];
        
        self.contributionEmailLabel.text = [NSString stringWithFormat:@"邮  箱: %@", zxtg[@"email"]];
        self.joinEmailLabel.text = [NSString stringWithFormat:@"邮  箱: %@", rzpt[@"email"]];
        self.businessEmailLabel.text = [NSString stringWithFormat:@"邮  箱: %@", swhz[@"email"]];
        self.suggestEmailLabel.text = [NSString stringWithFormat:@"邮  箱: %@", tsjy[@"email"]];
        
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
