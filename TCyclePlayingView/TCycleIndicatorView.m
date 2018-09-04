//
//  TCycleIndicatorView.m
//  TCyclePlayingViewDemo
//
//  Created by 唐鹏 on 2018/9/4.
//  Copyright © 2018年 唐鹏. All rights reserved.
//

#import "TCycleIndicatorView.h"

@interface TCycleIndicator : UIView

@end

@implementation TCycleIndicator
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addShapeLayerWithRadius:self.bounds.size.width / 2 color:nil];
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.01];
    }
    return self;
}
- (void)addShapeLayerWithRadius:(CGFloat)radius color:(UIColor *)color{
    UIBezierPath *bPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(radius, radius)];
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = bPath.CGPath;
    shapeLayer.fillColor = color.CGColor;
    [self.layer addSublayer:shapeLayer];
}
@end

@interface TCycleIndicatorView()
@property (nonatomic, assign) NSInteger count;
@end

@implementation TCycleIndicatorView
+ (instancetype)createIndicatorWithCount:(NSInteger)count{
    return [[self alloc] initIndicatorWithCount:count];
}

- (instancetype)initIndicatorWithCount:(NSInteger)count{
    if (self = [super init]) {
        _count = count;
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.01];
        [self createIndicator];
    }
    return self;
}

- (void)createIndicator{
    
}

@end
