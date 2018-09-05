//
//  ViewController.m
//  TCyclePlayingViewDemo
//
//  Created by 唐鹏 on 2018/9/4.
//  Copyright © 2018年 唐鹏. All rights reserved.
//

#import "ViewController.h"
#import "TCycleView.h"

@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    TCycleView *view = [TCycleView showCycleViewWithScrollDirection:UICollectionViewScrollDirectionHorizontal];
    view.frame = CGRectMake(20, 50, 200, 80);
    [self.view addSubview:view];
    view.sourceArray = [@[@"1",@"2",@"3"] mutableCopy];
    view.selectRowBlock = ^(TCycleView *cycleView, NSInteger index) {
        NSLog(@"index : %ld",index);
    };
}


@end
