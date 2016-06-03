//
//  ColorMapping.h
//  XLProjectDemo
//
//  Created by Shinsoft on 15/6/17.
//  Copyright (c) 2015年 Shinsoft. All rights reserved.
//


#ifndef XL_ColorMapping_h
#define XL_ColorMapping_h


//颜色转换
#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
//清除背景色
#define CLEARCOLOR [UIColor clearColor]
// rgb颜色转换（16进制->10进制）
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

//设置用到的颜色
//*****************************全局颜色*************************
#define k_color_red                         RGBCOLOR(255,42,167)//玫红
#define k_color_dark_red                    RGBCOLOR(191,31,125)//玫红加深
#define k_color_normal_red                  [UIColor redColor]
#define k_color_yellow                      RGBCOLOR(236,115,0)//橙黄
#define k_color_black                       RGBCOLOR(0,0,0)//黑
#define k_color_gray_15                     RGBCOLOR(38,38,38)//15%灰
#define k_color_gray_30                     RGBCOLOR(76,76,76)//30%灰
#define k_color_gray_45                     RGBCOLOR(114,114,114)//45%灰
#define k_color_gray_60                     RGBCOLOR(152,152,152)//60%灰
#define k_color_gray_75                     RGBCOLOR(190,190,190)//75%灰
#define k_color_gray_90                     RGBCOLOR(229,229,229)//90%灰
#define k_color_gray_95                     RGBCOLOR(242,242,242)//95%灰
#define k_color_white                       RGBCOLOR(255,255,255)//白
#define k_color_NaviBarColor                RGBCOLOR(127,196,66)//导航栏的颜色
#define k_color_SecondGrayTitle             RGBCOLOR(102,102,102)//二级菜单
#define k_color_detailClolr                 RGBCOLOR(236,236,236)//附文/时间/作者/没有更多/已读

#define k_color_bottomClolr                 RGBCOLOR(240,240,242)//底部

#endif
