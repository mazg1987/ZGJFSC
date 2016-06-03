//
//  AddressModel.m
//  YMJFSC
//
//  Created by mazg on 16/1/13.
//  Copyright © 2016年 mazg. All rights reserved.
//

#import "AddressModel.h"

@implementation AddressModel

-(instancetype)initWithDict:(NSDictionary *)dict{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
        
        NSArray *componentArr = [self.area componentsSeparatedByString:@"/"];
        NSRange range = [componentArr[0] rangeOfString:@":"];
        self.province =[componentArr[0] substringFromIndex:range.location+1];
        self.city = componentArr[1];
        range = [componentArr[2] rangeOfString:@":"];
        self.town = [componentArr[2] substringToIndex:range.location];
    }
    return self;
}


-(instancetype)initWithOrderDict:(NSDictionary *)dict{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}


@end
