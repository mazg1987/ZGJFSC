//
//  ValidateHelper.h
//  MommySecure
//
//  Created by ShinSoft on 14-6-26.
//  Copyright (c) 2014年 shinsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ValidateHelper : NSObject

//邮箱
+ (BOOL) validateEmail:(NSString *)email;
//手机号码验证
+ (BOOL) validateMobile1:(NSString *)mobile;
//车牌号验证
+ (BOOL) validateCarNo:(NSString *)carNo;
//车型
+ (BOOL) validateCarType:(NSString *)CarType;
//用户名
+ (BOOL) validateUserName:(NSString *)name;
//密码
+ (BOOL) validatePassword:(NSString *)passWord;
//昵称
+ (BOOL) validateNickname:(NSString *)nickname;
//身份证号
+ (BOOL) validateIdentityCardLength: (NSString *)identityCard;
/**
 * 功能:验证身份证是否合法
 * 参数:输入的身份证号
 */

+ (BOOL) validateIdentityCard:(NSString *) sPaperId;
//手机号码验证
+ (BOOL)validateMobile:(NSString *)mobileNum;

@end
