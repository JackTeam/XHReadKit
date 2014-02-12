//
//  XHItemView.m
//  XHItemScrollToolBar
//
//  Created by 曾 宪华 on 14-1-23.
//  Copyright (c) 2014年 曾宪华 开发团队(http://iyilunba.com ) 本人QQ:543413507 本人QQ群（142557668）. All rights reserved.
//

#import "XHItemView.h"

@interface XHItemView ()
@property (nonatomic, strong) XHItem *item;
@end

@implementation XHItemView

- (instancetype)initWithFrame:(CGRect)frame item:(XHItem *)item {
    self = [super initWithFrame:frame];
    if (self) {
        self.item = item;
        if (item.normalImage)
            [self setImage:item.normalImage forState:UIControlStateNormal];
        if (item.selectedImage)
            [self setImage:item.selectedImage forState:UIControlStateSelected];
        if (item.title)
            [self setTitle:item.title forState:UIControlStateNormal];
    }
    return self;
}

@end
