//
//  XHContainerViewController.m
//  XHReadKit
//
//  Created by 啟倫 陳 on 2014/2/11.
//  Copyright (c) 2014年 曾宪华 开发团队(http://iyilunba.com ) 本人QQ:543413507 本人QQ群（142557668）. All rights reserved.
//

#import "XHContainerViewController.h"

#import "XHItem.h"
#import "XHItemScrollToolBar.h"
#import "XHFoundCommon.h"
#import "XHContentCollectionCell.h"
#import "XHContentTableViewController.h"

@interface XHContainerViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *containerCollectionView;
@property (nonatomic, weak) XHContentCollectionCell *currentContentCollectionCell;

- (UICollectionViewFlowLayout *)makeCollectionViewLayoutWithSize:(CGSize) cellSize;
- (CGRect)collectionViewFrame;

@end

@implementation XHContainerViewController

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Private

- (UICollectionViewFlowLayout *)makeCollectionViewLayoutWithSize:(CGSize) cellSize {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = cellSize;
    layout.minimumInteritemSpacing = layout.minimumLineSpacing = 0.0f;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    return layout;
}

- (CGRect)collectionViewFrame {
    CGFloat topItemsHeight = [XHFoundCommon getAdapterHeight]+kXHItemScrollToolBarHeight;
    return CGRectMake(0, topItemsHeight, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds) - topItemsHeight);
}

#pragma mark - Setup UI

- (void)_setupContainer {
    _containerCollectionView = [[UICollectionView alloc] initWithFrame:[self collectionViewFrame]
                                                  collectionViewLayout:[self makeCollectionViewLayoutWithSize:[self collectionViewFrame].size]];
    _containerCollectionView.delegate = self;
    _containerCollectionView.dataSource = self;
    _containerCollectionView.pagingEnabled = YES;
    [_containerCollectionView setScrollsToTop:NO];
    _containerCollectionView.showsHorizontalScrollIndicator = NO;
    _containerCollectionView.showsVerticalScrollIndicator = NO;
    _containerCollectionView.backgroundColor = [UIColor clearColor];
    [_containerCollectionView registerClass:[XHContentCollectionCell class] forCellWithReuseIdentifier:@"XHContentCollectionCell"];
    [self.view addSubview:self.containerCollectionView];
}

- (void)_setupTopScrollBar {
    NSMutableArray *items = [NSMutableArray array];
    for (int i = 0; i < 10; i ++) {
        XHItem *item = [[XHItem alloc] initWithNormalImage:[UIImage imageNamed:@"tabBar-camera"]
                                             selectedImage:[UIImage imageNamed:@"tabBar-camera-on"]
                                                     title:@"title5"
                                         itemSelectedBlcok:^(XHItemView *itemView) {
                                             NSInteger index = itemView.item.index;
                                             NSLog(@"index : %d", index);
                                         }];
        [items addObject:item];
    }
    
    XHItemScrollToolBar *itemScrollToolBarToMid = [[XHItemScrollToolBar alloc] initWithFrame:CGRectMake(0, [XHFoundCommon getAdapterHeight], CGRectGetWidth(self.view.bounds), kXHItemScrollToolBarHeight)];
    itemScrollToolBarToMid.itemWidth = CGRectGetWidth([[UIScreen mainScreen] bounds]) / 5.0;
    itemScrollToolBarToMid.items = items;
    [self.view addSubview:itemScrollToolBarToMid];
    [itemScrollToolBarToMid reloadData];
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
    self.view.backgroundColor = [UIColor grayColor];
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
    
    
    XHContentTableViewController *dummyTableViewController = [[XHContentTableViewController alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth([self collectionViewFrame]), CGRectGetHeight([self collectionViewFrame]))];
    
    [cell setContentViewControllerAndShow:dummyTableViewController];
    [self addChildViewController:dummyTableViewController];
    
    return cell;
}

@end
