//
//  LZContentView.m
//  LZScrollPageView
//
//  Created by lz on 16/8/1.
//  Copyright © 2016年 lz. All rights reserved.
//

#import "LZContentView.h"
#import "LZScrollSegmentView.h"
#import "UIViewController+LZScrollPageController.h"
@interface LZContentView ()<UICollectionViewDelegate, UICollectionViewDataSource, UIScrollViewDelegate, UIGestureRecognizerDelegate>
{
    NSInteger _oldIndex;
    NSInteger _currentIndex;
    CGFloat   _oldOffSetX;
}


@property (weak, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) UICollectionViewFlowLayout *collectionViewLayout;

@property (weak, nonatomic) LZScrollSegmentView *segmentView;

@property (weak, nonatomic) UIButton *extraBtn;
@property (weak, nonatomic) UIViewController *parentViewController;
@property (assign, nonatomic) BOOL forbidTouchToAdjustPosition;
@property (assign, nonatomic) NSInteger itemsCount;
@property (strong, nonatomic) NSMutableDictionary<NSString *, UIViewController<LZScrollPageViewChildVcDelegate> *> *childVcsDic;
@property (strong, nonatomic) UIViewController<LZScrollPageViewChildVcDelegate> *currentChildVc;

@end

@implementation LZContentView

#define LZCollectionCellID @"LZCollectionCellID"

#pragma mark - life cycle

- (instancetype)initWithFrame:(CGRect)frame segmentView:(LZScrollSegmentView *)segmentView parentViewController:(UIViewController *)parentViewController delegate:(id<LZScrollPageViewDelegate>) delegate
{
    if (self = [super initWithFrame:frame])
    {
        self.segmentView = segmentView;
        self.delegate = delegate;
        self.parentViewController = parentViewController;
        _oldIndex = 0;
        _currentIndex = 1;
        _oldOffSetX = 0.0;
        self.forbidTouchToAdjustPosition = NO;
        self.collectionView.backgroundColor = [UIColor whiteColor];
        [self commonInit];
    }
    return self;
}

- (void)commonInit
{
    if (self.parentViewController.parentViewController && [self.parentViewController.parentViewController isKindOfClass:[UINavigationController class]])
    {
        UINavigationController *navi = (UINavigationController *)self.parentViewController.parentViewController;
        if (navi.interactivePopGestureRecognizer)
        {
            navi.interactivePopGestureRecognizer.delegate = self;
            [self.collectionView.panGestureRecognizer requireGestureRecognizerToFail:navi.interactivePopGestureRecognizer];
        }
    }

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveMemoryWarningHander:) name:UIApplicationDidReceiveMemoryWarningNotification object:nil];
}

- (void)receiveMemoryWarningHander:(NSNotificationCenter *)noti
{
    __weak typeof(self) weakSelf = self;
    [_childVcsDic enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, UIViewController<LZScrollPageViewChildVcDelegate> * _Nonnull childVc, BOOL * _Nonnull stop) {
        __strong typeof(self) strongSelf = weakSelf;
        
        if (childVc != strongSelf.currentChildVc)
        {
            [_childVcsDic removeObjectForKey:key];
            [LZContentView removeChildVc:childVc];
        }
    }];
    
}


- (void)dealloc
{
    self.parentViewController = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    NSLog(@"ContentView---销毁");
}

#pragma mark - public helper
- (void)setContentOffSet:(CGPoint)offset animated:(BOOL)animated
{
    self.forbidTouchToAdjustPosition = YES;
    [self.collectionView setContentOffset:offset animated:animated];
}

- (void)reload
{
    [self.childVcsDic enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, UIViewController<LZScrollPageViewChildVcDelegate> * _Nonnull childVc, BOOL * _Nonnull stop) {
        [LZContentView removeChildVc:childVc];
        childVc = nil;
    }];
    self.childVcsDic = nil;
    [self.collectionView reloadData];
}

