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
@class TCycleView;

@protocol TCycleViewDelegate<NSObject>
- (void)cycleView:(TCycleView *)cycleView didSelectRowAtIndex:(NSInteger)row;
@end

@interface TCycleView : UIView

@property (nonatomic, strong) NSMutableArray *sourceArray;
@property (nonatomic, weak) id delegate;
@property (nonatomic, strong) void(^selectRowBlock)(TCycleView *cycleView,NSInteger index);

/**
 Return a cycle play view

 @param direction playing direction
 @return a cycle play view
 */
+ (instancetype)showCycleViewWithScrollDirection:(UICollectionViewScrollDirection)direction;
@end
