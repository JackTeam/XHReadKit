//
//  XHColumnItemView.m
//  XHReadKit
//
//  Created by 曾 宪华 on 14-2-12.
//  Copyright (c) 2014年 曾宪华 开发团队(http://iyilunba.com ) 本人QQ:543413507 本人QQ群（142557668）. All rights reserved.
//

#import "XHColumnItemView.h"

@interface XHColumnItemView () {
    BOOL isDrag;
    BOOL _isTap;
}

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation XHColumnItemView

- (void)setItem:(XHItem *)item {
    _item = item;
    self.titleLabel.text = _item.title;
}

- (id)initWithFrame:(CGRect)frame target:(id)target action:(SEL)action isTapHandle:(BOOL)isTap {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor whiteColor];
        
        _titleLabel = [[UILabel alloc] initWithFrame:self.bounds];
        
        _titleLabel.textAlignment = UITextAlignmentCenter;
        _titleLabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:self.titleLabel];
        _isTap = isTap;
        if (target || isTap) {
            isDrag = YES;
            _titleLabel.backgroundColor = [UIColor colorWithWhite:0.600 alpha:1.000];
            if (!isTap) {
                UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:target action:action];
                [self addGestureRecognizer:panGestureRecognizer];
            }
        } else {
            _titleLabel.backgroundColor = [UIColor clearColor];
            _titleLabel.textColor = [UIColor grayColor];
        }
    }
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if (isDrag) {
        [UIView animateWithDuration:0.2f animations:^{
            self.transform = CGAffineTransformMakeScale(1.05, 1.05);
            self.alpha = 0.8;
        }];
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self _reset];
    if (_isTap) {
        if ([self.delegate respondsToSelector:@selector(didSelected:)]) {
            [self.delegate didSelected:self];
        }
    }
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    [self _reset];
}

- (void)_reset {
    if (isDrag) {
        [UIView animateWithDuration:0.2f animations:^{
            self.transform = CGAffineTransformIdentity;
            self.alpha = 1.0;
        }];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
