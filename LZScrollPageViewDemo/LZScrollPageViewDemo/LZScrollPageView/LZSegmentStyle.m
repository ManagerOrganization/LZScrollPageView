//
//  LZSegmentStyle.m
//  LZScrollPageView
//
//  Created by lz on 16/7/28.
//  Copyright © 2016年 lz. All rights reserved.
//

#import "LZSegmentStyle.h"

@implementation LZSegmentStyle

- (instancetype)init {
    if(self = [super init]) {
        self.showCover = NO;
        self.showLine = NO;
        self.scaleTitle = NO;
        self.scrollTitle = YES;
        self.segmentViewBounces = YES;
        self.gradualChangeTitleColor = NO;
        self.showExtraButton = NO;
        self.scrollContentView = YES;
        self.adjustCoverOrLineWidth = NO;
        self.extraBtnBackgroundImageName = nil;
        self.scrollLineHeight = 2.0;
        self.scrollLineColor = [UIColor brownColor];
        self.coverBackgroundColor = [UIColor lightGrayColor];
        self.coverCornerRadius = 14.0;
        self.coverHeight = 28.0;
        self.titleMargin = 15.0;
        self.titleFont = [UIFont systemFontOfSize:14.0];
        self.titleBigScale = 1.3;
        self.normalTitleColor = [UIColor colorWithRed:51.0/255.0 green:53.0/255.0 blue:75/255.0 alpha:1.0];
        
        self.selectedTitleColor = [UIColor colorWithRed:255.0/255.0 green:0.0/255.0 blue:121/255.0 alpha:1.0];
        
        self.segmentHeight = 44.0;
        
    }
    return self;
}

@end
