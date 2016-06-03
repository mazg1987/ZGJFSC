//
//  RegisterPasswordController.m
//  YMJFSC
//
//  Created by mazg on 16/1/11.
//  Copyright © 2016年 mazg. All rights reserved.
//

#import "RegisterPasswordController.h"
#import "ResponseObject.h"

@interface RegisterPasswordController ()
@property (weak, nonatomic) IBOutlet UITextField *passWord1;
@property (weak, nonatomic) IBOutlet UITextField *passWord2;
- (IBAction)okAction:(id)sender;

@end

@implementation RegisterPasswordController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"注册";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)okAction:(id)sender {
    if (IsNilString(_passWord1.text) || IsNilString(_passWord2.text)) {
        [MBProgressHUD showMessage:@"密码不能为空" toView:self.view afterDelty:1.0];
    }
    if (![_passWord1.text isEqualToString:_passWord2.text]) {
        [MBProgressHUD showMessage:@"两次密码不一致" toView:self.view afterDelty:1.0];
    }
    if (_passWord1.text.length<6) {
        [MBProgressHUD showMessage:@"密码长度不得小于6" toView:self.view afterDelty:1.0];
    }
    
    NSMutableDictionary *paramters = [NSMutableDictionary dictionary];
    paramters[@"login_password"] =_passWord1.text ;
    paramters[@"psw_confirm"] = _passWord2.text;
    [HttpRequest httpRequestPOST:Request_Method_create parameters:paramters progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject,ResponseObject *obj) {
        //提示注册账户成功
        [MBProgressHUD showMessage:obj.message toView:self.view afterDelty:1.0];
        if ([obj.code integerValue] == 0) {
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
    } responseSerializer:[AFJSONResponseSerializer serializer]
     toView:self.view];
}

@end
