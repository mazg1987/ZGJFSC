//
//  ResponseObject.h
//  YMJFSC
//
//  Created by mazg on 16/1/11.
//  Copyright © 2016年 mazg. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ResponseObject : NSObject

@property (nonatomic,strong)NSString *code;
@property (nonatomic,strong)NSString *data;
@property (nonatomic,strong)NSString *message;

- (instancetype)initWithDict:(NSDictionary *)dict;

@end
