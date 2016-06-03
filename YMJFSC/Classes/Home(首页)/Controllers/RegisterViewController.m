//
//  RegisterViewController.m
//  YMJFSC
//
//  Created by mazg on 16/1/11.
//  Copyright © 2016年 mazg. All rights reserved.
//

#import "RegisterViewController.h"
#import "ResponseObject.h"
#import "RegisterPasswordController.h"

@interface RegisterViewController ()

@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *passWordTextField;
@property (weak, nonatomic) IBOutlet UIButton *getVialdBtn;
- (IBAction)getVialdCode:(id)sender;
- (IBAction)rigesterAction:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"验证码";
    
    self.getVialdBtn.backgroundColor = k_color_NaviBarColor;
    self.countLabel.backgroundColor = k_color_NaviBarColor;
    self.countLabel.text = @"倒计时60秒";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//获取验证码
- (IBAction)getVialdCode:(id)sender {
    if (IsNilString(self.phoneTextField.text)) {
        [MBProgressHUD showMessage:@"手机号码不能为空" toView:self.view afterDelty:1.0];
        return;
    }
    self.getVialdBtn.enabled = NO;
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"tel"] = self.phoneTextField.text;
    //请求获取验证码
    [HttpRequest httpRequestGET:Request_Method_getsmscode parameters:parameters progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject,ResponseObject *obj) {
        //请求成功
        [MBProgressHUD showMessage:obj.message toView:self.view afterDelty:1.0];
        //如果状态为0，说明没有错误
        if ([obj.code integerValue]==0) {
            [self.view bringSubviewToFront:self.countLabel];
            [self startTime];
        }
        else{
            self.getVialdBtn.enabled = YES;
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        DLog(@"%@",error);
        self.getVialdBtn.enabled = YES;
    }
     responseSerializer:[AFHTTPResponseSerializer serializer]
     toView:self.view];
}


//验证验证码接口
- (IBAction)rigesterAction:(id)sender {
    if (IsNilString(self.phoneTextField.text) ||IsNilString(self.passWordTextField.text)) {
        [MBProgressHUD showMessage:@"手机号码或验证码不能为空" toView:self.view afterDelty:1.0];
        return;
    }
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"tel"] = self.phoneTextField.text;
    parameters[@"code"] = self.passWordTextField.text;
    [HttpRequest httpRequestGET:Request_Method_checkverify parameters:parameters progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject,ResponseObject *obj) {
        [MBProgressHUD showMessage:obj.message toView:self.view afterDelty:1.0];
        if ([obj.code integerValue]==0) {
            RegisterPasswordController *passwordVC = [[RegisterPasswordController alloc]init];
            [self.navigationController pushViewController:passwordVC animated:YES];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        DLog(@"%@",error);
    }
     responseSerializer:[AFHTTPResponseSerializer serializer]
     toView:self.view];
}

#pragma mark - 60秒倒计时
-(void)startTime{
    NSTimer *t = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateTime:) userInfo:nil repeats:YES];
}

-(void)updateTime:(NSTimer *)t{
    static int count = 0;
    count ++;
    self.countLabel.text = [NSString stringWithFormat:@"倒计时:%i秒",60-count];
    if (count >=60) {
        count = 0;
        [t invalidate];
        [self.view sendSubviewToBack:self.countLabel];
        self.countLabel.text = @"倒计时60秒";
        self.getVialdBtn.enabled = YES;
    }
}




@end
