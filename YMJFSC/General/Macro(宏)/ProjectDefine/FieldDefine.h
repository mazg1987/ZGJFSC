//
//  FieldMapping.h
//  Hospital
//
//  Created by Chino Hu on 13-12-16.
//  Copyright (c) 2013年 Shinsoft. All rights reserved.
//

#ifndef XL_FieldMapping_h
#define XL_FieldMapping_h

/**
 *  定义字符串常量
    命名规则为：K_Text_模块名_子模块名_实际字段名
    字段命名采用驼峰表示(首字母大写)
 */


//全局
#define K_Text_App_AlertView_Title                              @"温馨提示"
#define K_Text_App_AlertView_Message                            @"确认拨打021-64858908"

//注册
#define K_Text_App_AlertView_NilTel                              @"输入不能为空"
#define K_Text_App_AlertView_RightTel                            @"请输入正确的手机号"
#define K_Text_App_AlertView_checkCode                           @"验证短信验证码"
#define K_Text_App_AlertView_NilPassword                         @"您还没有输入密码"
#define K_Text_App_AlertView_NilRePassword                       @"请您再次确认密码"
#define K_Text_App_AlertView_RePwdError                          @"您两次输入的密码不一样"

//个人中心
#define K_Text_App_AlertView_NameIsNil                          @"您的昵称不能为空"

//首页模块
#define KText_AlertView_Cancel                                   @"取消"
#define KText_AlertView_Confirm                                  @"确认"

#define K_Text_Progress_Fail                                      @"操作失败!"
#define K_Text_Progress_Success                                   @"操作成功!"

#endif
