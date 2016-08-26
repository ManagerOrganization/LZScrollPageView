//
//  TestViewController.m
//  LZScrollPageViewDemo
//
//  Created by lz on 16/8/1.
//  Copyright © 2016年 lz. All rights reserved.
//

#import "TestViewController.h"
#import "LZScrollPageView.h"
#import "ImageViewController.h"

@interface TestViewController () <LZScrollPageViewDelegate>
@property(weak, nonatomic)LZScrollPageView *scrollPageView;
@property(strong, nonatomic)NSArray<NSString *> *titles;
@property(strong, nonatomic)NSArray<UIViewController *> *childVcs;
@end

@implementation TestViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"IU";

    self.automaticallyAdjustsScrollViewInsets = NO;
    
    LZSegmentStyle *style = [[LZSegmentStyle alloc] init];
    //显示滚动条
    style.showLine = YES;
    // 颜色渐变
    style.gradualChangeTitleColor = YES;
    //放大
    style.scaleTitle = YES;
    
    self.titles = @[@"IU0000",
                    @"IU0001",
                    @"IU0002",
                    @"IU0003",
                    @"IU0004",
                    @"IU0005",
                    @"IU0006",
                    ];
    // 初始化
    LZScrollPageView *scrollPageView = [[LZScrollPageView alloc] initWithFrame:CGRectMake(0, 64.0, self.view.bounds.size.width, self.view.bounds.size.height - 64.0) segmentStyle:style titles:self.titles parentViewController:self delegate:self];
    
    [self.view addSubview:scrollPageView];
}

- (NSInteger)numberOfChildViewControllers {
    return self.titles.count;
}

- (UIViewController<LZScrollPageViewChildVcDelegate> *)childViewController:(UIViewController<LZScrollPageViewChildVcDelegate> *)reuseViewController forIndex:(NSInteger)index {
    
    UIViewController<LZScrollPageViewChildVcDelegate> *childVc = reuseViewController;

    if (!childVc) {
        
         childVc = [[ImageViewController alloc] init];
        childVc.view.backgroundColor = [UIColor whiteColor];
        
    }
    
    return childVc;

    

}

@end
