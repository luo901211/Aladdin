//
//  NewsCommentInput.h
//  Aladdin
//
//  Created by luo on 2017/4/13.
//  Copyright © 2017年 wenqi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WQInputView : UIView
@property (weak, nonatomic) IBOutlet UIButton *sendButton;
- (void)showWithTitle:(NSString *)title
        cancelHandler:(VoidBlock)cancelHandler
          sendHandler:(VoidBlock)sendHandler;
- (void)showWithTitle:(NSString *)title
            minLength:(NSInteger)minLength
        cancelHandler:(VoidBlock)cancelHandler
          sendHandler:(VoidBlock)sendHandler;
- (void)showWithTitle:(NSString *)title
            minLength:(NSInteger)minLength
          contentText:(NSString *)contentText
        cancelHandler:(VoidBlock)cancelHandler
          sendHandler:(VoidBlock)sendHandler;
- (void)hide;

@end
