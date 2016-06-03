//
//  GoodModel.h
//  YMJFSC
//
//  Created by mazg on 16/1/11.
//  Copyright © 2016年 mazg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"

@interface GoodModel : BaseModel

@property (nonatomic,strong) NSString *goods_id;
@property (nonatomic,strong) NSString *image_default_id;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *price;
@property (nonatomic,strong) NSString *product_id;
@property (nonatomic,strong) NSString *proprice;
@property (nonatomic,strong) NSString *src;
@property (nonatomic,strong) NSString *store;  //库存

@property (nonatomic,strong) NSDictionary *brand;
@property (nonatomic,strong) NSArray *images; //scrollView滚动图片
@property (nonatomic,strong) NSArray *infosrc; //介绍图片
@property (nonatomic,strong) NSString *intro; // 商品介绍  可以直接加载webview实现
@property (nonatomic,strong) NSDictionary *promotion; //促销
@property (nonatomic,strong) NSString *title;// 商品名称
@property (nonatomic,strong) NSString *type_name;//通用商品类型

+ (GoodModel *)goodWithDict:(NSDictionary *)dict;

@end
