//
//  FileDownloadOrOpenViewController.m
//  MingYa
//
//  Created by 陈必锋 on 2017/10/23.
//  Copyright © 2017年 镓洲 王. All rights reserved.
//

#import "FileDownloadOrOpenViewController.h"
#import "FileUtils.h"
#import <SVProgressHUD.h>

@interface FileDownloadOrOpenViewController () <NSURLSessionDownloadDelegate>

@property (nonatomic) BOOL isDownloading;
@property (strong,nonatomic) NSURLSession* urlSession;

@property (strong,nonatomic) UIDocumentInteractionController* documentCtrl;
@end

@implementation FileDownloadOrOpenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.downloadProgress.transform = CGAffineTransformMakeScale(1, 2.5);
    
    self.title = self.itemModel.fileName;
    [self.fileImgView setImage:[UIImage imageNamed:self.itemModel.fileIconBigImgName]];
    [self.fileNameL setText:self.itemModel.fileName];
    
    [self configViewController];
}

-(void)configViewController{
    BOOL isFinishDownload = [self.itemModel isFinishDownload];

    [self.downloadProgress setProgress:0];
    [self.progressL setText:@"0/100"];
    
    self.downloadProgress.hidden = YES;
    self.progressL.hidden = YES;
    self.cancelDownloadBtn.hidden = YES;
    
    if (isFinishDownload) {
        self.beginDownloadOrOpenBtn.hidden = NO;
        [self.beginDownloadOrOpenBtn setTitle:@"用其他应用打开" forState:UIControlStateNormal];
    }else{
        self.downloadProgress.hidden = !self.isDownloading;
        self.progressL.hidden = !self.isDownloading;
        self.cancelDownloadBtn.hidden = !self.isDownloading;
        self.beginDownloadOrOpenBtn.hidden = self.isDownloading;
        
        if (!self.isDownloading) {
            [self.beginDownloadOrOpenBtn setTitle:@"开始下载" forState:UIControlStateNormal];
        }
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - NSURLSessionDownloadDelegate
-(void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite{
    double progress = (double)totalBytesWritten/totalBytesExpectedToWrite;
    NSLog(@"progress:%f",progress);
    [self.downloadProgress setProgress:progress animated:YES];
    [self.progressL setText:[NSString stringWithFormat:@"%.0f/100",progress*100]];
}

-(void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location{
    NSLog(@"did finish downloading to url:%@",location);
    if ([(NSHTTPURLResponse*)downloadTask.response statusCode] == 200) {
        NSString* filePath = [FileUtils filePathWithFileName:self.itemModel.fileUrl andFileName:self.itemModel.fileName];
        
        // 将临时文件剪切或者复制Caches文件夹
        NSFileManager *mgr = [NSFileManager defaultManager];
        [mgr moveItemAtPath:location.path toPath:filePath error:nil];
        
        self.itemModel.isFinishDownload = YES;
        self.itemModel.fileLocalUrl = filePath;
    }else{
        [SVProgressHUD showErrorWithStatus:@"网络连接错误，下载失败！"];
    }
    
    self.urlSession = nil;
    
    self.isDownloading = NO;
    [self configViewController];
}



- (IBAction)cancelDownloadBtnClick:(id)sender {
    [self.urlSession invalidateAndCancel];
    self.urlSession = nil;
    self.isDownloading = NO;
    [self configViewController];
}

- (IBAction)beginDownloadOrOpenBtnClick:(id)sender {
    if([self.itemModel isFinishDownload]){
        self.documentCtrl = [UIDocumentInteractionController interactionControllerWithURL:[NSURL fileURLWithPath:self.itemModel.fileLocalUrl]];
        [self.documentCtrl presentOpenInMenuFromRect:self.view.bounds inView:self.view animated:YES];
    }else{
        if (!self.isDownloading) {
            self.isDownloading = YES;
            
            NSURL* url = [NSURL URLWithString:[self.itemModel.fileUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
            self.urlSession = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue mainQueue]];
            NSURLSessionDownloadTask* downloadTask = [self.urlSession downloadTaskWithURL:url];
            [downloadTask resume];
            [self configViewController];
        }
    }
}
@end
