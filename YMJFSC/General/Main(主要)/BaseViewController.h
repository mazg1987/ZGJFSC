//
//  BaseViewController.h
//  YMJFSC
//
//  Created by mazg on 16/1/8.
//  Copyright © 2016年 mazg. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

@property (nonatomic,assign)int logo_status;

//这样写有问题，每次页面显示的时候都会加载请求，会比较浪费网络资源
//- (void)loadRequest;

@property (nonatomic,strong) NSMutableArray *dataList;

@end
