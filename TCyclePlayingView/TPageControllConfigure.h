//
//  TPageControllConfigure.h
//  TCyclePlayingViewDemo
//
//  Created by 唐鹏 on 2018/9/5.
//  Copyright © 2018年 唐鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TPageControllConfigure;
@protocol TPageControllConfigureDelegate<NSObject>
- (void)pageControll:(TPageControllConfigure *)pageControll selectedIndex:(NSInteger)currentPage;
@end

@interface TPageControllConfigure : NSObject
@property (nonatomic, weak) id<TPageControllConfigureDelegate> delegate;
@property (nonatomic, strong) UIColor *pageIndicatorTintColor;
@property (nonatomic, strong) UIColor *currentPageIndicatorTintColor;
@property (nonatomic, strong) NSString *pageIndicatorImageName;
@property (nonatomic, strong) NSString *currentPageIndicatorImageName;
@property (nonatomic, strong) UIPageControl *pageControll;
@property (nonatomic, assign) NSInteger currentPage;
@property (nonatomic, assign) NSInteger numberOfPage;
@property (nonatomic, assign) CGRect frame;
@end
