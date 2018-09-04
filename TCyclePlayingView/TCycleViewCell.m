//
//  TCycleViewCell.m
//  TCyclePlayingViewDemo
//
//  Created by 唐鹏 on 2018/9/4.
//  Copyright © 2018年 唐鹏. All rights reserved.
//

#import "TCycleViewCell.h"

@implementation TCycleViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.imageView];
        self.imageView.frame = self.bounds;
    }
    return self;
}
- (UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.userInteractionEnabled = YES;
    }
    return _imageView;
}
@end
