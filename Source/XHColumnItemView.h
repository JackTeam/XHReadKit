//
//  XHColumnItemView.h
//  XHReadKit
//
//  Created by 曾 宪华 on 14-2-12.
//  Copyright (c) 2014年 曾宪华 开发团队(http://iyilunba.com ) 本人QQ:543413507 本人QQ群（142557668）. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XHItem.h"

@class XHColumnItemView;
@protocol XHColumnItemViewDelegate <NSObject>

- (void)didSelected:(XHColumnItemView *)columnItemView;

@end

@interface XHColumnItemView : UIView

@property (nonatomic, strong) XHItem *item;
@property (nonatomic, assign) id <XHColumnItemViewDelegate> delegate;
- (id)initWithFrame:(CGRect)frame target:(id)target action:(SEL)action isTapHandle:(BOOL)isTap;

@end
