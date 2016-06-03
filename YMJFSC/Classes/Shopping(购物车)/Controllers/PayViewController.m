//
//  PayViewController.m
//  YMJFSC
//
//  Created by mazg on 16/1/13.
//  Copyright © 2016年 mazg. All rights reserved.
//

#import "PayViewController.h"
#import "AddressModel.h"
#import "RecommonCell.h"
#import "AdressViewController.h"

//全局变量，用于处理购物车列表是否需要刷新
extern BOOL needReloadShoppingList;
static NSString *identifier = @"cell";

@interface PayViewController ()<UITableViewDataSource,UITableViewDelegate,AddressViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
- (IBAction)otherAddressAction:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *pointLabel;

//选中的要结算的地址
@property (nonatomic,strong) AddressModel *selAddressModel;
- (IBAction)payAction:(id)sender;

@end

@implementation PayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"结算";
    
    //注册cell
    [self.tableView registerNib:[UINib nibWithNibName:@"RecommonCell" bundle:nil] forCellReuseIdentifier:identifier];
    
    //初始化要结算的地址model信息
    self.selAddressModel = self.payModel.addressModel;
    
    //初始化UI
    [self configUI];
}

- (void)configUI{
    self.addressLabel.text = [NSString stringWithFormat:@"%@/%@/%@/%@\n%@  %@",self.selAddressModel.province,self.selAddressModel.city,self.selAddressModel.town,self.selAddressModel.addr,self.selAddressModel.name,self.selAddressModel.mobile];
    //这里不使用服务器数据，自己计算
    NSInteger sumPoint = 0;
    for (ProductModel *model in self.payGoodList) {
        sumPoint += [model.subtotal integerValue]*[model.quantity integerValue];
    }
    self.pointLabel.text = [NSString stringWithFormat:@"应支付%li积分",sumPoint];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)otherAddressAction:(id)sender {
    AdressViewController *addressList = [[AdressViewController alloc]init];
    addressList.title = @"选择地址";
    addressList.delegate = self;
    [self.navigationController pushViewController:addressList animated:YES];
}

//结算按钮点击后
//发送结算请求
- (IBAction)payAction:(id)sender {
    NSLog(@"验证码:%@",self.payModel.md5_cart_info);
    NSLog(@"地址id:%@",self.selAddressModel.addr_id);
    //请求
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"md5_cart_info"] = self.payModel.md5_cart_info;
    parameters[@"addr_id"] = self.selAddressModel.addr_id;
    [HttpRequest httpRequestPOST:Request_Method_createHtml parameters:parameters progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        needReloadShoppingList = YES;
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    } responseSerializer:[AFJSONResponseSerializer serializer] toView:self.view];
}

#pragma mark UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.payGoodList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RecommonCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    cell.payModel = self.payGoodList[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

#pragma mark AddressViewControllerDelegate
- (void)passSelAddress:(AddressModel *)model{
    self.selAddressModel = model;
    self.addressLabel.text = [NSString stringWithFormat:@"%@/%@/%@/%@\n%@  %@",self.selAddressModel.province,self.selAddressModel.city,self.selAddressModel.town,self.selAddressModel.addr,self.selAddressModel.name,self.selAddressModel.mobile];
}

@end
