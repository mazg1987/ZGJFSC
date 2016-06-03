//
//  BaseTabController.m
//  YMJFSC
//
//  Created by mazg on 16/1/8.
//  Copyright © 2016年 mazg. All rights reserved.
//

#import "BaseTabController.h"
#import "HomeViewController.h"
#import "ShoppingViewController.h"
#import "OrderViewController.h"
#import "PersonCenterViewController.h"
#import "BaseNaviController.h"
#import "AFNetworkReachabilityManager.h"

@interface BaseTabController ()

@end

@implementation BaseTabController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setMyViewControllers];
    
//    修改背景色
//    self.tabBar.barTintColor = [UIColor redColor];
    
    

    //网络监测
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusNotReachable:
                [MBProgressHUD showMessage:@"您已断网，请检查网络连接情况" toView:self.view afterDelty:1.5];
                break;
            case AFNetworkReachabilityStatusUnknown:
                [MBProgressHUD showMessage:@"您已断网，请检查网络连接情况" toView:self.view afterDelty:1.5];
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                [MBProgressHUD showMessage:@"您现在使用的是蜂窝数据" toView:self.view afterDelty:1.5];
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                
                break;
                
            default:
                break;
        }
    }];
    [manager startMonitoring];
}

-(void)setMyViewControllers{
/**
     HomeViewController *homeVC = [[HomeViewController alloc]init];
     BaseNaviController *homeNavi = [[UINavigationController alloc]initWithRootViewController:homeVC];
     
     ShoppingViewController *shopVC = [[ShoppingViewController alloc]init];
     BaseNaviController *shopNavi = [[UINavigationController alloc]initWithRootViewController:shopVC];
     
     OrderViewController *orderVC = [[OrderViewController alloc]init];
     BaseNaviController *orderNavi = [[UINavigationController alloc]initWithRootViewController:orderVC];
     
     PersonCenterViewController *personVC = [[PersonCenterViewController alloc]init];
     BaseNaviController *personNavi = [[UINavigationController alloc]initWithRootViewController:personVC];
     
     self.viewControllers = @[homeNavi,shopNavi,orderNavi,personNavi];
 */
   
    
    BaseNaviController *homeNavi = [self naviWithClass:[HomeViewController class] title:@"首页" normalImage:@"Home" selImage:@"Home 0"];
    BaseNaviController *shopNavi = [self naviWithClass:[ShoppingViewController class] title:@"购物车" normalImage:@"shopping cart" selImage:@"shopping cart 0"];
    BaseNaviController *orderNavi = [self naviWithClass:[OrderViewController class] title:@"订单" normalImage:@"Order form" selImage:@"Order form 0"];
    BaseNaviController *personNavi = [self naviWithClass:[PersonCenterViewController class] title:@"个人中心" normalImage:@"Personal Center" selImage:@"Personal Center 0"];
    self.viewControllers = @[homeNavi,shopNavi,orderNavi,personNavi];
}


-(BaseNaviController *)naviWithClass:(Class)className title:(NSString *)title normalImage:(NSString *)normalImage selImage:(NSString *)selImage{
    UIViewController *vc = [[className alloc]init];
    vc.title=title;
    vc.tabBarItem.image = [ImageNamed(normalImage) imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc.tabBarItem.selectedImage = [ImageNamed(selImage) imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    BaseNaviController *navi = [[BaseNaviController alloc]initWithRootViewController:vc];
    return navi;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
