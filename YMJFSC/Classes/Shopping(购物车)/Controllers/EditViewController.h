//
//  EditViewController.h
//  YMJFSC
//
//  Created by mazg on 16/1/13.
//  Copyright © 2016年 mazg. All rights reserved.
//

#import "BaseViewController.h"
#import "AddressModel.h"

//本页面有两个来源:
//1、点击前一个页面的地址编辑按钮进来重新编辑地址保存数据
//2、点击新增地址进来 新增地址保存

@interface EditViewController : BaseViewController

@property (nonatomic,strong)AddressModel *model;

@end
