//
//  AdressViewController.m
//  YMJFSC
//
//  Created by mazg on 16/1/13.
//  Copyright © 2016年 mazg. All rights reserved.
//

#import "AdressViewController.h"
#import "AddressCell.h"
#import "AddressModel.h"
#import "EditViewController.h"
#import "ShoppingViewController.h"

static NSString *identifier = @"cell";

@interface AdressViewController ()<UITableViewDataSource,UITableViewDelegate>{
    MJRefreshNormalHeader *header;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation AdressViewController

#pragma mark ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //注册可以复用的cell
    [self.tableView registerNib:[UINib nibWithNibName:@"AddressCell" bundle:nil] forCellReuseIdentifier:identifier];
    
    //下拉刷新
    header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        DLog(@"开始刷新");
        [self loadAddressListRequest];
    }];
    self.tableView.mj_header = header;
    
    //加载网络请求
    [self loadAddressListRequest];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark 请求
//地址列表请求
- (void)loadAddressListRequest{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [HttpRequest httpRequestGET:Request_Method_shippinglist parameters:nil progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        DLog(@"%@",responseObject);
        [header endRefreshing];
        self.dataList = [AddressModel allModelsWithDictionary:responseObject];
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [header endRefreshing];
    } responseSerializer:[AFJSONResponseSerializer serializer] toView:self.view];
}


#pragma mark UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AddressCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    cell.model = self.dataList[indexPath.row];
    
    NSInteger count = self.navigationController.viewControllers.count;
    if ([self.navigationController.viewControllers[count-2] isKindOfClass:[ShoppingViewController class]]) {
        cell.selStatuView.hidden = YES;
    }
    else{
        cell.selStatuView.hidden = NO;
    }
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]init];
    UIButton *btn = [[UIButton alloc]init];
    btn.frame = CGRectMake(0, 0, 100, 40);
    btn.center = CGPointMake(kScreenWidth/2.0, 20);
    btn.titleLabel.font = k_Font_Normal;
    [btn setTitle:@"新增地址" forState:UIControlStateNormal];
    [btn setTitleColor:k_color_NaviBarColor forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(addNewAddress:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btn];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 50;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
//删除地址
    AddressModel *model = self.dataList[indexPath.row];
    
    //删除地址请求
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"addr_id"] = model.addr_id;
    [HttpRequest httpRequestGET:Request_Method_shippingdeleteHtml parameters:parameters progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        //删除成功
        //先移除数据源 ,再移除tableview的cell
        [self.dataList removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationBottom];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",error);
    } responseSerializer:[AFJSONResponseSerializer serializer] toView:self.view];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger count = self.navigationController.viewControllers.count;
    if ([self.navigationController.viewControllers[count-2] isKindOfClass:[ShoppingViewController class]]) {
        return;
    }
    else{
        //往上一个页面传递数据
        AddressModel *selAddressModel = self.dataList[indexPath.row];
        if (self.delegate) {
            [self.delegate passSelAddress:selAddressModel];
            [self.navigationController popViewControllerAnimated:YES];
        }
        DLog(@"选中处理");
    }
}

//footView按钮 新增地址点击事件
- (void)addNewAddress:(UIButton *)btn{
    DLog(@"添加新地址");
    EditViewController *editVC = [[EditViewController alloc]init];
    editVC.title = @"新增地址";
    [self.navigationController pushViewController:editVC animated:YES];
}

//cell编辑按钮 点击事件
- (void)editAction:(id)sender {
    DLog(@"cell点击事件");
    //获取sender对应的cell
    UITableViewCell *cell = (UITableViewCell *)[[sender superview] superview];
    NSIndexPath *path = [self.tableView indexPathForCell:cell];
    //传递数据
    EditViewController *editVC = [[EditViewController alloc]init];
    editVC.title = @"修改地址";
    editVC.model = self.dataList[path.row];
    [self.navigationController pushViewController:editVC animated:YES];
}

@end
