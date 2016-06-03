//
//  ProductModel.h
//  YMJFSC
//
//  Created by mazg on 16/1/12.
//  Copyright © 2016年 mazg. All rights reserved.
//

#import "BaseModel.h"

@interface ProductModel : BaseModel

@property (nonatomic,strong)NSString *goods_id;
@property (nonatomic,strong)NSString *product_id;
@property (nonatomic,strong)NSString *store;    //库存
@property (nonatomic,strong)NSString *quantity; //购买数量
@property (nonatomic,strong)NSString *subtotal; //减去总积分
@property (nonatomic,strong)NSString *name;     //名称
@property (nonatomic,strong)NSString *thumbnail; //图片
@property (nonatomic,strong)NSString *score; // 未支付的商品订单中新增的字段

+ (NSMutableArray *)allProductWithArr:(NSArray *)arr;

//未支付的订单的数据返回方式
+ (NSMutableArray *)allProductWithDict:(NSDictionary *)dict;

@end
