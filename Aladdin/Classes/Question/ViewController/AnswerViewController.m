//
//  AnswerViewController.m
//  Aladdin
//
//  Created by luo on 2017/5/12.
//  Copyright © 2017年 wenqi. All rights reserved.
//

#import "AnswerViewController.h"
#import "WQPlaceholderTextView.h"

@interface AnswerViewController ()<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *submitButton;
@property (weak, nonatomic) IBOutlet WQPlaceholderTextView *textView;

@end

@implementation AnswerViewController

- (void)loadView {
    [super loadView];
    
    self.submitButton.layer.cornerRadius = 3;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"回复";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:(UIBarButtonItemStylePlain) target:self action:@selector(dismiss)];
    [self.textView updatePlaceholderText:@"请输入..."];
    self.textView.delegate = self;
}

- (void)textViewDidChange:(UITextView *)textView {
    if (textView.text.length) {
        [self.textView updatePlaceholderText:@""];
    }else{
        [self.textView updatePlaceholderText:@"请输入..."];
    }
}
- (void)dismiss {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
