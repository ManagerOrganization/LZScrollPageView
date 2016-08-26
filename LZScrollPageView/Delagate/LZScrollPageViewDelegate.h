//
//  LZScrollPageViewDelegate.h
//  LZScrollPageView
//
//  Created by lz on 16/7/28.
//  Copyright © 2016年 lz. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol LZScrollPageViewChildVcDelegate <NSObject>

@optional

- (void)setUpWhenViewWillAppearForTitle:(NSString *)title forIndex:(NSInteger)index firstTimeAppear: (BOOL)isFirstTime;

@end


@protocol LZScrollPageViewDelegate <NSObject>

- (NSInteger) numberOfChildViewControllers;

- (UIViewController<LZScrollPageViewChildVcDelegate> *)childViewController:(UIViewController<LZScrollPageViewChildVcDelegate> *)reuseViewController forIndex:(NSInteger)index;

@end