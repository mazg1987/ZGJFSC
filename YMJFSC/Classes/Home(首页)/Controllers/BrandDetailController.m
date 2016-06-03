//
//  BrandDetailController.m
//  YMJFSC
//
//  Created by mazg on 16/1/11.
//  Copyright © 2016年 mazg. All rights reserved.
//

#import "BrandDetailController.h"
#import "GoodModel.h"
#import "RecommonCell.h"
#import "GoodDetailViewController.h"

static NSString *identifier = @"cell";

@interface BrandDetailController ()<UITableViewDataSource,UITableViewDelegate>{
    MJRefreshNormalHeader *header;
}
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UITableView *tabelView;

@end

@implementation BrandDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = _brandModel.brand_name;
    //加载图片
    [_iconView sd_setImageWithURL:[NSURL URLWithString:_brandModel.src]];
    //加载数据
    [self loadData];
    //注册cell
    [self.tabelView registerNib:[UINib nibWithNibName:@"RecommonCell" bundle:nil] forCellReuseIdentifier:identifier];
    //下拉刷新
    header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadData];
    }];
    self.tabelView.mj_header = header;
}

- (void)loadData{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"brand"] = self.brandModel.brand_id;
    parameters[@"page"]= @1;
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    //请求数据
    [HttpRequest httpRequestGET:Request_Method_brandGoods parameters:parameters progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject,ResponseObject *obj) {
        [header endRefreshing];
        self.dataList = [GoodModel allModelsWithDictionary:responseObject];
        [self.tabelView reloadData];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [header endRefreshing];
    } responseSerializer:[AFJSONResponseSerializer serializer]
     toView:self.view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RecommonCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    cell.model = self.dataList[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    GoodDetailViewController *detail = [[GoodDetailViewController alloc]init];
    detail.detailModel = self.dataList[indexPath.row];
    [self.navigationController pushViewController:detail animated:YES];
}




@end