#pragma mark - UICollectionViewDelegate --- UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (_delegate && [_delegate respondsToSelector:@selector(numberOfChildViewControllers)])
    {
        _itemsCount = [_delegate numberOfChildViewControllers];
    }
    return _itemsCount;
}


+ (void)removeChildVc:(UIViewController *)childVc
{
    [childVc willMoveToParentViewController:nil];
    [childVc.view removeFromSuperview];
    [childVc removeFromParentViewController];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:LZCollectionCellID forIndexPath:indexPath];
    // 移除subviews 避免重用内容显示错误
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    _currentChildVc = [self.childVcsDic valueForKey:[NSString stringWithFormat:@"%ld", (long)indexPath.row]];
    BOOL isFirstTime = _currentChildVc == nil;
    
    if (_delegate && [_delegate respondsToSelector:@selector(childViewController:forIndex:)])
    {
        if (_currentChildVc == nil)
        {
            _currentChildVc = [_delegate childViewController:nil forIndex:indexPath.row];
            
            if (!_currentChildVc || ![_currentChildVc conformsToProtocol:@protocol(LZScrollPageViewChildVcDelegate)])
            {
                NSAssert(NO, @"子控制器必须遵守LZScrollPageViewChildVcDelegate协议");
            }
            [self.childVcsDic setValue:_currentChildVc forKey:[NSString stringWithFormat:@"%ld", (long)indexPath.row]];
        } else
        {
            [_delegate childViewController:_currentChildVc forIndex:indexPath.row];
        }
    } else
    {
        NSAssert(NO, @"必须设置代理和实现代理方法");
    }
    // 这里建立子控制器和父控制器的关系
    [self addChildVc:_currentChildVc ToParentVcCell:cell];
    [self viewWillAppearIsFirstTime:isFirstTime forIndex:indexPath.row];
    return cell;
}

- (void)viewWillAppearIsFirstTime:(BOOL)isFirstTime forIndex:(NSInteger)index
{
    
    if ([_currentChildVc respondsToSelector:@selector(setUpWhenViewWillAppearForTitle:forIndex:firstTimeAppear:)])
    {
        [_currentChildVc setUpWhenViewWillAppearForTitle:self.segmentView.titles[index] forIndex:index firstTimeAppear:isFirstTime];
    }
}

- (void)addChildVc:(UIViewController *)childVc ToParentVcCell:(UICollectionViewCell *) cell
{
    if ([childVc isKindOfClass:[UINavigationController class]]) {
        NSAssert(NO, @"不要添加UINavigationController包装后的子控制器");
    }
    
    if (childVc.scrollPageParentViewController != self.parentViewController) {
        childVc.scrollPageParentViewController = self.parentViewController;
        [self.parentViewController addChildViewController:childVc];
    }
    childVc.view.frame = self.bounds;
    [cell.contentView addSubview:childVc.view];
    [childVc didMoveToParentViewController:self.parentViewController];
}


