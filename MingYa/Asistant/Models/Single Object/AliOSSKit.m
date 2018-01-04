//
//  AliOSSKit.m
//  MingYa
//
//  Created by 镓洲 王 on 12/11/17.
//  Copyright © 2017 镓洲 王. All rights reserved.
//

#import "AliOSSKit.h"
#import "MYUser.h"
#import "BeeNet.h"
#import <AliyunOSSiOS/OSSService.h>


/*
 mingya-oss.oss-cn-shenzhen.aliyuncs.com
 Access Key ID:  LTAIfx2tgz94DBbX
 Access Key Secret:  oKrkinHaJf3CbIrgQIrPhcK3ejgCcW
 */

// 伟哥：http://mingya-oss.oss-cn-shenzhen.aliyuncs.com/1513073762806IMG_20170913_123000.jpg
// origin: https://oss-cn-shenzhen-internal.aliyuncs.com

NSString *const endPoint = @"http://oss-cn-shenzhen.aliyuncs.com";
NSString *const bucketName = @"mingya-oss";

OSSClient * client;

@implementation AliOSSKit

+ (instancetype)sharedInstance {
    static AliOSSKit *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [AliOSSKit new];
    });
    return instance;
}

# pragma mark - init
-(instancetype)init{
    if (self = [super init]) {
        [self initOSSClient];
    }
    return self;
}


- (void)initOSSClient {
    // log
    [OSSLog enableLog];
    // request
    NSString *myToken = [[MYUser defaultUser] token];
    NSDictionary *paramDict = @{@"token":myToken};
    [[BeeNet sharedInstance] requestWithType:Request_GET andUrl:@"typework/getsts" andParam:paramDict andHeader:nil andSuccess:^(id data) {
        // success
        NSDictionary *resultDict = data[@"data"];
        NSString *accessKeyId = resultDict[@"accessKeyId"];
        NSString *accessKeySecret = resultDict[@"accessKeySecret"];
        NSString *securityToken = resultDict[@"securityToken"];
        
        id<OSSCredentialProvider> credential = [[OSSStsTokenCredentialProvider alloc] initWithAccessKeyId:accessKeyId secretKeyId:accessKeySecret securityToken:securityToken];
        
        // 配置
//        OSSClientConfiguration *conf = [OSSClientConfiguration new];
//        conf.maxRetryCount = 2;
//        conf.timeoutIntervalForRequest = 30;
//        conf.timeoutIntervalForResource = 24 * 60 * 60;
//        client = [[OSSClient alloc] initWithEndpoint:endPoint credentialProvider:credential clientConfiguration:conf];
        
        client = [[OSSClient alloc] initWithEndpoint:endPoint credentialProvider:credential];
        
    } andFailed:nil];
}



# pragma mark - 上传图片
-(void)pushImage:(UIImage *)img withName:(NSString *)imgName{
    
    OSSPutObjectRequest * put = [OSSPutObjectRequest new];
    
    // required fields
    put.bucketName = bucketName;
    put.objectKey = imgName;
    
    // progress
    put.uploadProgress = ^(int64_t bytesSent, int64_t totalByteSent, int64_t totalBytesExpectedToSend) {
        NSLog(@"%lld, %lld, %lld", bytesSent, totalByteSent, totalBytesExpectedToSend);
    };
    
    // save to SandBox
    NSData *imageData = UIImageJPEGRepresentation(img, 0.3);
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"tmp"] stringByAppendingPathComponent:imgName];
    [imageData writeToFile:fullPath atomically:NO];
    NSURL *url = [NSURL fileURLWithPath:fullPath];
    
    // set putting file url & put
    put.uploadingFileURL = url;
    OSSTask *putTask = [client putObject:put];
    
    [putTask continueWithBlock:^id _Nullable(OSSTask * _Nonnull task) {
        // finish upload
        
        // 回调网址
        OSSTask *task2 = [client presignPublicURLWithBucketName:bucketName withObjectKey:imgName];
        if (!task2.error) {
            // result
            NSString *publicURL = task2.result;
            NSLog(@"%@", publicURL);
            // send 2 delegate
            if ([self.delegate respondsToSelector:@selector(aliKitFinishUploadImg:withName:)]) {
                [self.delegate performSelector:@selector(aliKitFinishUploadImg:withName:) withObject:img withObject:publicURL];
            }
        } else {
            // 回调网址失败
            NSLog(@"sign url error: %@", task2.error);
        }
        
        if (!task.error) {
            NSLog(@"upload object success!");
        } else {
            NSLog(@"upload object failed, error: %@" , task.error);
        }
        return nil;
    }];
    
}


