//
//  UIView+Frame.h
//  LZScrollPageView
//
//  Created by lz on 16/7/28.
//  Copyright © 2016年 lz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (LZFrame)

@property (nonatomic, assign, readwrite) CGFloat lz_centerX;
@property (nonatomic, assign, readwrite) CGFloat lz_centerY;

@property (nonatomic, assign, readwrite) CGFloat lz_x;
@property (nonatomic, assign, readwrite) CGFloat lz_y;

@property (nonatomic, assign, readwrite) CGFloat lz_width;
@property (nonatomic, assign, readwrite) CGFloat lz_height;

@end
