//
//  SegVC.m
//  TestSegmentAndRefreshTableViewDemo
//
//  Created by Guohx on 2017/5/4.
//  Copyright © 2017年 ghx. All rights reserved.
//

#import "SegVC.h"

#import "HXSegmentVCView.h"
#import "ExampleTableVC.h"


#define HX_SEG_SCREEN_WIDTH ([[UIScreen mainScreen]bounds].size.width)
#define HX_SEG_SCREEN_HEIGHT ([[UIScreen mainScreen]bounds].size.height)

@interface SegVC ()

@end

@implementation SegVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    self.title = @"测试";
    
    [self initSeg];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark- initUI
- (void)initSeg {
    NSMutableArray * contentVCArr = [NSMutableArray array];
    for (int i = 0; i < 3; i ++) {
        
        if (i < 2) {
            ExampleTableVC * exampleTableVC = [[ExampleTableVC alloc] init];
            exampleTableVC.view.backgroundColor = (i == 0)?[UIColor yellowColor]:[UIColor redColor];
            [contentVCArr addObject:exampleTableVC];
        } else {
            UIViewController * exampleTableVC = [[UIViewController alloc] init];
            exampleTableVC.view.backgroundColor = [UIColor greenColor];
            [contentVCArr addObject:exampleTableVC];
        }
        
        
        
    }
    
    HXSegmentVCView * seg = [[HXSegmentVCView alloc] initWithTitleArr:@[@"tableVC1",@"tableVC2",@"VC"] contentVCArr:contentVCArr];
    seg.view.frame = CGRectMake(0, 64, HX_SEG_SCREEN_WIDTH, HX_SEG_SCREEN_HEIGHT - 64);
    seg.defaultIndex = 1; //设置默认
    [self.view addSubview:seg.view];
    
    //改变标题
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [seg setSegTitle:@"1212（1）" index:0];
    });
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [seg setSegTitle:@"1111（10）" index:1];
    });
    
    //点击事件回调
    [seg setSegSelect:^(UIViewController *vc, NSInteger index) {
        NSLog(@"seg click %ld",(long)index);
    }];
}



@end
