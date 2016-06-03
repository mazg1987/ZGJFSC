//
//  UtilsDefine.h
//  FrameWork-1.0
//
//  Created by shinsoft  on 13-3-27.
//  Copyright (c) 2013年 shinsoft . All rights reserved.
//




#ifndef XL_UtilsDefine_h
#define XL_UtilsDefine_h



// 判断string是否为空 nil 或者 @""；
#define IsNilString(__String) (__String==nil || [__String isEqualToString:@""] || [[__String stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] isEqualToString:@""])

#define nilToBlank(__String) (IsNilString(__String) ? @"-" : __String)



//由角度获取弧度 由弧度获取角度
#define degreesToRadian(x) (M_PI * (x) / 180.0)
#define radianToDegrees(radian) (radian*180.0)/(M_PI)


//----------------------图片----------------------------

//读取本地图片
#define LOADIMAGE(file,ext) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:file ofType:ext]]

//定义UIImage对象
#define IMAGE(A) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:A ofType:nil]]

//定义UIImage对象
#define ImageNamed(_pointer) [UIImage imageNamed:_pointer]

//建议使用前两种宏定义,性能高于后者
//----------------------图片----------------------------


#endif