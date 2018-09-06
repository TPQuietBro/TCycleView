//
//  TPageControllConfigure.m
//  TCyclePlayingViewDemo
//
//  Created by 唐鹏 on 2018/9/5.
//  Copyright © 2018年 唐鹏. All rights reserved.
//

#import "TPageControllConfigure.h"

@implementation TPageControllConfigure
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initPageControll];
    }
    return self;
}

- (void)initPageControll{
    UIPageControl *pageControll = [[UIPageControl alloc] init];
    pageControll.currentPage = 0;
    pageControll.numberOfPages = 1;
    pageControll.hidesForSinglePage = YES;
    pageControll.pageIndicatorTintColor = [UIColor lightGrayColor];
    pageControll.currentPageIndicatorTintColor = [UIColor whiteColor];
    [pageControll addTarget:self action:@selector(didSelectedPage:) forControlEvents:UIControlEventTouchUpInside];
    _pageControll = pageControll;
}

- (void)didSelectedPage:(UIPageControl *)sender{
    [self.delegate respondsToSelector:@selector(pageControll:selectedIndex:)] ? [self.delegate pageControll:self selectedIndex:sender.currentPage] : nil;
}

#pragma mark - getter / setter

- (void)setPageIndicatorTintColor:(UIColor *)pageIndicatorTintColor{
    _pageControll.pageIndicatorTintColor = pageIndicatorTintColor;
}

- (void)setCurrentPageIndicatorTintColor:(UIColor *)currentPageIndicatorTintColor{
    _pageControll.currentPageIndicatorTintColor = currentPageIndicatorTintColor;
}

- (void)setCurrentPage:(NSInteger)currentPage{
    _pageControll.currentPage = currentPage;
}

- (void)setNumberOfPage:(NSInteger)numberOfPages{
    _pageControll.numberOfPages = numberOfPages;
}

- (void)setPageIndicatorImageName:(NSString *)pageIndicatorImageName{
    [_pageControll setValue:[UIImage imageNamed:pageIndicatorImageName] forKeyPath:@"_currentPageImage"];
}

- (void)setCurrentPageIndicatorImageName:(NSString *)currentPageIndicatorImageName{
    [_pageControll setValue:[UIImage imageNamed:currentPageIndicatorImageName] forKeyPath:@"_pageImage"];
}

- (void)setFrame:(CGRect)frame{
    _pageControll.frame = frame;
}

@end
