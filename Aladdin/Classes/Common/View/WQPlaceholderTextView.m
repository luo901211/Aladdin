//
//  SZPlaceholderTextView.m
//  SZFramework
//
//  Created by Sid_Zheng on 14-5-15.
//  Copyright (c) 2014年 3MeoW. All rights reserved.
//

#import "WQPlaceholderTextView.h"

#define PlaceholderTextColor [UIColor colorWithRed:138.0f/255.0f green:138.0f/255.0f blue:138.0f/255.0f alpha:1]

@interface WQPlaceholderTextView ()
@property (strong, nonatomic) NSString *placeholderText;
@property (strong, nonatomic) UILabel *placeholderLabel;
@end

@implementation WQPlaceholderTextView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initCommon];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initCommon];
    }
    return self;
}

- (id)init {
    self = [super init];
    if (self) {
        [self initCommon];
    }
    return self;
}

- (void)initCommon {
    if (!self.placeholderLabel) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(beganEditing:) name:UITextViewTextDidBeginEditingNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(endEditing:) name:UITextViewTextDidEndEditingNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changedEditing:) name:UITextViewTextDidChangeNotification object:nil];
        
        self.placeholderLabel = ({
            UILabel *l = [[UILabel alloc] init];
            l.numberOfLines = 0;
            l.backgroundColor = [UIColor clearColor];
            l.textColor = PlaceholderTextColor;
            l.font = self.font;
            l.lineBreakMode = NSLineBreakByWordWrapping;
            l.textAlignment = NSTextAlignmentLeft;
            l;
        });
        
        [self updatePlaceholder];
    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)hidePlaceholder {
    if (self.placeholderLabel) {
        [self.placeholderLabel removeFromSuperview];
    }
}

- (void)updatePlaceholder {
    if (self.placeholderText.length > 0) {
        if (![self hasText] && ![self.placeholderLabel superview]) {
            CGRect frame = CGRectMake(10, 10, self.bounds.size.width, 15);
            self.placeholderLabel.frame = frame;
            self.placeholderLabel.text = self.placeholderText;
            [self addSubview:self.placeholderLabel];
        } else if ([self hasText]) {
            [self hidePlaceholder];
        }
    }
}

- (void)updatePlaceholderText:(NSString *)text {
    self.placeholderText = text;
    [self
      updatePlaceholder];
}

#pragma mark - obbserver method
- (void)changedEditing:(NSNotification *)notification {
    //[self hidePlaceholder];
    [self updatePlaceholder];
}

- (void)beganEditing:(NSNotification *)notification {
    //[self hidePlaceholder];
}

- (void)endedEditing:(NSNotification *)notification {
    [self updatePlaceholder];
}
@end
