//
//  LZContentView.h
//  LZScrollPageView
//
//  Created by lz on 16/8/1.
//  Copyright © 2016年 lz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LZScrollPageViewDelegate.h"
@class LZScrollSegmentView;
@class LZContentView;

@interface LZContentView : UIView

@property(weak, nonatomic)id<LZScrollPageViewDelegate> delegate;

//初始化
- (instancetype)initWithFrame:(CGRect)frame segmentView:(LZScrollSegmentView *)segmentView parentViewController:(UIViewController *)parentViewController delegate:(id<LZScrollPageViewDelegate>) delegate;

- (void)setContentOffSet:(CGPoint)offset animated:(BOOL)animated;

- (void)reload;
@end
