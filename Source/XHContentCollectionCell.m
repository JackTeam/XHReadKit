//
//  XHContentCollectionCell.m
//  XHReadKit
//
//  Created by 啟倫 陳 on 2014/2/11.
//  Copyright (c) 2014年 嗨，我是曾宪华(@xhzengAIB)，曾加入YY Inc.担任高级移动开发工程师，拍立秀App联合创始人，热衷于简洁、而富有理性的事物 QQ:543413507 主页:http://zengxianhua.com All rights reserved.
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
