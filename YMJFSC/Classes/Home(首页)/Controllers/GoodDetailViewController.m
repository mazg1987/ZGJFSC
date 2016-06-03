//
//  GoodDetailViewController.m
//  YMJFSC
//
//  Created by mazg on 16/1/12.
//  Copyright © 2016年 mazg. All rights reserved.
//

#import "GoodDetailViewController.h"
#import "MZScrollView.h"
#import "ResponseObject.h"

//全局变量，用于处理购物车列表是否需要刷新
extern BOOL needReloadShoppingList;

@interface GoodDetailViewController (){
    GoodModel *contentModel; //展示页面数据的model
}
@property (weak, nonatomic) IBOutlet MZScrollView *scrView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *storeLabel;
@property (weak, nonatomic) IBOutlet UILabel *promoteLabel;
- (IBAction)buyAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation GoodDetailViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.detailModel.name;
    //适配网页
    [self.webView setScalesPageToFit:YES];
    [self loadData];
    
    //指定字体
    _titleLabel.font = k_Font_Big;
    _priceLabel.font = k_Font_Normal;
    _priceLabel.textColor = k_color_normal_red;
    _storeLabel.font = k_Font_Normal;
    _promoteLabel.font = k_Font_Normal;
}


//加载数据
- (void)loadData{
//    Request_Method_goodDetail 字符串中有%@，替换掉这个%@
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSString *path = [NSString stringWithFormat:Request_Method_goodDetail,self.detailModel.goods_id];
    [HttpRequest httpRequestGET:path parameters:nil progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject,ResponseObject *obj) {
        NSLog(@"%@",responseObject);
        contentModel = [GoodModel goodWithDict:responseObject];
        //加载scrollView数据
        [self loadScrViewData];
        //显示页面数据
        [self loadCurrentViewData];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {

    } responseSerializer:[AFJSONResponseSerializer serializer]
     toView:self.view];
}

- (void)loadScrViewData{
    self.scrView.imgData = contentModel.images;
}

- (void)loadCurrentViewData{
    self.titleLabel.text = contentModel.title;
    self.priceLabel.text = contentModel.price;
    self.storeLabel.text = [NSString stringWithFormat:@"%@",contentModel.store];
    NSDictionary *tmpDict = contentModel.promotion;
    tmpDict = tmpDict[@"order"];
    tmpDict = tmpDict[@"24"];
    self.promoteLabel.text = tmpDict[@"name"];
    
    //加载HTML网页
    [self.webView loadHTMLString:contentModel.intro baseURL:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)buyAction:(id)sender {
    DLog(@"加入购物车");
    
    if ([UserModel logoStatus] == 0) {
        [MBProgressHUD showMessage:@"登录后方可添加购物车" toView:self.view afterDelty:1.0];
        return;
    }
    
    if ([_detailModel.store integerValue]==0) {
        [MBProgressHUD showMessage:@"库存为空，不能添加购物车" toView:self.view afterDelty:1.0];
        return;
    }
    
    NSMutableDictionary *paramters = [NSMutableDictionary dictionary];
    paramters[@"goods_id"] = _detailModel.goods_id;
    paramters[@"product_id"] = _detailModel.product_id;
    paramters[@"num"] = @1;
    [HttpRequest httpRequestGET:Request_Method_addShopping parameters:paramters progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject,ResponseObject *obj) {
        needReloadShoppingList = YES;
        //提示添加购物车成功
        [MBProgressHUD showMessage:obj.message toView:self.view afterDelty:1.0];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {

    } responseSerializer:[AFJSONResponseSerializer serializer]
     toView:self.view];
}
@end
