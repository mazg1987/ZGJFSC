//
//  HomeViewController.m
//  YMJFSC
//
//  Created by mazg on 16/1/8.
//  Copyright © 2016年 mazg. All rights reserved.
//

#import "HomeViewController.h"
#import "OTPageView.h"
#import "BrandModel.h"
#import "GoodModel.h"
#import "RecommonCell.h"
#import "LogoViewController.h"
#import "BaseNaviController.h"
#import "BrandDetailController.h"
#import "GoodDetailViewController.h"
#import "ResponseObject.h"


#define PageScrollCellWidth W(65)
#define PageScrollCellPadding W(5)

static NSString *identifier = @"cell";

@interface HomeViewController ()<OTPageScrollViewDataSource,OTPageScrollViewDelegate,UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>{
    UIBarButtonItem *item;
    MJRefreshNormalHeader *header;
}
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet OTPageView *pageView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
//首页品牌列表
@property (nonatomic,strong) NSMutableArray *homeBrandArr;
//首页推荐数据
@property (nonatomic,strong) NSMutableArray *homeRecommonArr;
@end

@implementation HomeViewController

#pragma mark 添加监看
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        [self addObserver:self forKeyPath:@"logo_status" options:NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew context:nil];
    }
    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    if (![change[@"new"] isEqual:change[@"old"]]) {
        //发送登陆请求
        if ([change[@"new"] integerValue] == 1) {
            DLog(@"加载数据");
            [self lognRequest]; //自动登录
        }
    }
    //设置导航栏按钮
    [self setUpNaviButton];
}

- (void)dealloc{
    [self removeObserver:self forKeyPath:@"logo_status"];
}



#pragma mark 延迟实例话
-(NSMutableArray *)homeBrandArr{
    if (_homeBrandArr==nil) {
        _homeBrandArr = [[NSMutableArray alloc]init];
    }
    return _homeBrandArr;
}

-(NSMutableArray *)homeRecommonArr{
    if (_homeRecommonArr == nil) {
        _homeRecommonArr = [[NSMutableArray alloc]init];
    }
    return _homeRecommonArr;
}

#pragma mark ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    //加载品牌列表
    [self loadHomeBrandList];
    //加载首页推荐
    [self loadHomeRecommon];
    //注册cell
    [self.tableView registerNib:[UINib nibWithNibName:@"RecommonCell" bundle:nil] forCellReuseIdentifier:identifier];
    //searchBar
    self.searchBar.delegate = self;
    self.searchBar.showsCancelButton = YES;
    //下拉刷新
    header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadHomeRecommon];
    }];
    self.tableView.mj_header = header;
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (self.logo_status == 0) {
        [MBProgressHUD showMessage:@"请先登录" toView:self.view afterDelty:1.0];
        return;
    }
}

- (void)setUpNaviButton{
    //导航栏左侧按钮
    if (self.logo_status == 1) {
        item = [[UIBarButtonItem alloc]initWithTitle:@"注销" style:UIBarButtonItemStylePlain target:self action:@selector(logoBtnPressed:)];
    }
    else{
        //未登陆
        item = [[UIBarButtonItem alloc]initWithTitle:@"登录" style:UIBarButtonItemStylePlain target:self action:@selector(logoBtnPressed:)];
    }
    self.navigationItem.leftBarButtonItem = item;
}
    

//登陆按钮点击跳转页面
- (void)logoBtnPressed:(UIBarButtonItem *)item{
    if (self.logo_status == 0) {
        LogoViewController *logoVC = [[LogoViewController alloc]init];
        BaseNaviController *navi = [[BaseNaviController alloc]initWithRootViewController:logoVC];
        [self presentViewController:navi animated:YES completion:nil];
    }
    else{
        //注销登录
        DLog(@"注销登录");
        UIAlertController *alertVC = [[UIAlertController alloc]init];
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确认注销?" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //注销登录接口有问题，暂用这个替代
            [UserModel setLogoStatus:UN_Logo];
            self.logo_status = [UserModel logoStatus];
            [self dismissViewControllerAnimated:YES completion:nil];
        }];
        UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alertVC addAction:action1];
        [alertVC addAction:action2];
        [self presentViewController:alertVC animated:YES completion:nil];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark 网络请求
//自动登录请求
-(void)lognRequest{
    //请求数据
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"uname"]=[UserModel userName];
    params[@"password"]=[UserModel passWord];
    [HttpRequest httpRequestPOST:Request_Method_Login parameters:params progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject,ResponseObject *obj) {
        //提示自动登录成功
        [MBProgressHUD showMessage:obj.message toView:self.view afterDelty:1.0];
        //保存数据
        if ([obj.code integerValue]==0) {
            [UserModel setLogoStatus:Logo];
            self.logo_status = [UserModel logoStatus];
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {

    } responseSerializer:[AFJSONResponseSerializer serializer]
     toView:self.view];
}



