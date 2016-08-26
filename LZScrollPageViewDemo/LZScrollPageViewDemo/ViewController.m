//
//  ViewController.m
//  LZScrollPageViewDemo
//
//  Created by lz on 16/8/1.
//  Copyright © 2016年 lz. All rights reserved.
//

#import "ViewController.h"
#import "TestViewController.h"

@interface ViewController ()
- (IBAction)push:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)push:(id)sender {
    TestViewController *testViewController = [[TestViewController alloc] init];
    [self.navigationController pushViewController:testViewController animated:YES];
}
@end
