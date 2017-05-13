//
//  QuestionReportVC.m
//  Aladdin
//
//  Created by luo on 2017/5/11.
//  Copyright © 2017年 wenqi. All rights reserved.
//

#import "QuestionReportVC.h"
#import <UITextView+Placeholder/UITextView+Placeholder.h>
#import "NSString+Additions.h"

#define kQuestionMaxLength 50
@interface QuestionReportVC ()<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *bannerView;
@property (weak, nonatomic) IBOutlet UIImageView *avatarImageV;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *companyLabel;
@property (weak, nonatomic) IBOutlet UILabel *positionLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bannerHeight;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;
@property (weak, nonatomic) IBOutlet UILabel *lengthLabel;

@end

@implementation QuestionReportVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"提问";
    
    if (self.expertModel) {
        self.avatarImageV.layer.cornerRadius = self.avatarImageV.height/2;
        [self.avatarImageV sd_setImageWithURL:[NSURL URLWithString:self.expertModel.pic_url]];
        self.nameLabel.text = self.expertModel.real_name;
        self.companyLabel.text = self.expertModel.company;
        self.positionLabel.text =  self.expertModel.position;
    }else{
        self.bannerHeight.constant = 0;
    }
    self.submitButton.layer.cornerRadius = 4;

    self.textView.placeholder = @"请尽可能详细地描述您的具体问题";
    self.textView.placeholderColor = HEXCOLOR(0xcdcdcd);
    self.textView.delegate = self;
    self.lengthLabel.text = [NSString stringWithFormat:@"0/%d",kQuestionMaxLength];
}
- (IBAction)didPressedOnSubmitButton:(UIButton *)sender {
    
    if ([self.textView.text chineseTextLength] > kQuestionMaxLength) {
        return [MBProgressHUD showAutoMessage:@"字数超过最长限制"];
    }
    
    if (self.expertModel) {
        NSLog(@"向 %ld 提问",(long)self.expertModel.ID);
    }else{
        NSLog(@"免费提问");
    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView {
    self.lengthLabel.text = [NSString stringWithFormat:@"%ld/%d",(long)[textView.text chineseTextLength], kQuestionMaxLength];
    if ([textView.text chineseTextLength] > kQuestionMaxLength) {
        self.lengthLabel.textColor = HEXCOLOR(0xe64340);
    }else{
        self.lengthLabel.textColor = HEXCOLOR(0x999999);
    }
}

@end
