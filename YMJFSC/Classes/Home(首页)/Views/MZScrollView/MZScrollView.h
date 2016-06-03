//
//  MZScrollView.h
//  YMJFSC
//
//  Created by mazg on 16/1/12.
//  Copyright © 2016年 mazg. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MZScrollView : UIView<UIScrollViewDelegate>

@property (nonatomic,strong) UIPageControl *pageControl;
@property (nonatomic,strong) UIScrollView *scView;
@property (nonatomic,strong) NSArray *imgData;

@end
