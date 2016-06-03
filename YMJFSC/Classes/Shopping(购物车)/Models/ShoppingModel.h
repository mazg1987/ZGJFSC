//
//  ShoppingModel.h
//  YMJFSC
//
//  Created by mazg on 16/1/12.
//  Copyright © 2016年 mazg. All rights reserved.
//

#import "BaseModel.h"
#import "AddressModel.h"

@interface ShoppingModel : BaseModel

@property (nonatomic,strong)NSArray *goods;     //存放购物车中的所有商品信息
@property (nonatomic,strong)NSString *subtotal; //总共减去的积分  这里的总积分在购物车列表中使用，结算列表不使用这个数据

//后来添加
@property (nonatomic,strong)NSString *md5_cart_info; //结算时使用
@property (nonatomic,strong)AddressModel *addressModel;  //结算时使用

+ (instancetype)shoppingWithDict:(NSDictionary *)dict;
@end
