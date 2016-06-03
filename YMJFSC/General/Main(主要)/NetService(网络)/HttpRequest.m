//
//  HttpRequest.m
//  YMJFSC
//
//  Created by mazg on 16/1/11.
//  Copyright © 2016年 mazg. All rights reserved.
//

#import "HttpRequest.h"
#import "ResponseObject.h"

@implementation HttpRequest

+ (void)httpRequestGET:(NSString *)string parameters:(id)parmeters progress:(ProgressBlock)progress sucess:(SucessBlock)sucess failure:(FailureBlock)failure  responseSerializer:(id)serializer toView:(UIView *)view{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = serializer;
    string = [NSString stringWithFormat:@"%@%@",K_IP,string];
    [manager GET:string parameters:parmeters progress:^(NSProgress * _Nonnull downloadProgress) {
        if (progress!= nil) {
            progress(downloadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [MBProgressHUD hideHUDForView:view];
        ResponseObject *obj;
        //如果解析器是AFHTTPRequestSerializer类型，则要先把数据转换成字典
        if ([serializer isMemberOfClass:[AFHTTPResponseSerializer class]]) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
            obj = [[ResponseObject alloc]initWithDict:dic];
        }
        else{
            obj = [[ResponseObject alloc]initWithDict:responseObject];
        }
        
        //请求出现错误，显示错误信息
        if ([obj.code integerValue] !=0 ) {
#warning 购物车列表的网络请求有问题，在这里做了一下处理
            NSString *str = task.response.URL.absoluteString;
            if ([str rangeOfString:Request_Method_apicarthtml].location!=NSNotFound) {
                sucess(task,responseObject,obj);
                return ;
            }
//这里是正常情况下的请求
            [MBProgressHUD showMessage:obj.message toView:view afterDelty:1.0];
            return ;
        }
        sucess(task,responseObject,obj);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD hideHUDForView:view];
        [MBProgressHUD showMessage:@"请求失败" toView:view afterDelty:1.0];
        failure(task,error);
    }];
}


+ (void)httpRequestPOST:(NSString *)string parameters:(id)parmeters progress:(ProgressBlock)progress sucess:(SucessBlock)sucess failure:(FailureBlock)failure responseSerializer:(id)serializer toView:(UIView *)view{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = serializer;
    string = [NSString stringWithFormat:@"%@%@",K_IP,string];
    [manager POST:string parameters:parmeters progress:^(NSProgress * _Nonnull downloadProgress) {
        if (progress!= nil) {
            progress(downloadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [MBProgressHUD hideHUDForView:view];
        ResponseObject *obj;
        //如果解析器是AFHTTPRequestSerializer类型，则要先把数据转换成字典
        if ([serializer isMemberOfClass:[AFHTTPResponseSerializer class]]) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
            obj = [[ResponseObject alloc]initWithDict:dic];
        }
        else{
            obj = [[ResponseObject alloc]initWithDict:responseObject];
        }
        
        if ([obj.code integerValue] !=0 ) {
            [MBProgressHUD showMessage:obj.message toView:view afterDelty:1.0];
            return ;
        }
        sucess(task,responseObject,obj);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD hideHUDForView:view];
        [MBProgressHUD showMessage:@"请求失败" toView:view afterDelty:1.0];
        failure(task,error);
    }];
}

@end
