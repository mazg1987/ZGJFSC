//
//  BrandModel.h
//  YMJFSC
//
//  Created by mazg on 16/1/11.
//  Copyright © 2016年 mazg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"

@interface BrandModel : BaseModel

@property (nonatomic,strong)NSString *brand_id;
@property (nonatomic,strong)NSString *brand_logo;
@property (nonatomic,strong)NSString *brand_name;
@property (nonatomic,strong)NSString *src;

@end
