//
//  AnswerViewController.m
//  Aladdin
//
//  Created by luo on 2017/5/12.
//  Copyright © 2017年 wenqi. All rights reserved.
//

#import "AnswerViewController.h"
#import <UITextView+Placeholder/UITextView+Placeholder.h>
#import "NSString+Additions.h"
#import "AnswerViewModel.h"
#import "UIViewController+WQAdd.h"

#define kQuestionMaxLength 1000
@interface AnswerViewController ()<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *submitButton;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UILabel *lengthLabel;
@property (strong, nonatomic) AnswerViewModel *viewModel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation AnswerViewController

- (AnswerViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[AnswerViewModel alloc] init];
    }
    return _viewModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"回复";
    if ([self isModelPresent]) {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:(UIBarButtonItemStylePlain) target:self action:@selector(dismiss)];
    }
    
    self.titleLabel.text = self.questionTitle;
    
    self.textView.placeholder = @"请输入回答内容";
    self.textView.placeholderColor = HEXCOLOR(0xcdcdcd);
    self.textView.delegate = self;
    self.lengthLabel.text = [NSString stringWithFormat:@"0/%d",kQuestionMaxLength];
    self.submitButton.layer.cornerRadius = 4;
}
- (IBAction)didPressedOnSubmitButton:(UIButton *)sender {
    if ([self.textView.text chineseTextLength] > kQuestionMaxLength) {
        return [MBProgressHUD showAutoMessage:@"字数超过最长限制"];
    }
    
    @weakify(self);
    [self.viewModel submitAnswer:self.textView.text id:self.ID success:^(id obj) {
        @strongify(self);
        [MBProgressHUD showAutoMessage:@"提交成功"];
        [self dismissViewControllerAnimated:YES completion:nil];
    } failure:^(id obj) {
        [MBProgressHUD showAutoMessage:obj];
    }];
}

- (void)dismiss {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
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
