//
//  WQPopWindow.m
//  Aladdin
//
//  Created by luo on 2017/4/13.
//  Copyright © 2017年 wenqi. All rights reserved.
//

#import "WQPopWindow.h"

@implementation WQPopWindow

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if (self) {
        self.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        self.opaque = NO;
        self.windowLevel = 2014;
        self.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapRecognizerHandler:)];
        [self addGestureRecognizer:tapGecognizer];

    }
    return self;
}

+ (WQPopWindow *)sharedWindow {
    static WQPopWindow *window = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        window = [[WQPopWindow alloc] init];
        window.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
    });
    return window;
}

//- (void)drawRect:(CGRect)rect
//{
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    [[UIColor colorWithWhite:0 alpha:0.3] set];
//    CGContextFillRect(context, self.bounds);
//}

- (void)show {
    
    [self makeKeyAndVisible];
    self.alpha = 0;
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 1;
    }];
}

- (void)hide {
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        for (UIView *v in self.subviews) {
            [v removeFromSuperview];
        }
        [self removeFromSuperview];
    }];
}

#pragma mark - gesture recognizer
- (void)tapRecognizerHandler:(UITapGestureRecognizer *)tapGestureRecoginzer {
    [self hide];
}

@end
