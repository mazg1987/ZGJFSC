//
//  GoodDetailViewController.h
//  YMJFSC
//
//  Created by mazg on 16/1/12.
//  Copyright © 2016年 mazg. All rights reserved.
//

#import "BaseViewController.h"
#import "GoodModel.h"

@interface GoodDetailViewController : BaseViewController

@property(nonatomic,strong)GoodModel *detailModel; //根据当前model请求页面详情数据

@end
