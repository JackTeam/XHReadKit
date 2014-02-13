//
//  XHFoundCommon.m
//  XHPagesContainer
//
//  Created by 曾 宪华 on 14-1-24.
//  Copyright (c) 2014年 曾宪华 开发团队(http://iyilunba.com ) 本人QQ:543413507 本人QQ群（142557668）. All rights reserved.
//

#import "XHFoundCommon.h"

@implementation XHFoundCommon

+ (CGFloat)getAdapterHeight {
    CGFloat adapterHeight = 0;
    if ([[[UIDevice currentDevice] systemVersion] integerValue] >= 7.0) {
        adapterHeight = 64;
    }
    return adapterHeight;
}

@end
