//
//  UserModel.h
//  YMJFSC
//
//  Created by mazg on 16/1/11.
//  Copyright © 2016年 mazg. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef enum {
    UN_Logo,  // 0 未登陆
    Logo      // 1 登陆
}LogoStatus;

@interface UserModel : NSObject

+(void)setUserName:(NSString *)userName;
+(void)setPassWord:(NSString *)passWord;
+(void)setLogoStatus:(LogoStatus)logoStatus;
+(NSString *)userName;
+(NSString *)passWord;
+(LogoStatus)logoStatus;

@property (nonatomic,strong)NSString *advance;
@property (nonatomic,strong)NSString *email;
@property (nonatomic,strong)NSString *last_login_jd;
@property (nonatomic,strong)NSString *last_login_tmall;
@property (nonatomic,strong)NSString *levelname;  //会员等级
@property (nonatomic,strong)NSString *login_cj;
@property (nonatomic,strong)NSString *lv_logo;
@property (nonatomic,strong)NSString *member_cur;
@property (nonatomic,strong)NSString *member_id;  //会员id
@property (nonatomic,strong)NSString *member_lv;
@property (nonatomic,strong)NSString *name;   //会员昵称
@property (nonatomic,strong)NSString *point;
@property (nonatomic,strong)NSString *sex;
@property (nonatomic,strong)NSString *uname;  //登录名
@property (nonatomic,strong)NSString *usage_point; //可以使用的积分

+ (instancetype)userWithDict:(NSDictionary *)dict;

@end
