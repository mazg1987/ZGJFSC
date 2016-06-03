//
//  ShoppingViewController.m
//  YMJFSC
//
//  Created by mazg on 16/1/8.
//  Copyright © 2016年 mazg. All rights reserved.
//

#import "ShoppingViewController.h"
#import "ShoppingCell.h"
#import "ShoppingModel.h"
#import "ProductModel.h"
#import "MJRefreshStateHeader.h"
#import "ResponseObject.h"
#import "AdressViewController.h"
#import "PayViewController.h"


BOOL needReloadShoppingList = NO;
static NSString *identifier = @"cell";

@interface ShoppingViewController ()<UITableViewDataSource,UITableViewDelegate,ShoppingCellDelegate>{
    ShoppingModel *contentModel;
    MJRefreshHeader *header;
    NSMutableArray *selToSumbitList;
    NSString *md5_CardInfo;
    
    //结算商品信息
    ShoppingModel *balanaceModel;
}
@property (weak, nonatomic) IBOutlet UIButton *selAllBtn;
- (IBAction)selAllAction:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *sumPointLabel;
- (IBAction)submitAction:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ShoppingViewController

#pragma mark 添加监看
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        [self addObserver:self forKeyPath:@"logo_status" options:NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew context:nil];
    }
    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    if (![change[@"new"] isEqual:change[@"old"]]) {
        if ([change[@"new"] integerValue] == 1) {
            DLog(@"加载购物车");
            [self loadShoppingListData];
        }
        else{
            DLog(@"清除购物车");
            contentModel = nil;
            [self.tableView reloadData];
        }
    }
}

- (void)dealloc{
    [self removeObserver:self forKeyPath:@"logo_status"];
}

#pragma mark 下拉刷新
- (void)addRefresh{
    header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        DLog(@"刷新");
        if ([UserModel logoStatus] ==0) {
            [MBProgressHUD showMessage:@"请先登陆" toView:self.view afterDelty:1.0];
            [header endRefreshing];
            return;
        }
        [self loadShoppingListData];
    }];
    self.tableView.mj_header = header;
}

#pragma mark ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:@"ShoppingCell" bundle:nil] forCellReuseIdentifier:identifier];
    //添加下拉刷新
    [self addRefresh];
    //初始化数组
    selToSumbitList = [[NSMutableArray alloc]init];
    //添加导航栏右侧按钮
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithTitle:@"地址列表" style:UIBarButtonItemStylePlain target:self action:@selector(toAdress:)];
    self.navigationItem.rightBarButtonItem = rightItem;
}

//跳转地址页面
- (void)toAdress:(UIBarButtonItem *)item{
    if ([UserModel logoStatus] ==0) {
        [MBProgressHUD showMessage:@"请先登陆" toView:self.view afterDelty:1.0];
        return;
    }
    AdressViewController *addressVC = [[AdressViewController alloc]init];
    addressVC.title = @"地址列表";
    [self.navigationController pushViewController:addressVC animated:YES];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (self.logo_status == 0) {
        [MBProgressHUD showMessage:@"请先登录" toView:self.view afterDelty:1.0];
        return;
    }
    if (needReloadShoppingList == YES) {
        [self loadShoppingListData];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark 请求相关
//加载购物车请求
- (void)loadShoppingListData{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [HttpRequest httpRequestGET:Request_Method_apicarthtml parameters:nil progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject,ResponseObject *obj) {
        [MBProgressHUD hideHUDForView:self.view];
        //设置数据
        contentModel = [ShoppingModel shoppingWithDict:responseObject];
        [header endRefreshing];
        [self.tableView reloadData];
        _sumPointLabel.text = [NSString stringWithFormat:@"%@",contentModel.subtotal];
        
        //清空所有选中数据
        [selToSumbitList removeAllObjects];
        _selAllBtn.selected = NO;
        
        //设置是否需要刷新购物车列表为NO
        needReloadShoppingList = NO;
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [header endRefreshing];
    } responseSerializer:[AFJSONResponseSerializer serializer]
     toView:self.view];
}

//选中所有商品结算
- (IBAction)selAllAction:(id)sender {
    if ([UserModel logoStatus] ==0) {
        [MBProgressHUD showMessage:@"请先登陆" toView:self.view afterDelty:1.0];
        return;
    }
    
    UIButton *btn = sender;
    btn.selected = !btn.selected;
    //如果全选状态，则选中所有数据
    if (btn.selected == YES) {
        for (ProductModel *tmpModel in contentModel.goods) {
            if (![selToSumbitList containsObject:tmpModel]) {
                [selToSumbitList addObject:tmpModel];
            }
        }
    }
    else{
        [selToSumbitList removeAllObjects];
    }
    //刷新tableview
    [self.tableView reloadData];
}

//提交结算(验证购物车)
- (IBAction)submitAction:(id)sender {
    if ([UserModel logoStatus] ==0) {
        [MBProgressHUD showMessage:@"请先登陆" toView:self.view afterDelty:1.0];
        return;
    }
    
    if (selToSumbitList.count == 0) {
        [MBProgressHUD showMessage:@"未选择商品" toView:self.view afterDelty:1.0];
        return;
    }
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    //网络请求
    [HttpRequest httpRequestGET:Request_Method_checkout parameters:nil progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject,ResponseObject *obj) {
        DLog(@"%@",responseObject);
        balanaceModel = [ShoppingModel shoppingWithDict:responseObject];
        //如果结算地址不存在
        if (!balanaceModel.addressModel) {
            [MBProgressHUD showMessage:@"请添加收获地址" toView:self.view afterDelty:1.0];
            return ;
        }
        //跳转至支付页面
        PayViewController *payVC = [[PayViewController alloc]init];
        payVC.payModel = balanaceModel;
        payVC.payGoodList = selToSumbitList;
        [self.navigationController pushViewController:payVC animated:YES];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    } responseSerializer:[AFJSONResponseSerializer serializer]
     toView:self.view];
}


