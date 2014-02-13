//
//  XHContentTableViewController.m
//  XHPagesContainer
//
//  Created by 曾 宪华 on 14-1-23.
//  Copyright (c) 2014年 曾宪华 开发团队(http://iyilunba.com ) 本人QQ:543413507 本人QQ群（142557668）. All rights reserved.
//

#import "XHContentTableViewController.h"

@interface XHContentTableViewController ()
@property (nonatomic, assign) CGRect currentFrame;
@end

@implementation XHContentTableViewController

- (void)_setupTableView {
    CGRect tableViewFrame = self.view.bounds;
    UITableView *tableView = [[UITableView alloc] initWithFrame:tableViewFrame style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    [tableView setScrollsToTop:NO];
    [self.view addSubview:tableView];
    self.tableView = tableView;
    UIEdgeInsets contentInset = tableView.contentInset;
    contentInset.top = self.tableViewContenInsetTop;
    tableView.contentInset = contentInset;
    tableView.scrollIndicatorInsets = contentInset;
}

#pragma mark - Life cycle

- (void)_setup {
}

-(id) initWithFrame : (CGRect) frame {
    self = [super init];
    self.currentFrame = frame;
    if (self) {
        [self _setup];
    }
    return self;
}

- (id)init {
    self = [super init];
    if (self) {
        [self _setup];
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSLog(@"viewDidAppear");
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"viewWillAppear");
    [self.tableView setScrollsToTop:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    NSLog(@"viewWillDisappear");
    [self.tableView setScrollsToTop:NO];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    NSLog(@"viewDidDisappear");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.frame = _currentFrame;
    self.view.backgroundColor = [UIColor grayColor];
    [self _setupTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - TableView DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = @"测试";
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.navigationController pushViewController:[[XHContentTableViewController alloc] init] animated:YES];
}

@end
