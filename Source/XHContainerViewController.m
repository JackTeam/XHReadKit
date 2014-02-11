//
//  XHContainerViewController.m
//  XHReadKit
//
//  Created by 啟倫 陳 on 2014/2/11.
//  Copyright (c) 2014年 曾宪华 开发团队(http://iyilunba.com ) 本人QQ:543413507 本人QQ群（142557668）. All rights reserved.
//

#import "XHContainerViewController.h"

#import "XHItem.h"
#import "XHContentCollectionCell.h"
#import "XHContentTableViewController.h"

@interface XHContainerViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *containerCollectionView;

- (UICollectionViewFlowLayout *)makeCollectionViewLayoutWithSize : (CGSize) cellSize;
@end

@implementation XHContainerViewController

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Private

- (UICollectionViewFlowLayout *)makeCollectionViewLayoutWithSize : (CGSize) cellSize {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = cellSize;
    layout.minimumInteritemSpacing = layout.minimumLineSpacing = 0.0f;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    return layout;
}

#pragma mark - Setup UI

- (void)_setupContainer {
#warning 這邊的 _containerCollectionView init size 是需要修改的, 會影響到後面 cell 的大小是否超出邊界.
    _containerCollectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds
                                                  collectionViewLayout:[self makeCollectionViewLayoutWithSize:self.view.bounds.size]];
    _containerCollectionView.delegate = self;
    _containerCollectionView.dataSource = self;
    _containerCollectionView.pagingEnabled = YES;
    _containerCollectionView.showsHorizontalScrollIndicator = NO;
    _containerCollectionView.showsVerticalScrollIndicator = NO;
    _containerCollectionView.backgroundColor = [UIColor clearColor];
    [_containerCollectionView registerClass:[XHContentCollectionCell class] forCellWithReuseIdentifier:@"XHContentCollectionCell"];
    [self.view addSubview:self.containerCollectionView];
}

- (void)_setupTopScrollBar {
#warning 工作中...
}

#pragma mark - Life cycle

- (void)_setup {
}

- (id)init {
    self = [super init];
    if (self) {
        [self _setup];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _setupContainer];
    [self _setupTopScrollBar];
    if ([self respondsToSelector:@selector(automaticallyAdjustsScrollViewInsets)])
        self.automaticallyAdjustsScrollViewInsets = NO;
}

#pragma mark - UICollectionViewDataSource delegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"XHContentCollectionCell";
    XHContentCollectionCell *cell = (XHContentCollectionCell*) [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
    XHContentTableViewController *dummyTableViewController = [[XHContentTableViewController alloc] initWithFrame:_containerCollectionView.bounds];
    
    [cell setContentViewControllerAndShow:dummyTableViewController];
    
    return cell;
}

@end
