//
//  XHColumnItemView.h
//  XHReadKit
//
//  Created by 曾 宪华 on 14-2-12.
//  Copyright (c) 2014年 嗨，我是曾宪华(@xhzengAIB)，曾加入YY Inc.担任高级移动开发工程师，拍立秀App联合创始人，热衷于简洁、而富有理性的事物 QQ:543413507 主页:http://zengxianhua.com All rights reserved.
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