# pragma mark - 批量上传
- (void)pushImgsAutoSetName:(NSArray *)imgArr{
    
    NSMutableArray *nameArr = [[NSMutableArray alloc] init];
    
    // enumerate
    for (UIImage *img in imgArr) {
        
        OSSPutObjectRequest * put = [OSSPutObjectRequest new];
        
        // required fields
        put.bucketName = bucketName;
        
        // progress
        put.uploadProgress = ^(int64_t bytesSent, int64_t totalByteSent, int64_t totalBytesExpectedToSend) {
            NSLog(@"%lld, %lld, %lld", bytesSent, totalByteSent, totalBytesExpectedToSend);
        };
        
        NSString *imgName = [NSString stringWithFormat:@"ios_%f.jpg",[[[NSDate alloc] init] timeIntervalSince1970] ];
        put.objectKey = imgName;
        // save to SandBox
        NSData *imageData = UIImageJPEGRepresentation(img, 0.3);
        NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"tmp"] stringByAppendingPathComponent:imgName];
        [imageData writeToFile:fullPath atomically:NO];
        NSURL *url = [NSURL fileURLWithPath:fullPath];
        
        // set putting file url & put
        put.uploadingFileURL = url;
        OSSTask *putTask = [client putObject:put];
        
        [putTask continueWithBlock:^id _Nullable(OSSTask * _Nonnull task) {
            // finish upload
            
            // 回调网址
            OSSTask *task2 = [client presignPublicURLWithBucketName:bucketName withObjectKey:imgName];
            if (!task2.error) {
                // result
                NSString *publicURL = task2.result;
                NSLog(@"%@", publicURL);
//                // send 2 delegate
//                if ([self.delegate respondsToSelector:@selector(aliKitFinishUploadImg:withName:)]) {
//                    [self.delegate performSelector:@selector(aliKitFinishUploadImg:withName:) withObject:img withObject:publicURL];
//                }
                // add 2 arr
                [nameArr addObject:publicURL];
                
                if (nameArr.count == imgArr.count) {
                    // 全部上传完成
                    if ([self.delegate respondsToSelector:@selector(aliKitFinishUploadImgswithNameArr:)]) {
                        [self.delegate performSelector:@selector(aliKitFinishUploadImgswithNameArr:) withObject:nameArr];
                    }
                }
            } else {
                // 回调网址失败
                NSLog(@"sign url error: %@", task2.error);
            }
            
            if (!task.error) {
                NSLog(@"upload object success!");
            } else {
                NSLog(@"upload object failed, error: %@" , task.error);
            }
            return nil;
        }];
    }
}


//
//-(void)uploadTest{
//
//    OSSPutObjectRequest * put = [OSSPutObjectRequest new];
//
//    // required fields
//    put.bucketName = bucketName;
//    put.objectKey = @"oss_hello.pnb";
//    // progress
//    put.uploadProgress = ^(int64_t bytesSent, int64_t totalByteSent, int64_t totalBytesExpectedToSend) {
//        NSLog(@"%lld, %lld, %lld", bytesSent, totalByteSent, totalBytesExpectedToSend);
//    };
//
//    NSString *fPath = [self path4SavedImg];
//    NSURL *url = [NSURL fileURLWithPath:fPath];
//    put.uploadingFileURL = url;
//
//    OSSTask *putTask = [client putObject:put];
//    [putTask continueWithBlock:^id _Nullable(OSSTask * _Nonnull task) {
//
//        NSLog(@"\n\n我的输出！！！！\n%@",task.result);
//        NSLog(@"objectKey: %@", put.objectKey);
//        if (!task.error) {
//            NSLog(@"upload object success!");
//        } else {
//            NSLog(@"upload object failed, error: %@" , task.error);
//        }
//        return nil;
//    }];
//}
//
//
//-(NSString *)path4SavedImg{
//    UIImage *img = [UIImage imageNamed:@"oss_hello"];
//    NSData *imageData = UIImageJPEGRepresentation(img, 0.3);
//    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"tmp"] stringByAppendingPathComponent:@"oss_hello.pnb"];
//    [imageData writeToFile:fullPath atomically:NO];
//    NSString *uploadFilePath = fullPath;
//    return uploadFilePath;
//}


@end


//        回调网址
//        OSSTask *task2 = [client presignPublicURLWithBucketName:bucketName withObjectKey:@"oss_hello.pna"];
//        if (!task2.error) {
//            NSString *publicURL = task2.result;
//            NSLog(@"%@", publicURL);
//        } else {
//            NSLog(@"sign url error: %@", task2.error);
//        }
//