#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.forbidTouchToAdjustPosition)
    {
        return;
    }
    CGFloat offSetX = scrollView.contentOffset.x;
    CGFloat tempProgress = offSetX / self.bounds.size.width;
    CGFloat progress = tempProgress - floor(tempProgress);
    
    if (offSetX - _oldOffSetX >= 0)
    {
        _oldIndex =  offSetX / self.bounds.size.width;
        _currentIndex = _oldIndex + 1;
        if (_currentIndex >= self.itemsCount)
        {
            _currentIndex = _oldIndex - 1;
        }
        
        if (offSetX - _oldOffSetX == scrollView.bounds.size.width)
        {
            progress = 1.0;
            _currentIndex = _oldIndex;
        }
        
    } else
    {
        _currentIndex = offSetX / self.bounds.size.width;
        _oldIndex = _currentIndex + 1;
        
        progress = 1.0 - progress;
        
    }
    
    [self contentViewDidMoveFromIndex:_oldIndex toIndex:_currentIndex progress:progress];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger currentIndex = (scrollView.contentOffset.x / self.bounds.size.width);
    
    [self contentViewDidMoveFromIndex:currentIndex toIndex:currentIndex progress:1.0];
    [self adjustSegmentTitleOffsetToCurrentIndex:currentIndex];
    
    if (scrollView.contentOffset.x == _oldOffSetX)
    {
        _currentChildVc = [self.childVcsDic valueForKey:[NSString stringWithFormat:@"%ld", (long)currentIndex]];
        _currentChildVc = [_delegate childViewController:_currentChildVc forIndex:currentIndex];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (scrollView.contentOffset.x == 0 || scrollView.contentOffset.x == scrollView.contentSize.width - scrollView.bounds.size.width)
    {
        NSInteger currentIndex = (scrollView.contentOffset.x / self.bounds.size.width);
        if (scrollView.contentOffset.x == _oldOffSetX)
        {
            [self contentViewDidMoveFromIndex:currentIndex toIndex:currentIndex progress:1.0];
            
            if (scrollView.contentOffset.x == _oldOffSetX)
            {
                _currentChildVc = [self.childVcsDic valueForKey:[NSString stringWithFormat:@"%ld", (long)currentIndex]];
                _currentChildVc = [_delegate childViewController:_currentChildVc forIndex:currentIndex];
            }
        }
    }
}


- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    _oldOffSetX = scrollView.contentOffset.x;
    self.forbidTouchToAdjustPosition = NO;
}

#pragma mark - private helper
- (void)contentViewDidMoveFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex progress:(CGFloat)progress
{
    if(self.segmentView)
    {
        [self.segmentView adjustUIWithProgress:progress oldIndex:fromIndex currentIndex:toIndex];
    }
}

- (void)adjustSegmentTitleOffsetToCurrentIndex:(NSInteger)index
{
    if(self.segmentView)
    {
        [self.segmentView adjustTitleOffSetToCurrentIndex:index];
    }
    
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if (self.parentViewController.parentViewController && [self.parentViewController.parentViewController isKindOfClass:[UINavigationController class]])
    {
        UINavigationController *navi = (UINavigationController *)self.parentViewController.parentViewController;
        
        if (navi.visibleViewController == self.parentViewController)
        {// 当显示的是ScrollPageView的时候 只在第一个tag处执行pop手势
            return self.collectionView.contentOffset.x == 0;
        } else
        {
            return [super gestureRecognizerShouldBegin:gestureRecognizer];
        }
    }
    return [super gestureRecognizerShouldBegin:gestureRecognizer];
}


#pragma mark - getter --- setter
- (UICollectionView *)collectionView
{
    if (_collectionView == nil)
    {
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:self.collectionViewLayout];
        collectionView.pagingEnabled = YES;
        collectionView.scrollsToTop = NO;
        collectionView.showsHorizontalScrollIndicator = NO;
        collectionView.delegate = self;
        collectionView.dataSource = self;
        [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:LZCollectionCellID];
        collectionView.bounces = NO;
        collectionView.scrollEnabled = self.segmentView.segmentStyle.isScrollContentView;
        [self addSubview:collectionView];
        _collectionView = collectionView;
    }
    return _collectionView;
}

- (UICollectionViewFlowLayout *)collectionViewLayout
{
    if (_collectionViewLayout == nil)
    {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = self.bounds.size;
        layout.minimumLineSpacing = 0.0;
        layout.minimumInteritemSpacing = 0.0;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionViewLayout = layout;
    }
    return _collectionViewLayout;
}


- (NSMutableDictionary<NSString *,UIViewController<LZScrollPageViewChildVcDelegate> *> *)childVcsDic
{
    if (!_childVcsDic)
    {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        _childVcsDic = dic;
    }
    return _childVcsDic;
}

@end