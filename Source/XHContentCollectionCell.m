//
//  XHContentCollectionCell.m
//  XHReadKit
//
//  Created by 啟倫 陳 on 2014/2/11.
//  Copyright (c) 2014年 曾宪华 开发团队(http://iyilunba.com ) 本人QQ:543413507 本人QQ群（142557668）. All rights reserved.
//

#import "XHContentCollectionCell.h"

@implementation XHContentCollectionCell

#pragma mark - General function

- (void)setContentViewControllerAndShow:(UIViewController *) contentViewController {
    self.contentViewController = contentViewController;
    [self addSubview:contentViewController.view];
}

#pragma mark - Life cycle

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

- (void)prepareForReuse {
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
}

@end
