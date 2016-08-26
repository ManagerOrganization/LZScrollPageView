//
//  UIViewController+LZScrollPageController.m
//  LZScrollPageView
//
//  Created by lz on 16/7/28.
//  Copyright © 2016年 lz. All rights reserved.
//

#import "UIViewController+LZScrollPageController.h"
#import <objc/runtime.h>

@interface UIViewController ()

@end

@implementation UIViewController (LZScrollPageController)

static char key;

- (void)setScrollPageParentViewController:(UIViewController *)scrollPageParentViewController
{
    objc_setAssociatedObject(self, &key, scrollPageParentViewController, OBJC_ASSOCIATION_ASSIGN);
}

- (UIViewController *)scrollPageParentViewController
{
    return (UIViewController *)objc_getAssociatedObject(self, &key);
}



@end
