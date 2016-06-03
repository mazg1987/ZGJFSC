//
//  RequestDefine.h
//  Hospital
//
//  Created by ShinSoft on 14-3-10.
//  Copyright (c) 2014年 Shinsoft. All rights reserved.
//

#ifndef XL_RequestDefine_h
#define XL_RequestDefine_h

/**
 *  定义网络请求相关常量
 命名规则为：Request_Method_方法名
 字段命名采用驼峰表示(首字母大写)
 */

//***************相关参数*************************************

#define REQUEST_GET     @"GET"
#define REQUEST_POST    @"POST"
#define REQUEST_PUT     @"PUT"
#define REQUEST_DELETE  @"DELETE"

#define isTestHJ  1
#if isTestHJ//1:测试环境  0：正式环境
#define K_IP                    @"http://121.41.32.61:85/"//外网--测试环境
#define K_SERVICE       [NSString stringWithFormat:@"http://%@",K_IP]//
#else
#define K_IP                    @"www.e-conference.cn"//正式测试环境
#define K_SERVICE       [NSString stringWithFormat:@"http://%@",K_IP]//
#endif


#define Request_Method_Login                          @"openapi/pam_callback/login/module/pam_passport_basic/type/member/appid/b2c/redirect/L2FwaXBhc3Nwb3J0LXBvc3RfbG9naW4tYUhSMGNEb3ZMekV5Tnk0d0xqQXVNVG80T1M5M1lYQXZhVzVrWlhndWFIUnRiQT09Lmh0bWw="//登录
#define Request_Method_CancelLogin                    @"apipassport-logout.html"  //注销登录
#define Request_Method_getsmscode                     @"apipassport-getsmscode.html"//获取验证码
#define Request_Method_checkverify                    @"apipassport-checkverify.html"//验证验证码
#define Request_Method_create                         @"apipassport-create.html"//注册apimember.html[GET]

#define Request_Method_apimember                      @"apimember.html"//会员信息


#define Request_Method_BandLogosHtml                  @"apicommon-bandlogos.html"//首页品牌列表
#define Request_Method_indexRecommon                  @"apicommon-recommends.html"//首页推荐
#define Request_Method_brandGoods                     @"apibrand-brandGoods.html"//品牌商品列表
#define Request_Method_goodDetail                     @"apiproduct-%@.html"//商品详情
#define Request_Method_addShopping                    @"apicart-add-goods.html"//加入购物车
#define Request_Method_apicarthtml                    @"apicart.html"//购物车列表
#define Request_Method_update_goods                   @"apicart-update-goods.html"//修改购物车数量
#define Request_Method_removegoods                    @"apicart-remove-goods.html"//删除购物车
#define Request_Method_checkout                       @"apicart-checkout.html"//购物车结算
#define Request_Method_shippinglist                   @"apicart-shippinglist.html"//地址列表
#define Request_Method_shippingsave                   @"apicart-shippingsave.html"//保存地址
#define Request_Method_shippingdeleteHtml             @"apicart-shippingdelete.html"//删除地址
#define Request_Method_createHtml                     @"apiorder-create.html"//提交订单
#define Request_Method_orders                         @"apimember-orders.html"//订单列表
#define Request_Method_Cancelorders                   @"apipassport-cancelorder-%@.html"//取消订单



#endif
