//
//  ColorMapping.h
//  XLProjectDemo
//
//  Created by Shinsoft on 15/6/17.
//  Copyright (c) 2015年 Shinsoft. All rights reserved.
//


#ifndef XL_ColorMapping_h
#define XL_ColorMapping_h

>1-1 未登陆情况下购物车页面的完善
//导航栏地址按钮
//下拉刷新
//全选按钮
//结算按钮

>1-2 购物车结算中提交订单
//这里由于服务器接口问题，无论购物车选择多少商品，都默认全部提交购物车
//结算时原来的的积分计算有问题，做了修改

>1-3 购物车列表数据刷新的完善
//在添加商品至购物车的时候或者购物车提交订单完成的时候，购物车数据会发生改变
//当购物车数据发生改变的时候需要自动刷新购物车列表,而不是下拉刷新
//使用了全局变量处理该问题

>1-4 订单页面
//订单列表  自定义未支付、已支付按钮  订单model建立
//headView和footView的自定义
//下拉刷新
//取消订单(接口有问题)
//订单支付(后台未开发)

>1-5 网络状态的监测
//AFNetworking

>1-6 Icon和LaunchImage的添加
//Icon命名规则
//Icon-58   58*58
//Icon-87   87*87
//Icon-80   80*80
//Icon-120  120*120
//Icon-180  180*180


//LaunchImage命名规则
//Default@2x.png         支持iPhone3和4       640*960
//Default-568h@2x.png    支持ipone5系列       640x1136
//Default-667h@2x.png    支持iPhone6         750x1334
//Default-736h@3x.png    支持iPhone6p        1242x2208

#endif
