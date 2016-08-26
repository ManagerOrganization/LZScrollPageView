//
//  UIView+Frame.m
//  LZScrollPageView
//
//  Created by lz on 16/7/28.
//  Copyright © 2016年 lz. All rights reserved.
//

#import "UIView+LZFrame.h"

@implementation UIView (LZFrame)


//getter
- (CGFloat) lz_centerX
{
    return self.center.x;
}

- (CGFloat) lz_centerY
{
    return self.center.y;
}

- (CGFloat) lz_x
{
    return self.frame.origin.x;
}

- (CGFloat) lz_y
{
    return self.frame.origin.y;
}

- (CGFloat) lz_width
{
    return self.frame.size.width;
}

-(CGFloat) lz_height

{
    return self.frame.size.height;
}

//setter
- (void) setLz_centerX: (CGFloat)lz_centerX
{
    CGPoint center = self.center;
    center.x = lz_centerX;
    self.center = center;
}

- (void) setLz_centerY:(CGFloat)lz_centerY
{
    CGPoint center = self.center;
    center.y = lz_centerY;
    self.center = center;
}

- (void) setLz_x:(CGFloat)lz_x
{
    CGRect frame = self.frame;
    frame.origin.x = lz_x;
    self.frame = frame;
}

- (void) setLz_y:(CGFloat)lz_y
{
    CGRect frame = self.frame;
    frame.origin.y = lz_y;
    self.frame = frame;
}

- (void) setLz_width:(CGFloat)lz_width
{
    CGRect frame = self.frame;
    frame.size.width = lz_width;
    self.frame = frame;
}

- (void) setLz_height:(CGFloat)lz_height
{
    CGRect frame = self.frame;
    frame.size.height = lz_height;
    self.frame = frame;
}

@end