//注销登录请求 (接口有问题)
//-(void)cancelLogoRequest{
//    [HttpRequest httpRequestGET:Request_Method_CancelLogin parameters:nil progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject) {
//        ResponseObject *obj = [[ResponseObject alloc]initWithDict:responseObject];
//        [MBProgressHUD showMessage:obj.message toView:nil afterDelty:1.0];
//        //保存数据
//        if ([obj.code integerValue]==0) {
//            [UserModel setLogoStatus:UN_Logo];
//             self.logo_status = [UserModel logoStatus];
//            [self dismissViewControllerAnimated:YES completion:nil];
//        }
//    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//        [MBProgressHUD showMessage:@"请求失败" toView:nil afterDelty:1.0];
//    } responseSerializer:[AFJSONResponseSerializer serializer]];
//}


//加载首页品牌列表
-(void)loadHomeBrandList{
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    manager.responseSerializer = [AFJSONResponseSerializer serializer];
//    [manager GET:[NSString stringWithFormat:@"%@%@",K_IP,Request_Method_BandLogosHtml] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        self.homeBrandArr = [BrandModel allModelsWithDictionary:responseObject];
//        [self loadBrandView];
//        [self.tableView reloadData];
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        [MBProgressHUD showMessage:@"加载品牌列表失败" toView:self.view afterDelty:1.0];
//    }];
    
    
    [HttpRequest httpRequestGET:Request_Method_BandLogosHtml parameters:nil progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject,ResponseObject *obj) {
        self.homeBrandArr = [BrandModel allModelsWithDictionary:responseObject];
        [self loadBrandView];
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
    }
     responseSerializer:[AFJSONResponseSerializer serializer]
     toView:self.view];
}


//加载品牌列表视图
- (void)loadBrandView{
    self.pageView.pageScrollView = [[OTPageScrollView alloc]init];
    self.pageView.pageScrollView.delegate = self;
    self.pageView.pageScrollView.dataSource = self;
    self.pageView.pageScrollView.bounds = self.pageView.bounds;
    setFrameX(self.pageView.pageScrollView, 0);
    setFrameY(self.pageView.pageScrollView, 0);
    self.pageView.pageScrollView.padding = PageScrollCellPadding;
    self.pageView.pageScrollView.leftRightOffset = PageScrollCellPadding;
    [self.pageView addSubview:self.pageView.pageScrollView];
    [self.pageView.pageScrollView reloadData];
}


//加载首页推荐数据
- (void)loadHomeRecommon{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [HttpRequest httpRequestGET:Request_Method_indexRecommon parameters:nil progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject,ResponseObject *obj) {
        [header endRefreshing];
        self.homeRecommonArr = [GoodModel allModelsWithDictionary:responseObject];
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [header endRefreshing];
    }
     responseSerializer:[AFJSONResponseSerializer serializer]
     toView:self.view];
}

#pragma mark OTPageScrollViewDelegate
//返回cell总个数
- (NSInteger)numberOfPageInPageScrollView:(OTPageScrollView*)pageScrollView{
    return self.homeBrandArr.count;
}

//返回每个cell的宽度
- (CGSize)sizeCellForPageScrollView:(OTPageScrollView*)pageScrollView{
    return CGSizeMake(PageScrollCellWidth, PageScrollCellWidth);
}

//点击某个cell后做什么
- (void)pageScrollView:(OTPageScrollView *)pageScrollView didTapPageAtIndex:(NSInteger)index{
    DLog(@"----------------------------%li",index);
    BrandModel *brandModel = self.homeBrandArr[index];
    BrandDetailController *detail = [[BrandDetailController alloc]init];
    detail.brandModel = brandModel;
    [self.navigationController pushViewController:detail animated:YES];
}

//返回每个cell的视图
- (UIView*)pageScrollView:(OTPageScrollView *)pageScrollView viewForRowAtIndex:(int)index{
    UIImageView *view = [[UIImageView alloc]init];
    BrandModel *model = self.homeBrandArr[index];
    [view sd_setImageWithURL:[NSURL URLWithString:model.src] placeholderImage:nil];
    return view;
}


#pragma mark UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.homeRecommonArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RecommonCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    cell.model = self.homeRecommonArr[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DLog(@"选中cell跳转页面");
    GoodDetailViewController *detail = [[GoodDetailViewController alloc]init];
    detail.detailModel = self.homeRecommonArr[indexPath.row];
    [self.navigationController pushViewController:detail animated:YES];
}


#pragma mark UISearchBarDelegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    DLog(@"开始搜索--%@",searchBar.text);
    [self.view endEditing:YES];
    [MBProgressHUD showMessage:@"未找到数据" toView:self.view afterDelty:2.0];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    DLog(@"取消搜索");
    [self.view endEditing:YES];
}


@end
