//
//  BaseModel.m
//  YMJFSC
//
//  Created by mazg on 16/1/11.
//  Copyright © 2016年 mazg. All rights reserved.
//

#import "BaseModel.h"
#import "ResponseObject.h"

@implementation BaseModel

-(instancetype)initWithDict:(NSDictionary *)dict{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    NSLog(@"使用了为定义的key:%@",key);
}


+(NSMutableArray *)allModelsWithDictionary:(NSDictionary *)dict{
    NSMutableArray *arrM = [[NSMutableArray alloc]init];
    ResponseObject *obj = [[ResponseObject alloc]initWithDict:dict];
    if ([obj.code integerValue] == 0) {
        NSArray *contentArr = dict[@"data"];
        if ([contentArr isKindOfClass:[NSArray class]]) {
            if (contentArr.count==0) {
                return nil;
            }
            for (NSDictionary *tmpDic in contentArr) {
                id model = [[self alloc]initWithDict:tmpDic];
                [arrM addObject:model];
            }
        }
    }
    return arrM;
}

@end
