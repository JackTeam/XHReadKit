//
//  XHColumnManagerViewController.h
//  XHReadKit
//
//  Created by 曾 宪华 on 14-2-12.
//  Copyright (c) 2014年 曾宪华 开发团队(http://iyilunba.com ) 本人QQ:543413507 本人QQ群（142557668）. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XHColumnItemManagerViewController;
@protocol XHColumnItemManagerViewControllerDelegate <NSObject>

- (void)managerDidFinish:(XHColumnItemManagerViewController *)columnItemManagerViewController;

@end

@interface XHColumnManagerViewController : UIViewController
@property (nonatomic, assign) id <XHColumnItemManagerViewControllerDelegate> delegate;
@property (nonatomic, strong) NSArray *subscribed; // Has subscribed to the column
@property (nonatomic, strong) NSArray *unSubscribed; // In the local or network search back not subscribe to the columns
@end
