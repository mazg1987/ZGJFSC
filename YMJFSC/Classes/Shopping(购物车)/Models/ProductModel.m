//
//  ProductModel.m
//  YMJFSC
//
//  Created by mazg on 16/1/12.
//  Copyright © 2016年 mazg. All rights reserved.
//

#import "ProductModel.h"

@implementation ProductModel

+ (NSMutableArray *)allProductWithArr:(NSArray *)arr{
    NSMutableArray *arrM = [[NSMutableArray alloc]init];
    for (NSDictionary *tmpDic in arr) {
        if ([tmpDic isKindOfClass:[NSDictionary class]]) {
            ProductModel *model = [[ProductModel alloc]init];
            model.subtotal = tmpDic[@"subtotal"];
            model.quantity = tmpDic[@"quantity"];
            NSDictionary *tmpDic2 = tmpDic[@"obj_items"];
            tmpDic2 =tmpDic2[@"products"][0];
            model.goods_id = tmpDic2[@"goods_id"];
            model.product_id = tmpDic2[@"product_id"];
            model.store = tmpDic2[@"store"];
            model.name = tmpDic2[@"name"];
            model.thumbnail = tmpDic2[@"thumbnail"];
            [arrM addObject:model];
        }
        
    }
    return arrM;
}


//未支付的订单的数据返回方式
+ (NSMutableArray *)allProductWithDict:(NSDictionary *)dict{
    NSMutableArray *arrM = [[NSMutableArray alloc]init];
    for (NSString *key in dict) {
        NSDictionary *tmpDic = dict[key];
        tmpDic = tmpDic[@"product"];
        ProductModel *model = [[ProductModel alloc]init];
        [model setValuesForKeysWithDictionary:tmpDic];
        [arrM addObject:model];
    }
    return arrM;
}


@end
