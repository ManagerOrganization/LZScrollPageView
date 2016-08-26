//
//  LZScrollPageView.h
//  LZScrollPageView
//
//  Created by lz on 16/7/28.
//  Copyright © 2016年 lz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+LZFrame.h"
#import "UIViewController+LZScrollPageController.h"
#import "LZContentView.h"
#import "LZCustomLabel.h"
#import "LZScrollSegmentView.h"
#import "LZSegmentStyle.h"
#import "LZScrollPageViewDelegate.h"

@interface LZScrollPageView : UIView
typedef void(^ExtraBtnOnClick)(UIButton *extraBtn);

@property (copy, nonatomic) ExtraBtnOnClick extraBtnOnClick;
@property (weak, nonatomic, readonly) LZContentView *contentView;
@property (weak, nonatomic, readonly) LZScrollSegmentView *segmentView;

@property(weak, nonatomic)id<LZScrollPageViewDelegate> delegate;


- (instancetype)initWithFrame:(CGRect)frame segmentStyle:(LZSegmentStyle *)segmentStyle titles:(NSArray<NSString *> *)titles parentViewController:(UIViewController *)parentViewController delegate:(id<LZScrollPageViewDelegate>) delegate ;


- (void)setSelectedIndex:(NSInteger)selectedIndex animated:(BOOL)animated;
- (void)reloadWithNewTitles:(NSArray<NSString *> *)newTitles;
@end
