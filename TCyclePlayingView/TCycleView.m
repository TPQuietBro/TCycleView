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
#define TViewWidth self.frame.size.width
#define TViewHeight self.frame.size.height

@interface TCycleView()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, assign) UICollectionViewScrollDirection direction;
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, assign) NSInteger currentPage;
@end

@implementation TCycleView
+ (instancetype)showCycleViewWithScrollDirection:(UICollectionViewScrollDirection)direction{
    return [[self alloc] initWithScrollDirection:direction];
}

- (instancetype)initWithScrollDirection:(UICollectionViewScrollDirection)direction{
    if (self = [super init]) {
        _direction = direction;
        _currentPage = 0;
        [self initCollectionView];
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
    collectionView.pagingEnabled = YES;
    collectionView.bounces = NO;
    [collectionView registerClass:[TCycleViewCell class] forCellWithReuseIdentifier:kCellID];
    [self addSubview:collectionView];
    _collectionView = collectionView;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    _flowLayout.itemSize = CGSizeMake(TViewWidth, TViewHeight);
    _collectionView.frame = self.bounds;
}

#pragma mark - datasource

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.sourceArray.count;
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    TCycleViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellID forIndexPath:indexPath];
    if (indexPath.item >= [self collectionView:collectionView numberOfItemsInSection:0]) {
        return cell;
    }
    cell.imageView.image = [UIImage imageNamed:self.sourceArray[indexPath.item]];
    return cell;
}

#pragma mark - delegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.delegate respondsToSelector:@selector(cycleView:didSelectRowAtIndex:)]) {
        [self.delegate cycleView:self didSelectRowAtIndex:indexPath.item - 1];
    }
    if (self.selectRowBlock) {
        self.selectRowBlock(self, indexPath.item - 1);
    }
}

- (void)scrollViewDidScroll:(UICollectionView *)scrollView{
    
}

- (void)scrollViewWillBeginDragging:(UICollectionView *)scrollView{

}

- (void)scrollViewDidEndDecelerating:(UICollectionView *)scrollView{
    NSLog(@"currentPage : %ld",self.currentPage);
    if (self.currentPage == 0) {
        [scrollView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:self.sourceArray.count - 2 inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    } else if (self.currentPage == self.sourceArray.count - 1){
        [scrollView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:1 inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UICollectionView *)scrollView{
    
}

#pragma mark - getter / setter
- (void)setSourceArray:(NSMutableArray *)sourceArray{
    _sourceArray = sourceArray;

    if (self.sourceArray.count > 1) {
        [self updateSouces];
        [_collectionView reloadData];
        _collectionView.hidden = YES;
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:1 inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
            self.collectionView.hidden = NO;
            NSLog(@"array:%@ contentoffset x : %lf page:%ld",self.sourceArray,self.collectionView.contentOffset.x,self.currentPage);
        });
    }
}
#pragma mark - private

- (NSInteger)currentDataIndexWithRow:(NSInteger)row{
    NSInteger index = 0;
    if (self.sourceArray.count > 1) {
        if (row == 0) {
            index = self.sourceArray.count - 1;
        } else if (row == self.sourceArray.count - 1){
            index = 0;
        } else {
            index = row - 1;
        }
    } else {
        index = row;
    }
    return index;
}

- (NSInteger)currentPage{
    NSInteger index = (self.collectionView.contentOffset.x + 0.5 * TViewWidth) / TViewWidth;
    return index;
}

- (void)updateSouces{
    if (self.sourceArray.count > 1) {
        NSMutableArray *tempArray = [self.sourceArray mutableCopy];
        [self.sourceArray addObject:tempArray.firstObject];
        [self.sourceArray insertObject:tempArray.lastObject atIndex:0];
    }
}

@end
