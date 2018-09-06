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

    TCycleView *view1 = [TCycleView showCycleViewWithScrollDirection:UICollectionViewScrollDirectionHorizontal];
    view1.frame = CGRectMake(20, 150, 200, 80);
    [self.view addSubview:view1];
    view1.sourceArray = [@[@"1",@"2",@"3"] mutableCopy];
    view1.selectRowBlock = ^(TCycleView *cycleView, NSInteger index) {
        NSLog(@"index : %ld",index);
    };
    TPageControllConfigure *configure = [[TPageControllConfigure alloc] init];
    configure.numberOfPage = 3;
    configure.currentPage = 0;
    configure.pageIndicatorTintColor = [UIColor blackColor];
    configure.currentPageIndicatorTintColor = [UIColor orangeColor];
    configure.frame = CGRectMake((view1.frame.size.width - 80) * 0.5, view1.frame.size.height - 30, 80, 30);
    view1.configure = configure;
    
}


@end
