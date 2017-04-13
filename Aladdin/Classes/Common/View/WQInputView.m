//
//  NewsCommentInput.m
//  Aladdin
//
//  Created by luo on 2017/4/13.
//  Copyright © 2017年 wenqi. All rights reserved.
//

#import "WQInputView.h"
#import "WQPopWindow.h"
#import "WQPlaceholderTextView.h"

@interface WQInputView ()<UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet WQPlaceholderTextView *contentTextView;
@property (assign, nonatomic) NSInteger minLength;
@property (copy, nonatomic) VoidBlock cancelHandler;
@property (copy, nonatomic) VoidBlock sendHandler;

@end



@implementation WQInputView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.contentTextView.delegate = self;
    
    self.sendButton.enabled = NO;
    
    self.contentTextView.layer.borderWidth = 0.5;
    self.contentTextView.layer.borderColor = GLOBAL_TINT_COLOR.CGColor;
    self.sendButton.tintColor = GLOBAL_TINT_COLOR;
    self.cancelButton.tintColor = GLOBAL_TINT_COLOR;
    
    [self addGestureRecognizer:({
        UITapGestureRecognizer *tgr = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                              action:@selector(doNothing)];
        tgr;
    })];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShowWithNotification:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHideWithNotification:) name:UIKeyboardWillHideNotification object:nil];
}
- (IBAction)onCancelButtonPressed:(id)sender {
    if (self.cancelHandler) {
        self.cancelHandler(self);
    }
    [self hide];
}
- (IBAction)onSendButtonPressed:(id)sender {
    if (self.sendHandler) {
        self.sendHandler(self.contentTextView.text);
    }
}
- (void)textViewDidChange:(UITextView *)textView {
    if ([textView.text length] >= self.minLength) {
        self.sendButton.enabled = YES;
    } else {
        self.sendButton.enabled = NO;
    }
}
- (void)showWithTitle:(NSString *)title
            minLength:(NSInteger)minLength
          contentText:(NSString *)contentText
        cancelHandler:(VoidBlock)cancelHandler
          sendHandler:(VoidBlock)sendHandler {
    self.titleLabel.text = title;
    self.minLength = minLength;
    self.cancelHandler = cancelHandler;
    self.sendHandler = sendHandler;
    self.contentTextView.text = contentText;
    [[WQPopWindow sharedWindow] show];
    [[WQPopWindow sharedWindow] addGestureRecognizer:({
        UITapGestureRecognizer *tgr = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                              action:@selector(tapRecognizerHandler:)];
        tgr;
    })];
    
    self.top = Main_Screen_Height;
    self.left = 0;
    self.width = Main_Screen_Width;
    [self.contentTextView updatePlaceholderText:@"请输入..."];
    [[WQPopWindow sharedWindow] addSubview:self];
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.contentTextView becomeFirstResponder];
    });
}
- (void)showWithTitle:(NSString *)title
            minLength:(NSInteger)minLength
        cancelHandler:(VoidBlock)cancelHandler
          sendHandler:(VoidBlock)sendHandler {
    [self showWithTitle:title minLength:minLength contentText:@"" cancelHandler:cancelHandler sendHandler:sendHandler];
}
- (void)showWithTitle:(NSString *)title
        cancelHandler:(VoidBlock)cancelHandler
          sendHandler:(VoidBlock)sendHandler {
    [self showWithTitle:title
              minLength:2
          cancelHandler:cancelHandler
            sendHandler:sendHandler];
}
- (void)hide {

    self.cancelHandler = nil;
    self.sendHandler = nil;
    [self removeFromSuperview];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[WQPopWindow sharedWindow] hide];
}
#pragma mark - gesture recognizer
- (void)tapRecognizerHandler:(UITapGestureRecognizer *)tapGestureRecoginzer {
    if (self.cancelHandler) {
        self.cancelHandler(self);
    }
    [self hide];
}
- (void)doNothing {}

#pragma mark - keyboard show/hide
- (void)keyboardWillShowWithNotification:(NSNotification *)notification {
    CGRect keyboardFrameEnd = CGRectZero;
    [[notification.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] getValue:&keyboardFrameEnd];
    CGFloat keyboardAnimationDuration = 0;
    [[notification.userInfo valueForKey:UIKeyboardAnimationDurationUserInfoKey] getValue:&keyboardAnimationDuration];
    UIViewAnimationCurve keyboardAnimationCurve;
    [[notification.userInfo valueForKey:UIKeyboardAnimationCurveUserInfoKey] getValue:&keyboardAnimationCurve];
    UIViewAnimationOptions keyboardAnimation = keyboardAnimationCurve << 16;
    
    [UIView animateWithDuration:keyboardAnimationDuration
                          delay:0
                        options:keyboardAnimation animations:^{
                            self.top = Main_Screen_Height - self.height - keyboardFrameEnd.size.height;
                        } completion:^(BOOL finished) {
                            
                        }];
}
- (void)keyboardWillHideWithNotification:(NSNotification *)notification {
    CGRect keyboardFrameEnd = CGRectZero;
    [[notification.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] getValue:&keyboardFrameEnd];
    CGFloat keyboardAnimationDuration = 0;
    [[notification.userInfo valueForKey:UIKeyboardAnimationDurationUserInfoKey] getValue:&keyboardAnimationDuration];
    UIViewAnimationCurve keyboardAnimationCurve;
    [[notification.userInfo valueForKey:UIKeyboardAnimationCurveUserInfoKey] getValue:&keyboardAnimationCurve];
    UIViewAnimationOptions keyboardAnimation = keyboardAnimationCurve << 16;
    
    [UIView animateWithDuration:keyboardAnimationDuration
                          delay:0
                        options:keyboardAnimation animations:^{
                            self.top = Main_Screen_Height;
                        } completion:^(BOOL finished) {
                            [self removeFromSuperview];
                            [[WQPopWindow sharedWindow] hide];
                        }];
}
@end
