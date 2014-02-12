//
//  XHViewController.m
//  XHReadKit
//
//  Created by 曾 宪华 on 14-1-23.
//  Copyright (c) 2014年 曾宪华 开发团队(http://iyilunba.com ) 本人QQ:543413507 本人QQ群（142557668）. All rights reserved.
//

#import "XHViewController.h"

@interface XHViewController ()

@end

@implementation XHViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    if ([self.navigationController.navigationBar respondsToSelector:@selector(setBarTintColor:)])
        [self.navigationController.navigationBar setBarTintColor:[UIColor redColor]];
    
    self.view.backgroundColor = [UIColor colorWithWhite:0.557 alpha:1.000];
    self.title = NSLocalizedString(@"Enter ReadKit", @"");
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 200, 200);
    button.center = self.view.center;
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:NSLocalizedString(@"Enter ReadKit", @"") forState:UIControlStateNormal];
    [self.view addSubview:button];
}

- (void)buttonClick {
    [self _pushColumnManagerViewController];
}

- (void)_pushColumnManagerViewController {
    NSMutableArray *items = [NSMutableArray new];
    NSMutableArray *unItems = [NSMutableArray new];
    
    int numberOfPanels = 20;
    for (int i = 0; i < numberOfPanels; i++) {
        XHItem *item = [[XHItem alloc] initWithNormalImage:nil selectedImage:nil title:[NSString stringWithFormat:@"Title%d", i] itemSelectedBlcok:^(XHItem *item) {
            
        }];
        
        NSMutableArray *rows = [NSMutableArray array];
        int numberOfRows = 100;
        for (int j = 0; j < numberOfRows; j++) {
            NSString *newsDetail = [[NSString alloc] init];
            newsDetail = @"新浪微博被收购";
            [rows addObject:newsDetail];
        }
        item.dataSources = rows;
        
        [items addObject:item];
    }
    
    for (int i = 20; i < numberOfPanels + 20; i++) {
        XHItem *item = [[XHItem alloc] initWithNormalImage:nil selectedImage:nil title:[NSString stringWithFormat:@"Title%d", i] itemSelectedBlcok:^(XHItem *item) {
        }];
        
        NSMutableArray *rows = [NSMutableArray array];
        int numberOfRows = 100;
        for (int j = 0; j < numberOfRows; j++) {
            [rows addObject:@""];
        }
        item.dataSources = rows;
        
        [unItems addObject:item];
    }
    XHColumnManagerViewController *columnManagerViewController = [[XHColumnManagerViewController alloc] init];
    columnManagerViewController.subscribed = items;
    columnManagerViewController.unSubscribed = unItems;
    [self.navigationController pushViewController:columnManagerViewController animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
