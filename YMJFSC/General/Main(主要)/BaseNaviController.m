//
//  BaseNaviController.m
//  YMJFSC
//
//  Created by mazg on 16/1/8.
//  Copyright © 2016年 mazg. All rights reserved.
//

#import "BaseNaviController.h"

@interface BaseNaviController ()

@end

@implementation BaseNaviController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

+ (void)initialize{
    //设置导航栏颜色
    [self setBarAppearance];
    //设置barItem颜色
    [self setBarItemAppearance];
}

+ (void)setBarAppearance{
    UINavigationBar *bar = [UINavigationBar appearance];
    bar.tintColor = [UIColor whiteColor];
    if (iOS8_OR_LATER) {
        bar.translucent = NO;
    }
    bar.barTintColor = k_color_NaviBarColor;
    //导航栏标题字体
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = NaviTitleFont;
    attrs[NSForegroundColorAttributeName] = k_color_white;
    [bar setTitleTextAttributes:attrs];
}


+ (void)setBarItemAppearance{
    //导航栏按钮主题
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = NaviItemFont;
    attrs[NSForegroundColorAttributeName] = k_color_white;
    [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
}


- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

@end
