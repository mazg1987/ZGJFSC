//
//  HeadView.m
//  YMJFSC
//
//  Created by mazg on 16/1/14.
//  Copyright © 2016年 mazg. All rights reserved.
//

#import "HeadView.h"

@implementation HeadView

- (void)awakeFromNib{
    [self.cancelOrderBtn addTarget:nil action:@selector(cancelOrderAction:) forControlEvents:UIControlEventTouchUpInside];
}

+ (instancetype)headerView{
    return [[[NSBundle mainBundle]loadNibNamed:@"HeadView" owner:nil options:nil] lastObject];
}


@end
