//
//  PersonCenterViewController.m
//  YMJFSC
//
//  Created by mazg on 16/1/8.
//  Copyright © 2016年 mazg. All rights reserved.
//

#import "PersonCenterViewController.h"
#import "UserModel.h"
#import "ModifyUNameController.h"

static NSString *identifier = @"cell";

@interface PersonCenterViewController ()<UITableViewDelegate,UITableViewDataSource>{
    UserModel *contentModel;
    NSArray *tDataList;
}
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *pointLabel;
@property (weak, nonatomic) IBOutlet UITableView *tabelView;

@end

@implementation PersonCenterViewController

#pragma mark 添加监看
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        [self addObserver:self forKeyPath:@"logo_status" options:NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew context:nil];
    }
    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    if (![change[@"new"] isEqual:change[@"old"]]) {
        //加载个人数据
        if ([change[@"new"] integerValue] == 1) {
            DLog(@"加载数据");
            [self resertData];
        }
        //清空个人数据
        else{
            DLog(@"清空数据");
            [self clearData];
        }
    }
}

- (void)dealloc{
    [self removeObserver:self forKeyPath:@"logo_status"];
}

#pragma mark 数据
//设置会员数据
- (void)resertData{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [HttpRequest httpRequestGET:Request_Method_apimember parameters:nil progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject,ResponseObject *obj) {
        DLog(@"%@",responseObject);
        contentModel = [UserModel userWithDict:responseObject];
        [self setData];
        [self.tabelView reloadData];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
    } responseSerializer:[AFJSONResponseSerializer serializer]
     toView:self.view];
}

- (void)setData{
    self.phoneLabel.text = contentModel.uname;
    self.pointLabel.text = [NSString stringWithFormat:@"可使用积分:%@",contentModel.usage_point];
}

//清除会员数据
- (void)clearData{
    self.phoneLabel.text = @"";
    self.pointLabel.text = @"";
    contentModel = nil;
    [self.tabelView reloadData];
}


#pragma mark ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    tDataList = @[@"昵称",@"吐槽/售后"];
    
    //设置字体
    self.phoneLabel.font = k_Font_LessThenBig;
    self.pointLabel.font = k_Font_LessThenBig;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (self.logo_status == 0) {
        [MBProgressHUD showMessage:@"请先登录" toView:self.view afterDelty:1.0];
        return;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return tDataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
        cell.textLabel.font = k_Font_LessThenBig;
        cell.detailTextLabel.font = k_Font_LessThenBig;
    }
    cell.accessoryType =UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = tDataList[indexPath.row];
    if (indexPath.row == 0) {
        cell.detailTextLabel.text = contentModel.uname;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //未登陆不需要跳转页面
    if ([UserModel logoStatus] ==0) {
        return;
    }
    if (indexPath.row == 0) {
        ModifyUNameController *modifyVC = [[ModifyUNameController alloc]init];
        [self.navigationController pushViewController:modifyVC animated:YES];
    }
}
@end
