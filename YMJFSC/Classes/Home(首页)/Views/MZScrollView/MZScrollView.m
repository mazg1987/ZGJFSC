//
//  MZScrollView.m
//  YMJFSC
//
//  Created by mazg on 16/1/12.
//  Copyright © 2016年 mazg. All rights reserved.
//

#import "MZScrollView.h"

@implementation MZScrollView


- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        self.scView = [[UIScrollView alloc]init];
        self.scView.pagingEnabled = YES;
        self.scView.delegate = self;
        [self addSubview:self.scView];
        
        self.pageControl = [[UIPageControl alloc]init];
        self.pageControl.pageIndicatorTintColor = [UIColor blackColor];
        self.pageControl.currentPageIndicatorTintColor = [UIColor redColor];
        [self addSubview:self.pageControl];
    }
    return self;
}


- (void)layoutSubviews{
    [super layoutSubviews];
    self.scView.bounds = self.bounds;
    setFrameX(self.scView, 0);
    setFrameY(self.scView, 0);
    self.pageControl.frame = CGRectMake(0,CurrentViewHeight-10 , CurrentViewWidth, 10);
}


-(void)setImgData:(NSArray *)imgData{
    _imgData = imgData;
    //禁止垂直滚动
    self.scView.contentSize = CGSizeMake(CurrentViewWidth * imgData.count, 0);
    [self addContentView];
    [self setPageControl];
}

- (void)addContentView{
    for (int i =0; i<_imgData.count; i++) {
        UIImageView *imgView = [[UIImageView alloc]init];
        imgView.frame = CGRectMake(i*CurrentViewWidth, 0, CurrentViewWidth, CurrentViewHeight);
        [imgView sd_setImageWithURL:[NSURL URLWithString:_imgData[i]]];
        [self.scView addSubview:imgView];
    }
}

- (void)setPageControl{
    self.pageControl.currentPage = 0;
    self.pageControl.numberOfPages = _imgData.count;
}

#pragma mark UIScrollViewDelegate
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset NS_AVAILABLE_IOS(5_0){
    CGPoint size = *targetContentOffset;
    NSInteger currentPage = size.x / CurrentViewWidth;
    self.pageControl.currentPage = currentPage;
}

@end
