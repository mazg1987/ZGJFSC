//
//  ShoppingModel.m
//  YMJFSC
//
//  Created by mazg on 16/1/12.
//  Copyright © 2016年 mazg. All rights reserved.
//

#import "ShoppingModel.h"
#import "ResponseObject.h"
#import "ProductModel.h"

@implementation ShoppingModel

+ (instancetype)shoppingWithDict:(NSDictionary *)dict{
    ShoppingModel *model = [[ShoppingModel alloc]init];
    ResponseObject *obj = [[ResponseObject alloc]initWithDict:dict];
    if ([obj.code integerValue] == 0) {
        NSDictionary *tmpDic = dict[@"data"];
        model.subtotal = tmpDic[@"subtotal"];
        model.md5_cart_info = tmpDic[@"md5_cart_info"];
        
        //送货地址信息
        if (![tmpDic[@"def_addr"] isKindOfClass:[NSNull class]]) {
            model.addressModel = [[AddressModel alloc]initWithDict:tmpDic[@"def_addr"]];
        }
        //具体货物信息
        tmpDic = tmpDic[@"object"];
        NSArray *sgoods = tmpDic[@"goods"];
        model.goods = [ProductModel allProductWithArr:sgoods];
    }
    return model;
}

@end
