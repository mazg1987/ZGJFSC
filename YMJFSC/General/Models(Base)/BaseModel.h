//
//  BaseModel.h
//  YMJFSC
//
//  Created by mazg on 16/1/11.
//  Copyright © 2016年 mazg. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseModel : NSObject

-(instancetype)initWithDict:(NSDictionary *)dict;

+(NSMutableArray *)allModelsWithDictionary:(NSDictionary *)dict;

@end
