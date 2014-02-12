//
//  XHColumnManagerViewController.m
//  XHReadKit
//
//  Created by 曾 宪华 on 14-2-12.
//  Copyright (c) 2014年 曾宪华 开发团队(http://iyilunba.com ) 本人QQ:543413507 本人QQ群（142557668）. All rights reserved.
//

#import "XHColumnManagerViewController.h"
#import "XHItem.h"
#import "XHColumnItemView.h"

#define kTileWidth  130.f
#define kTileHeight kTileWidth
#define kTileMarginLeft1 25.f
#define kTileMarginLeft2 (320.f - kTileMarginLeft1 - kTileWidth)
#define kTileMargin 10.f

@interface XHColumnManagerViewController () <XHColumnItemViewDelegate> {
    // 拖动的tile的原始center坐标
    CGPoint _dragFromPoint;
    
    // 要把tile拖往的center坐标
    CGPoint _dragToPoint;
    
    // tile拖往的rect
    CGRect _dragToFrame;
    
    // 拖拽的tile是否被其他tile包含
    BOOL _isDragTileContainedInOtherTile;
    
    // 拖拽往的目标处的tile
    XHColumnItemView *_pushedTile;
}
@property (nonatomic, strong) UIImageView *backgroundImageView;
@property (nonatomic, strong) UILabel *tipsLabel;
@property (nonatomic, strong) UIScrollView *unSubscribedScrollView;

@property (nonatomic, strong) NSMutableArray *subscribedColumnItemViews;
@property (nonatomic, strong) NSMutableArray *unSubscribedColumnItemViews;
@end

@implementation XHColumnManagerViewController

- (NSMutableArray *)subscribedColumnItemViews {
    if (!_subscribedColumnItemViews) {
        _subscribedColumnItemViews = [[NSMutableArray alloc] init];
    }
    return _subscribedColumnItemViews;
}

- (NSMutableArray *)unSubscribedColumnItemViews {
    if (!_unSubscribedColumnItemViews) {
        _unSubscribedColumnItemViews = [[NSMutableArray alloc] init];
    }
    return _unSubscribedColumnItemViews;
}

- (void)_doneManager {
    NSMutableArray *items = [NSMutableArray array];
    for (XHColumnItemView *columnItemView in self.subscribedColumnItemViews) {
        [items addObject:columnItemView.item];
    }
    self.subscribed = items;
    if ([self.delegate respondsToSelector:@selector(managerDidFinish:)]) {
        [self.delegate managerDidFinish:self];
    }
    [self.navigationController popViewControllerAnimated:YES];
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

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

- (void)_setupBackgroundImageView {
    
}

- (void)_setupSubscribedItems {
    for (XHItem *item in self.subscribed) {
        NSInteger index = [self.subscribed indexOfObject:item];
        CGRect columnItemViewFrame = CGRectMake(16 + (index % 4) * (65 + 10), 15 + (index / 4) * (30 + 4), 65, 30);
        XHColumnItemView *columnItemView = nil;
        if (index == 0) {
            columnItemView = [[XHColumnItemView alloc] initWithFrame:columnItemViewFrame target:nil action:NULL isTapHandle:NO];
        } else {
            columnItemView = [[XHColumnItemView alloc] initWithFrame:columnItemViewFrame target:self action:@selector(dragItem:) isTapHandle:NO];
        }
        columnItemView.item = item;
        [self.view addSubview:columnItemView];
        [self.subscribedColumnItemViews addObject:columnItemView];
    }
}

- (void)_setupTipsLabel {
    _tipsLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMidY(self.view.bounds) - 44, CGRectGetWidth(self.view.bounds), 44)];
    _tipsLabel.text = @"点击添加更多栏目";
    [self.view addSubview:self.tipsLabel];
}

