//
//  TCycleView.m
//  TCyclePlayingViewDemo
//
//  Created by 唐鹏 on 2018/9/4.
//  Copyright © 2018年 唐鹏. All rights reserved.
//

#import "TCycleView.h"
#import "TCycleViewCell.h"
static NSString *const kCellID = @"kCellID";

@interface TCycleView()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *sourceArray;
@property (nonatomic, assign) UICollectionViewScrollDirection direction;
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
@end

@implementation TCycleView
+ (instancetype)showCycleViewWithSources:(NSArray<NSString *> *)sources scrollDirection:(UICollectionViewScrollDirection)direction{
    return [[self alloc] initWithSources:sources scrollDirection:direction];
}

- (instancetype)initWithSources:(NSArray<NSString *> *)sources scrollDirection:(UICollectionViewScrollDirection)direction{
    if (self = [super init]) {
        _sourceArray = [sources copy];
        _direction = direction;
        [self initCollectionView];
        [_collectionView registerClass:[TCycleViewCell class] forCellWithReuseIdentifier:@"kCellID"];
    }
    return self;
}

- (void)initCollectionView{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _flowLayout = flowLayout;
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flowLayout];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.showsVerticalScrollIndicator = NO;
    [self addSubview:collectionView];
    _collectionView = collectionView;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    _flowLayout.itemSize = CGSizeMake(self.frame.size.width, self.frame.size.height);
    _collectionView.frame = self.bounds;
}

#pragma mark - datasource

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.sourceArray.count;
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    TCycleViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellID forIndexPath:indexPath];
    cell.imageView.image = [UIImage imageNamed:self.sourceArray[indexPath.row]];
    return cell;
}

#pragma mark - delegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
}

@end
