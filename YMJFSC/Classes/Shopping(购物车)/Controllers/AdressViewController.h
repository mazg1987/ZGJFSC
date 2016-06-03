//
//  AdressViewController.h
//  YMJFSC
//
//  Created by mazg on 16/1/13.
//  Copyright © 2016年 mazg. All rights reserved.
//

#import "BaseViewController.h"
@class AddressModel;

//地址列表有两个来源
//1、点击导航栏按钮进入地址列表界面，此时不需要显示当前cell中的是否选中图标
//2、点击结算按钮进入结算界面，结算界面有会有默认地址，点击选择其他地址进入该页面，此种情况需要显示当前cell中的是否选中当前图标，选中该cell后，应该退出当前页面，并把新选中的地址返回给上一个页面
@protocol AddressViewControllerDelegate <NSObject>

- (void)passSelAddress:(AddressModel *)model;

@end

@interface AdressViewController : BaseViewController

@property (nonatomic,weak)id<AddressViewControllerDelegate>delegate;

@end