- (void)_setupUnSubscribedItems {
    if (!_unSubscribedScrollView) {
        _unSubscribedScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.tipsLabel.frame), CGRectGetWidth(self.view.bounds), 160)];
        [self.view addSubview:self.unSubscribedScrollView];
    }
    
    CGFloat contentHeight = 15 + (30 + 4) * (self.unSubscribed.count / 4) + (self.unSubscribed.count % 4 ? 1 : 0);
    for (XHItem *item in self.unSubscribed) {
        NSInteger index = [self.subscribed indexOfObject:item];
        CGRect columnItemViewFrame = CGRectMake(16 + (index % 4) * (65 + 10), 15 + (index / 4) * (30 + 4), 65, 30);
        XHColumnItemView *columnItemView = [[XHColumnItemView alloc] initWithFrame:columnItemViewFrame target:self action:NULL isTapHandle:YES];
        columnItemView.delegate = self;
        columnItemView.item = item;
        [_unSubscribedScrollView addSubview:columnItemView];
        [self.unSubscribedColumnItemViews addObject:columnItemView];
    }
    _unSubscribedScrollView.contentSize = CGSizeMake(0, contentHeight);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.title = @"新闻分类";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleBordered target:self action:@selector(_doneManager)];
    self.view.backgroundColor = [UIColor whiteColor];
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    [self _setupBackgroundImageView];
    [self _setupSubscribedItems];
    [self _setupTipsLabel];
    [self _setupUnSubscribedItems];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 手势操作

- (BOOL)dragItem:(UIPanGestureRecognizer *)recognizer
{
    switch ([recognizer state])
    {
        case UIGestureRecognizerStateBegan:
            [self dragTileBegan:recognizer];
            break;
        case UIGestureRecognizerStateChanged:
            [self dragTileMoved:recognizer];
            break;
        case UIGestureRecognizerStateEnded:
            [self dragTileEnded:recognizer];
            break;
        default: break;
    }
    return YES;
}

- (void)dragTileBegan:(UIPanGestureRecognizer *)recognizer
{
    _dragFromPoint = recognizer.view.center;
    [UIView animateWithDuration:0.2f animations:^{
        recognizer.view.transform = CGAffineTransformMakeScale(1.05, 1.05);
        recognizer.view.alpha = 0.8;
    }];
}

- (void)dragTileMoved:(UIPanGestureRecognizer *)recognizer
{
    CGPoint translation = [recognizer translationInView:self.view];
    recognizer.view.center = CGPointMake(recognizer.view.center.x + translation.x,
                                         recognizer.view.center.y + translation.y);
    [recognizer.view.superview bringSubviewToFront:recognizer.view];
    [recognizer setTranslation:CGPointZero inView:self.view];
    
    [self rollbackPushedTileIfNecessaryWithPoint:recognizer.view.center];
    [self pushedTileMoveToDragFromPointIfNecessaryWithTileView:(XHColumnItemView *)recognizer.view];
}

- (void)rollbackPushedTileIfNecessaryWithPoint:(CGPoint)point
{
    if (_pushedTile && !CGRectContainsPoint(_dragToFrame, point))
    {
        [UIView animateWithDuration:0.2f animations:^{
            _pushedTile.center = _dragToPoint;
        }];
        
        _dragToPoint = _dragFromPoint;
        _pushedTile = nil;
        _isDragTileContainedInOtherTile = NO;
    }
}

- (void)pushedTileMoveToDragFromPointIfNecessaryWithTileView:(XHColumnItemView *)tileView
{
    for (XHColumnItemView *columnItemView in self.subscribedColumnItemViews) {
        if (CGRectContainsPoint(columnItemView.frame, tileView.center) && columnItemView != tileView) {
            _dragToPoint = columnItemView.center;
            _dragToFrame = columnItemView.frame;
            _pushedTile = columnItemView;
            _isDragTileContainedInOtherTile = YES;
            [self.subscribedColumnItemViews exchangeObjectAtIndex:[self.subscribedColumnItemViews indexOfObject:tileView] withObjectAtIndex:[self.subscribedColumnItemViews indexOfObject:columnItemView]];
            [UIView animateWithDuration:0.2 animations:^{
                columnItemView.center = _dragFromPoint;
            }];
            break;
        }
    }
}

- (void)dragTileEnded:(UIPanGestureRecognizer *)recognizer
{
    [UIView animateWithDuration:0.2f animations:^{
        recognizer.view.transform = CGAffineTransformMakeScale(1.f, 1.f);
        recognizer.view.alpha = 1.f;
    }];
    
    [UIView animateWithDuration:0.2f animations:^{
        if (_isDragTileContainedInOtherTile)
            recognizer.view.center = _dragToPoint;
        else
            recognizer.view.center = _dragFromPoint;
    }];
    
    _pushedTile = nil;
    _isDragTileContainedInOtherTile = NO;
}

#pragma mark - XHColumnItemViewDelegate

- (void)didSelected:(XHColumnItemView *)columnItemView {
    [self.subscribedColumnItemViews addObject:columnItemView];
    [self _setupSubscribedItems];
}

@end
