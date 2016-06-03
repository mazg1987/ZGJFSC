//
//  LogoViewController.m
//  YMJFSC
//
//  Created by mazg on 16/1/11.
//  Copyright © 2016年 mazg. All rights reserved.
//

#import "LogoViewController.h"
#import "RegisterViewController.h"
#import "ResponseObject.h"

@interface LogoViewController ()
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *passWordTextField;

@end

@implementation LogoViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    self.title = @"登陆";
    
    //导航栏左侧按钮
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(leftItemPressed:)];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    //导航栏右侧按钮
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithTitle:@"手机注册" style:UIBarButtonItemStylePlain target:self action:@selector(rightItemPressed:)];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    
}

//退出
- (void)leftItemPressed:(UIBarButtonItem *)item{
    [self dismissViewControllerAnimated:YES completion:nil];
}

//手机注册页面
- (void)rightItemPressed:(UIBarButtonItem *)item{
    RegisterViewController *registerVC = [[RegisterViewController alloc]init];
    [self.navigationController pushViewController:registerVC animated:YES];
}


//登陆按钮点击后
//需要保存登陆状态，下次打开app直接登录
//账号密码需要保存本地
- (IBAction)logoBtnPressed:(id)sender {
    if (IsNilString(self.phoneTextField.text) || IsNilString(self.passWordTextField.text)) {
        [MBProgressHUD showMessage:@"账号密码不能为空" toView:self.view afterDelty:1.0];
        return;
    }
    
    //请求数据
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"uname"]=self.phoneTextField.text;
    params[@"password"]=self.passWordTextField.text;
    [HttpRequest httpRequestPOST:Request_Method_Login parameters:params progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject,ResponseObject *obj) {
        //提示登录成功
        [MBProgressHUD showMessage:obj.message toView:self.view afterDelty:1.0];
        //保存数据
        if ([obj.code integerValue]==0) {
            [UserModel setUserName:self.phoneTextField.text];
            [UserModel setPassWord:self.passWordTextField.text];
            [UserModel setLogoStatus:Logo];
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
    } responseSerializer:[AFJSONResponseSerializer serializer]
     toView:self.view];
    
}
@end
