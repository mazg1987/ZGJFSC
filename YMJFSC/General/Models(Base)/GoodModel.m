//
//  GoodModel.m
//  YMJFSC
//
//  Created by mazg on 16/1/11.
//  Copyright © 2016年 mazg. All rights reserved.
//

#import "GoodModel.h"
#import "ResponseObject.h"

@implementation GoodModel

+ (GoodModel *)goodWithDict:(NSDictionary *)dict{
    ResponseObject *obj = [[ResponseObject alloc]initWithDict:dict];
    GoodModel *model;
    if ([obj.code integerValue] == 0) {
        NSDictionary *contentDic = dict[@"data"];
        if (contentDic == nil) {
            return nil;
        }
        model = [[self alloc]initWithDict:contentDic];
    }
    return model;
}

@end
