//
//  XHReadKitHeader.h
//  XHReadKit
//
//  Created by 曾 宪华 on 14-2-11.
//  Copyright (c) 2014年 曾宪华 开发团队(http://iyilunba.com ) 本人QQ:543413507 本人QQ群（142557668）. All rights reserved.
//

#ifndef XHReadKit_XHReadKitHeader_h
#define XHReadKit_XHReadKitHeader_h

#define BUNDLE_IMAGE(_file) [UIImage imageWithContentsOfFile:[[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"XHNewsFramework.bundle"] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@%@.png", _file,  ((int)[[UIScreen mainScreen] scale]-1) ? @"@2x" : @""]]]

#ifdef __IPHONE_6_0 // iOS6 and later
#   define UITextAlignmentCenter    NSTextAlignmentCenter
#   define UITextAlignmentLeft      NSTextAlignmentLeft
#   define UITextAlignmentRight     NSTextAlignmentRight
#   define UILineBreakModeTailTruncation     NSLineBreakByTruncatingTail
#   define UILineBreakModeMiddleTruncation   NSLineBreakByTruncatingMiddle
#   define UILineBreakModeCharacterWrap      NSLineBreakByWordWrapping
#endif


#endif
