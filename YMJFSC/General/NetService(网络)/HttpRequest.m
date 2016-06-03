//
//  HttpRequest.m
//  YMJFSC
//
//  Created by mazg on 16/1/11.
//  Copyright © 2016年 mazg. All rights reserved.
//

#import "HttpRequest.h"

@implementation HttpRequest

+ (void)httpRequestGET:(NSString *)string parameters:(id)parmeters progress:(ProgressBlock)progress sucess:(SucessBlock)sucess failure:(FailureBlock)failure  responseSerializer:(id)serializer{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = serializer;
    string = [NSString stringWithFormat:@"%@%@",K_IP,string];
    [manager GET:string parameters:parmeters progress:^(NSProgress * _Nonnull downloadProgress) {
        if (progress!= nil) {
            progress(downloadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        sucess(task,responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(task,error);
    }];
}


+ (void)httpRequestPOST:(NSString *)string parameters:(id)parmeters progress:(ProgressBlock)progress sucess:(SucessBlock)sucess failure:(FailureBlock)failure responseSerializer:(id)serializer{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = serializer;
    string = [NSString stringWithFormat:@"%@%@",K_IP,string];
    [manager POST:string parameters:parmeters progress:^(NSProgress * _Nonnull downloadProgress) {
        if (progress!= nil) {
            progress(downloadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        sucess(task,responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(task,error);
    }];
}

@end
