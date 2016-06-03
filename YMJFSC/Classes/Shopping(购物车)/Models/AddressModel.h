//
//  AddressModel.h
//  YMJFSC
//
//  Created by mazg on 16/1/13.
//  Copyright © 2016年 mazg. All rights reserved.
//

#import "BaseModel.h"

@interface AddressModel : BaseModel

@property (nonatomic,strong) NSString *addr;    //地址
@property (nonatomic,strong) NSString *addr_id; //地址编号
@property (nonatomic,strong) NSString *area;    //地区
@property (nonatomic,strong) NSString *day;
@property (nonatomic,strong) NSString *def_addr;
@property (nonatomic,strong) NSString *firstname;
@property (nonatomic,strong) NSString *lastname;
@property (nonatomic,strong) NSString *member_id;
@property (nonatomic,strong) NSString *name;    //姓名
@property (nonatomic,strong) NSString *mobile;  //电话
@property (nonatomic,strong) NSString *tel;
@property (nonatomic,strong) NSString *time;
@property (nonatomic,strong) NSString *zip;

@property (nonatomic,strong) NSString *province;
@property (nonatomic,strong) NSString *city;
@property (nonatomic,strong) NSString *town;

//未完成订单列表的初始化方法
-(instancetype)initWithOrderDict:(NSDictionary *)dict;

@end
