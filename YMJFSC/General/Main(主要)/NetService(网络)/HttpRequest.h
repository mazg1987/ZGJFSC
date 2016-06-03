//
//  HttpRequest.h
//  YMJFSC
//
//  Created by mazg on 16/1/11.
//  Copyright © 2016年 mazg. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ResponseObject;

typedef void(^ProgressBlock)(NSProgress *downloadProgress);
typedef void(^SucessBlock)(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) ;
typedef void(^FailureBlock)(NSURLSessionDataTask *task, NSError *error) ;

@interface HttpRequest : NSObject

+ (void)httpRequestGET:(NSString *)string parameters:(id)parmeters progress:(ProgressBlock)progress sucess:(SucessBlock)sucess failure:(FailureBlock)failure responseSerializer:(id)serializer toView:(UIView *)view;

+ (void)httpRequestPOST:(NSString *)string parameters:(id)parmeters progress:(ProgressBlock)progress sucess:(SucessBlock)sucess failure:(FailureBlock)failure responseSerializer:(id)serializer toView:(UIView *)view;

@end
