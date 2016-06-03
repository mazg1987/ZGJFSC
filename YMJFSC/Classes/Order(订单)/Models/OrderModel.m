//
//  OrderModel.m
//  YMJFSC
//
//  Created by mazg on 16/1/14.
//  Copyright © 2016年 mazg. All rights reserved.
//

#import "OrderModel.h"
#import "ProductModel.h"

@implementation OrderModel

- (instancetype)initWithDict:(NSDictionary *)dict{
    if (self = [super init]) {
        self.createtime = dict[@"createtime"];
        self.order_id = dict[@"order_id"];
        self.addressModel = [[AddressModel alloc]initWithOrderDict:dict[@"consignee"]];
        self.goods_items = [ProductModel allProductWithDict:dict[@"goods_items"]];
    }
    return self;
}

+ (NSMutableArray *)allOrdersWithDictionary:(NSDictionary *)dict{
    ResponseObject *obj = [[ResponseObject alloc]initWithDict:dict];
    if ([obj.code integerValue]!=0) {
        return nil;
    }
    NSMutableArray *arrM = [[NSMutableArray alloc]init];
    NSArray *tmpArr = dict[@"data"];
    for (NSDictionary *tmpDic  in tmpArr) {
        OrderModel *model = [[OrderModel alloc]initWithDict:tmpDic];
        [arrM addObject:model];
    }
    return arrM;
}

@end
