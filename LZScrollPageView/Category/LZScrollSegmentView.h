//
//  LZScrollSegmentView.h
//  LZScrollPageView
//
//  Created by lz on 16/7/28.
//  Copyright © 2016年 lz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LZSegmentStyle.h"
@class LZSegmentStyle;

typedef void(^TitleBtnOnClickBlock)(UILabel *label, NSInteger index);
typedef void(^ExtraBtnOnClick)(UIButton *extraBtn);

@interface LZScrollSegmentView : UIView

@property (strong, nonatomic) NSArray *titles;

// UI
@property (strong, nonatomic) LZSegmentStyle *segmentStyle;
@property (strong, nonatomic) UIImage *backgroundImage;

// 点击
@property (copy, nonatomic) ExtraBtnOnClick extraBtnOnClick;

// 初始化
- (instancetype)initWithFrame:(CGRect )frame segmentStyle:(LZSegmentStyle *)segmentStyle titles:(NSArray *)titles titleDidClick:(TitleBtnOnClickBlock)titleDidClick;


- (void)adjustUIWhenBtnOnClickWithAnimate:(BOOL)animated;
- (void)adjustUIWithProgress:(CGFloat)progress oldIndex:(NSInteger)oldIndex currentIndex:(NSInteger)currentIndex;
// 让选中的标题居中
- (void)adjustTitleOffSetToCurrentIndex:(NSInteger)currentIndex;
- (void)setSelectedIndex:(NSInteger)index animated:(BOOL)animated;
- (void)reloadTitlesWithNewTitles:(NSArray *)titles;

@end