#pragma mark UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return contentModel.goods.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ShoppingCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.delegate = self;
    NSArray *arr = contentModel.goods;
    ProductModel *model = arr[indexPath.row];
    cell.proModel = model;
    if ([selToSumbitList containsObject:model]) {
        [cell.selBtn setBackgroundImage:ImageNamed(@"selected") forState:UIControlStateNormal];
    }
    else{
        [cell.selBtn setBackgroundImage:ImageNamed(@"Unselected") forState:UIControlStateNormal];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

//删除购物车指定数据
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    ProductModel *selModel = contentModel.goods[indexPath.row];
    NSMutableDictionary *paramters = [NSMutableDictionary dictionary];
    paramters[@"goods_id"] = selModel.goods_id;
    paramters[@"product_id"] = selModel.product_id;
    
    //这里请求，当删到没有数据的时候，服务器会返回不正常的数据，不是代码问题
    [HttpRequest httpRequestGET:Request_Method_removegoods parameters:paramters progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject,ResponseObject *obj) {
        //设置数据
        contentModel = [ShoppingModel shoppingWithDict:responseObject];
        [self.tableView reloadData];
        _sumPointLabel.text = [NSString stringWithFormat:@"%@",contentModel.subtotal];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
    } responseSerializer:[AFJSONResponseSerializer serializer]
     toView:self.view];
}

//选中cell数据
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ProductModel *tmpModel = contentModel.goods[indexPath.row];
    ShoppingCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if ([selToSumbitList containsObject:tmpModel]) {
        [selToSumbitList removeObject:tmpModel];
        [cell.selBtn setBackgroundImage:ImageNamed(@"Unselected") forState:UIControlStateNormal];
        _selAllBtn.selected = NO;
    }
    else{
        [selToSumbitList addObject:tmpModel];
        [cell.selBtn setBackgroundImage:ImageNamed(@"selected") forState:UIControlStateNormal];
    }
    
    
//    == 判断的是指针，两个对象的地址当然不相等isEqualTo判断的是内容
//    isEqualTo实现过程:
//    1、首先都会判断 指针是否相等 ，相等直接返回YES，
//    2、不相等再判断是否是同类对象或非空，空或非同类对象直接返回NO，
//    3、而后依次判断对象的内容是否相等，若均相等，返回YES
//    4、这里isEqualToArray:方法判断数组是否一样仍然不行，因为数组内容顺序可能不一样
//    if ([selToSumbitList isEqualToArray:contentModel.goods]) {
//        DLog(@"两个数组一样");
//        self.selAllBtn.selected = YES;
//    }
    
    
    //这里面只需要判断数组长度是否一致就可以知道两个数组是否包含相同的元素了
    if (selToSumbitList.count == contentModel.goods.count) {
        self.selAllBtn.selected = YES;
    }
}

#pragma mark ShoppingCellDelegate
- (void)passValueWithDictionary:(NSDictionary *)dict{
    contentModel = [ShoppingModel shoppingWithDict:dict];
    [self.tableView reloadData];
    _sumPointLabel.text = [NSString stringWithFormat:@"%@",contentModel.subtotal];
}

@end
