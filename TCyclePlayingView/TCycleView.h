//
//  TCycleView.h
//  TCyclePlayingViewDemo
//
//  Created by 唐鹏 on 2018/9/4.
//  Copyright © 2018年 唐鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,TCycleViewType) {
    TCycleViewTypeVertical, // 上下滑动轮播
    TCycleViewTypeHorizontal // 水平滑动轮播
};
@interface TCycleView : UIView

/**
 Create cycle view quickly

 @param sources array of image url
 @return a cycle view
 */
+ (instancetype)showCycleViewWithSources:(NSArray <NSString *> *)sources scrollDirection:(UICollectionViewScrollDirection)direction;
@end
