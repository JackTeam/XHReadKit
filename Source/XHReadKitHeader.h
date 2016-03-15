//
//  XHReadKitHeader.h
//  XHReadKit
//
//  Created by 曾 宪华 on 14-2-11.
//  Copyright (c) 2014年 嗨，我是曾宪华(@xhzengAIB)，曾加入YY Inc.担任高级移动开发工程师，拍立秀App联合创始人，热衷于简洁、而富有理性的事物 QQ:543413507 主页:http://zengxianhua.com All rights reserved.
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
