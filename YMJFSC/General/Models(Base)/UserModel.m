//
//  UserModel.m
//  YMJFSC
//
//  Created by mazg on 16/1/11.
//  Copyright © 2016年 mazg. All rights reserved.
//

#import "UserModel.h"
#import "NSString+Hash.h"
#import "ResponseObject.h"

#define EncryptKey @"12345678"

@implementation UserModel

+(void)setUserName:(NSString *)userName{
    NSData *data = [NSString AES256Encrypt:userName withKey:EncryptKey];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:data forKey:@"userName"];
}

+(void)setPassWord:(NSString *)passWord{
    NSData *data = [NSString AES256Encrypt:passWord withKey:EncryptKey];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:data forKey:@"passWord"];
}

+(void)setLogoStatus:(LogoStatus)logoStatus{
    NSData *data = [NSString AES256Encrypt:[NSString stringWithFormat:@"%i",logoStatus] withKey:EncryptKey];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:data forKey:@"logoStatus"];
}

+(NSString *)userName{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [defaults objectForKey:@"userName"];
    return [NSString AES256Decrypt:data withKey:EncryptKey];
}

+(NSString *)passWord{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [defaults objectForKey:@"passWord"];
    return [NSString AES256Decrypt:data withKey:EncryptKey];
}

+(LogoStatus)logoStatus{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [defaults objectForKey:@"logoStatus"];
    return (LogoStatus)[[NSString AES256Decrypt:data withKey:EncryptKey] integerValue];
}

- (instancetype)initWithDict:(NSDictionary *)dict{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)userWithDict:(NSDictionary *)dict{
    ResponseObject *obj = [[ResponseObject alloc]initWithDict:dict];
    UserModel *model;
    if ([obj.code integerValue]==0) {
        NSDictionary *contentDic = dict[@"data"];
        if (contentDic == nil) {
            return nil;
        }
        model = [[self alloc]initWithDict:contentDic];
    }
    return model;
}


- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    NSLog(@"使用了未定义的key%@",key);
}

@end
