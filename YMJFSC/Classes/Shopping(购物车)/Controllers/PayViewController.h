//
//  PayViewController.h
//  YMJFSC
//
//  Created by mazg on 16/1/13.
//  Copyright © 2016年 mazg. All rights reserved.
//

#import "BaseViewController.h"
#import "ShoppingModel.h"

//本控制器不是支付的控制器，只是提交订单的控制器
//这里面创建控制器名字的时候小问题

@interface PayViewController : BaseViewController

@property (nonatomic,strong) ShoppingModel *payModel;
@property (nonatomic,strong) NSArray *payGoodList;

@end
