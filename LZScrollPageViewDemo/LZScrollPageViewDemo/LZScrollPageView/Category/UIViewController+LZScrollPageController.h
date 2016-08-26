//
//  UIViewController+LZScrollPageController.h
//  LZScrollPageView
//
//  Created by lz on 16/7/28.
//  Copyright © 2016年 lz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (LZScrollPageController)

/**
 *  所有子控制的父控制器, 方便在每个子控制页面直接获取到父控制器进行其他操作
 */

@property (nonatomic, weak) UIViewController *scrollPageParentViewController;


@end
