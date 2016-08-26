//
//  LZScrollPageView.m
//  LZScrollPageView
//
//  Created by lz on 16/7/28.
//  Copyright © 2016年 lz. All rights reserved.
//

#import "LZScrollPageView.h"

@interface LZScrollPageView ()
@property (strong, nonatomic) LZSegmentStyle *segmentStyle;
@property (weak, nonatomic) LZScrollSegmentView *segmentView;
@property (weak, nonatomic) LZContentView *contentView;

@property (weak, nonatomic) UIViewController *parentViewController;
@property (strong, nonatomic) NSArray *childVcs;
@property (strong, nonatomic) NSArray *titlesArray;

@end

@implementation LZScrollPageView

#pragma mark - life cycle
- (instancetype)initWithFrame:(CGRect)frame segmentStyle:(LZSegmentStyle *)segmentStyle titles:(NSArray<NSString *> *)titles parentViewController:(UIViewController *)parentViewController delegate:(id<LZScrollPageViewDelegate>) delegate
{
    if (self = [super initWithFrame:frame])
    {
        self.segmentStyle = segmentStyle;
        self.delegate = delegate;
        self.parentViewController = parentViewController;
        self.titlesArray = titles.copy;
        [self commonInit];
    }
    return self;
}


- (void)commonInit
{
    self.segmentView.backgroundColor = [UIColor whiteColor];
    self.contentView.backgroundColor = [UIColor whiteColor];
}

- (void)dealloc
{
    NSLog(@"ScrollPageView--销毁");
}

#pragma mark - public helper

- (void)setSelectedIndex:(NSInteger)selectedIndex animated:(BOOL)animated
{
    [self.segmentView setSelectedIndex:selectedIndex animated:animated];
}

- (void)reloadWithNewTitles:(NSArray<NSString *> *)newTitles
{
    self.titlesArray = nil;
    self.titlesArray = newTitles.copy;
    [self.segmentView reloadTitlesWithNewTitles:self.titlesArray];
    [self.contentView reload];
}


#pragma mark - getter ---- setter

- (LZContentView *)contentView
{
    if (!_contentView)
    {
        LZContentView *content = [[LZContentView alloc] initWithFrame:CGRectMake(0.0, CGRectGetMaxY(self.segmentView.frame), self.bounds.size.width, self.bounds.size.height - CGRectGetMaxY(self.segmentView.frame)) segmentView:self.segmentView parentViewController:self.parentViewController delegate:self.delegate];
        [self addSubview:content];
        _contentView = content;
    }
    return  _contentView;
}


- (LZScrollSegmentView *)segmentView
{
    if (!_segmentView)
    {
        __weak typeof(self) weakSelf = self;
        LZScrollSegmentView *segment = [[LZScrollSegmentView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.segmentStyle.segmentHeight) segmentStyle:self.segmentStyle titles:self.titlesArray titleDidClick:^(UILabel *label, NSInteger index)
        {
            [weakSelf.contentView setContentOffSet:CGPointMake(weakSelf.contentView.bounds.size.width * index, 0.0) animated:NO];
            
        }];
        [self addSubview:segment];
        _segmentView = segment;
    }
    return _segmentView;
}


- (NSArray *)childVcs
{
    if (!_childVcs)
    {
        _childVcs = [NSArray array];
    }
    return _childVcs;
}

- (NSArray *)titlesArray
{
    if (!_titlesArray)
    {
        _titlesArray = [NSArray array];
    }
    return _titlesArray;
}

- (void)setExtraBtnOnClick:(ExtraBtnOnClick)extraBtnOnClick
{
    _extraBtnOnClick = extraBtnOnClick;
    self.segmentView.extraBtnOnClick = extraBtnOnClick;
}

@end

