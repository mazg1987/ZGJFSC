//
//  HttpRequest.h
//  YMJFSC
//
//  Created by mazg on 16/1/11.
//  Copyright © 2016年 mazg. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^ProgressBlock)(NSProgress *downloadProgress);
typedef void(^SucessBlock)(NSURLSessionDataTask *task, id responseObject) ;
typedef void(^FailureBlock)(NSURLSessionDataTask *task, NSError *error) ;

@interface HttpRequest : NSObject

+ (void)httpRequestGET:(NSString *)string parameters:(id)parmeters progress:(ProgressBlock)progress sucess:(SucessBlock)sucess failure:(FailureBlock)failure responseSerializer:(id)serializer;

+ (void)httpRequestPOST:(NSString *)string parameters:(id)parmeters progress:(ProgressBlock)progress sucess:(SucessBlock)sucess failure:(FailureBlock)failure responseSerializer:(id)serializer;

@end
