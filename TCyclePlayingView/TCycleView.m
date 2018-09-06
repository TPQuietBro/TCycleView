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
@property (nonatomic,strong) NSTimer *cycleTimer;
@end

@implementation TCycleView

#pragma mark - init
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
    flowLayout.scrollDirection = self.direction;
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

- (void)initTimer{
    _cycleTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(scroll) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_cycleTimer forMode:NSRunLoopCommonModes];
}

- (void)scroll{
    
    [self scrollViewDidEndDecelerating:self.collectionView];
    
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:self.currentPage + 1 inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
}

- (void)fireTimer{
    [self.cycleTimer invalidate];
    self.cycleTimer = nil;
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

- (void)scrollViewWillBeginDragging:(UICollectionView *)scrollView{
    if (self.cycleTimer) {
        [self fireTimer];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (!self.cycleTimer) {
        [self initTimer];
    }
}

- (void)scrollViewDidEndDecelerating:(UICollectionView *)scrollView{
    NSLog(@"currentPage : %ld",(long)self.currentPage);
    if (self.sourceArray.count < 2) {
        return;
    }
    if (self.currentPage == 0) {
        [scrollView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:self.sourceArray.count - 2 inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    } else if (self.currentPage == self.sourceArray.count - 1){
        [scrollView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:1 inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    }
    self.configure.currentPage = self.currentPage;
}

#pragma mark - getter / setter

- (void)setConfigure:(TPageControllConfigure *)configure{
    _configure = configure;
    [self addSubview:configure.pageControll];
}

- (void)setSourceArray:(NSMutableArray <NSString *>*)sourceArray{
    _sourceArray = sourceArray;

    if (self.sourceArray.count > 1) {
        [self updateSouces];
        [_collectionView reloadData];
        _collectionView.hidden = YES;
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:1 inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
            self.collectionView.hidden = NO;
            NSLog(@"array:%@ contentoffset x : %lf page:%ld",self.sourceArray,self.collectionView.contentOffset.x,(long)self.currentPage);
        });
        [self initTimer];
    }
}

#pragma mark - private

- (NSInteger)currentPage{
    NSInteger index = 0;
    switch (self.direction) {
        case UICollectionViewScrollDirectionHorizontal:
        {
            index = (self.collectionView.contentOffset.x + 0.5 * TViewWidth) / TViewWidth;
        }
            break;
        case UICollectionViewScrollDirectionVertical:
        {
            index = (self.collectionView.contentOffset.y + 0.5 * TViewHeight) / TViewHeight;
        }
    }
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
