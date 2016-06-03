//
//  FrameDefine.h
//  YMJFSC
//
//  Created by mazg on 16/1/8.
//  Copyright © 2016年 mazg. All rights reserved.
//

#ifndef FrameDefine_h
#define FrameDefine_h

//计算字体高度
#define kLabelSize(value, font, width) [value sizeWithFont:font constrainedToSize:CGSizeMake(width, 100000) lineBreakMode:UILineBreakModeWordWrap];

#pragma mark - 屏幕大小
//屏幕的总高度和宽度.包括状态栏和导航栏
#define kScreenFrame                 [[UIScreen mainScreen] bounds]
#define kScreenWidth                 [UIScreen mainScreen].bounds.size.width
#define kScreenHeight                [UIScreen mainScreen].bounds.size.height


//根据5s计算各代手机对应的尺寸
#define W(x) kScreenWidth*x/320.0
#define H(y) kScreenHeight*y/568.0


// 应用的高度，不包含状态栏,但包含导航栏
#define kAppFrame                    [UIScreen mainScreen].applicationFrame
#define kAppHeight                   kAppFrame.size.height
#define kAppWidth                    kAppFrame.size.width
#define kAppHeightWithoutNav         kAppFrame-44.0f //不包含导航栏的高度

//当前视图宽高,(在UIView中使用)
#define kViewWidth                   self.bounds.size.width
#define kViewHeight                  self.bounds.size.height

//当前ViewController中视图宽高(在ViewController中使用)
#define kCtrlViewWidth               self.view.bounds.size.width
#define kCtrlViewHeight              self.view.bounds.size.height


//当前视图宽高,在viewDidLoad方法中不包含状态栏,但包含导航栏和tabBar,在viewWillAppear方法中状态栏 导航栏 tabBar都不包括
#define CurrentViewWidth  self.bounds.size.width
#define CurrentViewHeight  self.bounds.size.height

#define CurrentCtrlViewWidth  self.view.bounds.size.width
#define CurrentCtrlViewHeight  self.view.bounds.size.height


#define kStatusBarHeight             20.0f
#define kNavBarHeight                44.0f
#define kTabBarHeight                49.0f


//设置A相对B下方某位置
#define setYWithAboveView(mView,interval,aboveView) mView.frame = CGRectMake(aboveView.frame.origin.x, aboveView.frame.origin.y + aboveView.frame.size.height+interval, mView.frame.size.width, mView.frame.size.height)

//设置A相对B下方某位置(可以指定显示的位置)
#define setXYWithAboveView(mView,intervalX,intervalY,aboveView) mView.frame = CGRectMake(aboveView.frame.origin.x+intervalX, aboveView.frame.origin.y + aboveView.frame.size.height + intervalY, mView.frame.size.width, mView.frame.size.height)

//设置A相对B水平左边某位置
#define setXWithLeftView(mView,interval,leftView) mView.frame = CGRectMake(leftView.frame.origin.x + leftView.frame.size.width + interval, leftView.frame.origin.y, mView.frame.size.width, mView.frame.size.height)

//设置A相对B左边水平和垂直位置
#define setXYWithLeftView(mView,intervalX,intervalY,leftView) mView.frame = CGRectMake((leftView.frame.origin.x+leftView.frame.size.width+intervalX), (leftView.frame.origin.y+intervalY), mView.frame.size.width, mView.frame.size.height)

//设置A相对B水平右边某位置
#define setXWithRightView(mView,interval,rightView) mView.frame = CGRectMake(rightView.frame.origin.x - mView.frame.size.width - interval, rightView.frame.origin.y, mView.frame.size.width, mView.frame.size.height)


//设置A相对B右边水平和垂直位置
#define setXYWithRightView(mView,intervalX,intervalY,rightView) mView.frame = CGRectMake((rightView.frame.origin.x - mView.frame.size.width - intervalX), (rightView.frame.origin.y+intervalY), mView.frame.size.width, mView.frame.size.height)


//重新设定view的Y值
#define setFrameY(view, newY) view.frame = CGRectMake(view.frame.origin.x, newY, view.frame.size.width, view.frame.size.height)
//重新设定view的X值
#define setFrameX(view, newX) view.frame = CGRectMake(newX, view.frame.origin.y, view.frame.size.width, view.frame.size.height)
//重新设定view的Width值
#define setFrameH(view, newH) view.frame = CGRectMake(view.frame.origin.x, view.frame.origin.y, view.frame.size.width, newH)
//重新设定view的Height值
#define setFrameW(view, newW) view.frame = CGRectMake(view.frame.origin.x, view.frame.origin.y, newW, view.frame.size.height)


//取view的坐标及长宽
#define WView(view)    view.frame.size.width
#define HView(view)    view.frame.size.height
#define XView(view)    view.frame.origin.x
#define YView(view)    view.frame.origin.y



#endif /* FrameDefine_h */
