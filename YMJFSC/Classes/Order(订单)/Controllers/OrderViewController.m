//
//  OrderViewController.m
//  YMJFSC
//
//  Created by mazg on 16/1/8.
//  Copyright © 2016年 mazg. All rights reserved.
//

#import "OrderViewController.h"
#import "ButtonView.h"
#import "RecommonCell.h"
#import "OrderModel.h"
#import "FootView.h"
#import "HeadView.h"

static NSString *identifier = @"cell";

@interface OrderViewController ()<UITableViewDataSource,UITableViewDelegate>{
    MJRefreshHeader *header;
}

@property (strong, nonatomic)  ButtonView *btnView1;
@property (strong, nonatomic)  ButtonView *btnView2;
@property (weak, nonatomic) IBOutlet UITableView *tableView;



@end

@implementation OrderViewController

#pragma mark 添加监看
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        [self addObserver:self forKeyPath:@"logo_status" options:NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew context:nil];
    }
    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    if (![change[@"new"] isEqual:change[@"old"]]) {
        //加载数据
        if ([change[@"new"] integerValue]==1) {
            //加载未支付商品列表
            [self loadUnPayProductsList];
        }
        //清除数据
        else{
            self.dataList = nil;
            [self.tableView reloadData];
        }
    }
}

- (void)dealloc{
    [self removeObserver:self forKeyPath:@"logo_status"];
}


#pragma mark UIViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (self.logo_status == 0) {
        [MBProgressHUD showMessage:@"请先登录" toView:self.view afterDelty:1.0];
        return;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //注册cell
    [self.tableView registerNib:[UINib nibWithNibName:@"RecommonCell" bundle:nil] forCellReuseIdentifier:identifier];
    //初始化界面
    [self configUI];
    
    //下拉刷新
    header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        if ([UserModel logoStatus] == 1) {
            if (self.btnView1.selected == YES) {
                [self loadUnPayProductsList];
            }
            else{
                [self loadPayProductsList];
            }
        }
        else{
            [MBProgressHUD showMessage:@"请先登录" toView:self.view afterDelty:1.0];
            [header endRefreshing];
        }
    }];
    self.tableView.mj_header = header;
}

- (void)configUI{
    self.btnView1 = [ButtonView buttonView];
    self.btnView2 = [ButtonView buttonView];
    [self.view addSubview:self.btnView1];
    [self.view addSubview:self.btnView2];
    
    __weak typeof(self) weakSelf = self;
    
    self.btnView1.title = @"未支付";
    self.btnView1.selected = YES;
    self.btnView1.btnBlock = ^(ButtonView *btnView){
        btnView.selected = YES;
        weakSelf.btnView2.selected = NO;
        if ([UserModel logoStatus] == 1) {
            [weakSelf loadUnPayProductsList];
        }
        else{
            [MBProgressHUD showMessage:@"请先登录" toView:weakSelf.view afterDelty:1.0];
        }
    };
    
    self.btnView2.title = @"已支付";
    self.btnView2.selected = NO;
    self.btnView2.btnBlock = ^(ButtonView *btnView){
        weakSelf.btnView1.selected = NO;
        btnView.selected = YES;
        if ([UserModel logoStatus] == 1) {
            [weakSelf loadPayProductsList];
        }
        else{
            [MBProgressHUD showMessage:@"请先登录" toView:weakSelf.view afterDelty:1.0];
        }
    };
}

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    
#define ButtonViewH 50
    self.btnView1.frame = CGRectMake(0, 0, kScreenWidth/2.0,ButtonViewH);
    self.btnView2.frame = CGRectMake(kScreenWidth/2.0, 0, kScreenWidth/2.0,ButtonViewH);
    self.tableView.frame = CGRectMake(0, CGRectGetMaxY(self.btnView1.frame), kScreenWidth, H(400));
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark 请求
//加载未支付商品列表
- (void)loadUnPayProductsList{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [HttpRequest httpRequestGET:Request_Method_orders parameters:nil progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        DLog(@"%@",responseObject);
        [header endRefreshing];
        self.dataList = [OrderModel allOrdersWithDictionary:responseObject];
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        DLog(@"%@",error);
        [header endRefreshing];
    } responseSerializer:[AFJSONResponseSerializer serializer] toView:self.view];
}

//加载支付商品列表
- (void)loadPayProductsList{
    [header endRefreshing];
    self.dataList = nil;
    [self.tableView reloadData];
    [MBProgressHUD showMessage:@"此功能完善中" toView:self.view afterDelty:1.0];
}

#pragma mark UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataList.count;
}

//每个section有多少
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.dataList[section] goods_items].count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RecommonCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    OrderModel *orderModel = self.dataList[indexPath.section];
    cell.orderProductModel = orderModel.goods_items[indexPath.row];
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 80;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (self.btnView1.selected == YES) {
        OrderModel *orderModel = self.dataList[section];
        HeadView *headView = [HeadView headerView];
        headView.orderIDLabel.text = [NSString stringWithFormat:@"订单号:%@",orderModel.order_id];
        headView.orderTimeLabel.text = [NSString stringWithFormat:@"订单时间:%@",[self timeStringWithDate:[orderModel.createtime longLongValue]]];
        headView.cancelOrderBtn.tag = section;
        return headView;
    }
    return nil;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

//如果未支付的订单，在tableView的下方需要有支付按钮
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (self.btnView1.selected == YES) {
        //1、添加几分统计的label
        FootView *foot = [FootView footView];
        int sumScore = 0;
        OrderModel *orderModel = self.dataList[section];
        for (ProductModel *pmodel in orderModel.goods_items) {
            sumScore += [pmodel.score intValue];
        }
        foot.footSumLabel.text = [NSString stringWithFormat:@"应支付%i积分",sumScore];
        return foot;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 80;
}

- (NSString *)timeStringWithDate:(long long )value{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:value];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [formatter stringFromDate:date];
}


//取消订单按钮点击事件
- (void)cancelOrderAction:(UIButton *)sender{
    OrderModel *model = self.dataList[sender.tag];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSLog(@"%@",[NSString stringWithFormat:Request_Method_Cancelorders,model.order_id]);
    [HttpRequest httpRequestGET:[NSString stringWithFormat:Request_Method_Cancelorders,model.order_id] parameters:nil progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        DLog(@"%@",responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    } responseSerializer:[AFJSONResponseSerializer serializer] toView:self.view];
}
@end
