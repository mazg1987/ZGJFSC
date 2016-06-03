//
//  OrderModel.h
//  YMJFSC
//
//  Created by mazg on 16/1/14.
//  Copyright © 2016年 mazg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"
#import "AddressModel.h"

@interface OrderModel : BaseModel

@property (nonatomic,strong)NSString *createtime;  //订单创建时间
@property (nonatomic,strong)NSArray *goods_items; //订单商品数组
@property (nonatomic,strong)NSString *order_id;   //订单号
@property (nonatomic,strong)AddressModel *addressModel;//配送地址

+ (NSMutableArray *)allOrdersWithDictionary:(NSDictionary *)dict;

@end
