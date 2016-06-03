//
//  HeadView.h
//  YMJFSC
//
//  Created by mazg on 16/1/14.
//  Copyright © 2016年 mazg. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeadView : UIView

@property (weak, nonatomic) IBOutlet UILabel *orderIDLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderTimeLabel;
@property (weak, nonatomic) IBOutlet UIButton *cancelOrderBtn;

+ (instancetype)headerView;

@end
