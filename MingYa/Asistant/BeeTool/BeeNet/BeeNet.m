//
//  BeeNet.m
//  ShopDog
//
//  Created by 陈必锋 on 2017/8/4.
//  Copyright © 2017年 shopDog. All rights reserved.
//

#import "BeeNet.h"
#import <AFNetworking.h>


// 云端
//#define BASE_URL @"http://119.23.66.37:8080/mingya/mingya/"
// 本地
#define BASE_URL @"http://192.168.3.44:8080/mingya/"

//#define BASE_URL @"http://http://119.23.66.37/babymc/admin"
//#define BASE_URL @"http://192.168.3.16/babymc"

#define LogShow 1

@interface BeeNet ()
@property (strong,nonatomic) AFHTTPSessionManager* manager;
@end

@implementation BeeNet

+(instancetype)sharedInstance{
    static BeeNet *beeNet;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        beeNet = [[self alloc] init];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        beeNet.manager = manager;
//        beeNet.manager.requestSerializer = [AFJSONRequestSerializer serializer];
        beeNet.manager.responseSerializer = [AFJSONResponseSerializer serializer];
        beeNet.manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"application/json", nil];
    });
    return beeNet;
}


/**
  带 json body 的查询
 */
-(void)requestWithType:(RequestType)requestType andUrl:(NSString *)url andParam:(id)params andHeader:(NSDictionary *)header andRequestSerializer:(id)requestSer andResponseSerializer:(id)responseSer andSuccess:(void (^)(id))success andFailed:(void (^)(NSString *))failed{
    self.manager.requestSerializer = requestSer;
    self.manager.responseSerializer = responseSer;
    
    [self requestWithType:requestType andUrl:url andParam:params andHeader:header andSuccess:success andFailed:failed];
}


/**
 默认查询
 */
-(void)requestWithType:(RequestType)requestType andUrl:(NSString *)url andParam:(id)params andHeader:(NSDictionary *)header andSuccess:(void (^)(id data))success andFailed:(void (^)(NSString * str))failed{
    if (![url hasPrefix:@"http://"] && ![url hasPrefix:@"https://"]) {
        url = [NSString stringWithFormat:@"%@%@",BASE_URL,url];
    }
    
    if (header != nil) {
        for (NSString* key in header) {
            [self.manager.requestSerializer setValue:header[key] forHTTPHeaderField:key];
        }
    }
    
    if (LogShow == 1) {
        NSLog(@"*********%@*********",url);
        NSLog(@"params:%@",params);
        NSLog(@"*****************");
        NSLog(@"header:%@",header);
        NSLog(@"*****************");
    }
    
    if (requestType == Request_GET) {
        [self.manager GET:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if (LogShow == 1) {
                NSLog(@"%@",responseObject);
            }
            success(responseObject);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            failed([error description]);
        }];
    }
    else if (requestType == Request_POST){
        [self.manager POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if (LogShow == 1) {
                NSLog(@"%@",responseObject);
            }
            success(responseObject);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            failed([error description]);
        }];
    }
    else if (requestType == Request_PUT){
        [self.manager PUT:url parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if (LogShow == 1) {
                NSLog(@"%@",responseObject);
            }
            success(responseObject);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            failed([error description]);
        }];
    }
    else if (requestType == Request_Delete){
        [self.manager DELETE:url parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if (LogShow == 1) {
                NSLog(@"%@",responseObject);
            }
            success(responseObject);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            failed([error description]);
        }];
    }
}


-(void)requestWithType:(RequestType)requestType andUrl:(NSString *)url andParam:(id)params andHeader:(NSDictionary *)header andBeeCallBack:(BeeNetCallback *)beeCallback{
    [self requestWithType:requestType andUrl:url andParam:params andHeader:header andSuccess:^(id data) {
        [beeCallback requestReturnResult:data];
    } andFailed:^(NSString *str) {
        if (LogShow == 1) {
            NSLog(@"error:%@",str);
        }
    }];
}


-(void)postFileWithUrl:(NSString *)url andFileKey:(NSString*)fileKey andParams:(id)param andFileData:(NSData *)FileData andHeader:(NSDictionary *)header andBeeCallback:(BeeNetCallback *)beeCallback{
    if (![url hasPrefix:@"http://"] && ![url hasPrefix:@"https://"]) {
        url = [NSString stringWithFormat:@"%@%@",BASE_URL,url];
    }
    
    if (header != nil) {
        for (NSString* key in header) {
            [self.manager.requestSerializer setValue:header[key] forHTTPHeaderField:key];
        }
    }
    
    [self.manager POST:url parameters:param constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:FileData name:fileKey fileName:@"test.jpg" mimeType:@"image/jpeg"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        if (LogShow == 1) {
            NSLog(@"progress:%f",uploadProgress.fractionCompleted);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (LogShow == 1) {
            NSLog(@"post file: %@",responseObject);
        }
        [beeCallback requestReturnResult:responseObject];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (LogShow == 1) {
            NSLog(@"post file: %@",error);
        }
    }];
}

-(void)headRequest:(NSString *)url andSuccess:(void (^)(id))success andFailed:(void (^)(NSString *))failed{
    [self.manager HEAD:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] parameters:nil success:^(NSURLSessionDataTask * _Nonnull task) {
        success([(NSHTTPURLResponse*)task.response allHeaderFields]);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failed(@"获取文件大小失败");
    }];
}

@end
