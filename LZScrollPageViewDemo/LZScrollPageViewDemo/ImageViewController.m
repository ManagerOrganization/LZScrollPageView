//
//  ImageViewController.m
//  LZScrollPageViewDemo
//
//  Created by lz on 16/8/26.
//  Copyright © 2016年 lz. All rights reserved.
//

#import "ImageViewController.h"


@interface ImageViewController ()
@property (strong, nonatomic)UIImageView *imageView;
@property (nonatomic, copy)NSArray<NSString *> *imgArray;

@end

@implementation ImageViewController

-(void)viewDidLoad {
    self.imgArray = @[@"DSC_2779.jpg",@"DSC_2790.jpg",@"DSC_2875.jpg",@"DSC_3124.jpg",@"DSC_3386.jpg",@"DSC_3437.jpg",@"DSC_3253.jpg",];
    self.imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:self.imageView];
}


#pragma ZJScrollPageViewChildVcDelegate
// 每次页面出现的时候会调用
- (void)setUpWhenViewWillAppearForTitle:(NSString *)title forIndex:(NSInteger)index firstTimeAppear: (BOOL)isFirstTime {
    [self.imageView setImage:[UIImage imageNamed:_imgArray[index]]];
}

@end
