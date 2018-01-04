//
//  NormalUpLoadImgViewController.m
//  MingYa
//
//  Created by 陈必锋 on 2017/10/19.
//  Copyright © 2017年 镓洲 王. All rights reserved.
//

#import "NormalUpLoadImgViewController.h"
#import "AliOSSKit.h"
#import "MYUser.h"
#import <SVProgressHUD.h>
#import <AFNetworking.h>

@interface NormalUpLoadImgViewController () <ImageShowCollectionDelegate, AliOSSKitDelegate>
@property (nonatomic,strong) AliOSSKit *aliKit;
@property (nonatomic,assign) NSInteger sentTimeToday;

@end

@implementation NormalUpLoadImgViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.collectionView.imgDelegate = self;
    if (!self.sectionName) {
        //  container 中出现
        self.maxImgCount = 9;
        if (!self.isCommitCompleteViewController) {
            // 【施工中】
            [self updateSubmitTime];
        }
    }
    [self submitBtnAttrStrWithMaxCount:self.maxImgCount andNowCount:0];
    
    //配置基础设置
    NormarlUploadVCSetting* setting = [NormarlUploadVCSetting normalSettingWithVCTitle:self.sectionName andSectionCount:1 andNumberOfItemInLine:4 andLineSpace:5 andItemSpace:5 andCanEdit:YES andIsShowNetImg:NO andInsets:UIEdgeInsetsMake(0, 5, 0, 5)];
    [self.collectionView setupWithNormalSetting:setting];
    // 配置 title
    self.title = self.sectionName;
    
    // ali kit
    self.aliKit = [[AliOSSKit alloc] init];
    self.aliKit.delegate = self;
}


-(void)submitBtnAttrStrWithMaxCount:(NSInteger)maxCount andNowCount:(NSInteger)nowCount{
    // str
    NSString *shownStr;
    if (self.sectionName) {
        //  有设置 name，作为单独的 controller 出现，否则在「施工」的 container 中出现
            shownStr = [NSString stringWithFormat:@"提交\n图片数量(%ld/%ld)",nowCount,maxCount];
    }else{
        // 在 container 中显示
        if (self.isCommitCompleteViewController) {
            // 最后一次提交
            shownStr = @"提交\n完成施工";
        } else{
            // 每日三次
        shownStr = [NSString stringWithFormat:@"提交\n每天可上传次数(%ld/3)",self.sentTimeToday];
        }
    }
    // font style
    NSMutableParagraphStyle* paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    [paragraphStyle setLineSpacing:5];
    [paragraphStyle setAlignment:NSTextAlignmentCenter];
    NSDictionary* attrs = @{NSFontAttributeName:[UIFont systemFontOfSize:16],
                            NSForegroundColorAttributeName:[UIColor whiteColor],
                            NSParagraphStyleAttributeName:paragraphStyle};
    NSMutableAttributedString* attrStr = [[NSMutableAttributedString alloc]initWithString:shownStr attributes:attrs];
    [attrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:NSMakeRange(3, attrStr.length - 3)];
    [self.submitBtn setAttributedTitle:attrStr forState:UIControlStateNormal];
}


-(void)updateSubmitTime{
    NSString *token = [[MYUser defaultUser] token];
    NSDictionary *paramDic = @{@"token":token, @"method":@"getStatus", @"page":@0, @"keyWord":self.projectId, @"searchValue":@3};
    [[BeeNet sharedInstance] requestWithType:Request_GET andUrl:@"getList" andParam:paramDic andHeader:nil andSuccess:^(id data) {
        // success
        self.sentTimeToday = [data[@"data"] integerValue];
        [self submitBtnAttrStrWithMaxCount:self.maxImgCount andNowCount:0];
    } andFailed:^(NSString *str) {
        // fail
    }];
}

#pragma mark - ImageShowCollectionDelegate
-(void)didSelectCountAtSection:(NSInteger)section andCount:(NSInteger)count inCollectionView:(ImageShowCollectionView *)collectionView{
    [self submitBtnAttrStrWithMaxCount:self.maxImgCount andNowCount:count];
}

-(NSInteger)maxItemCountAtSection:(NSInteger)section inCollectionView:(ImageShowCollectionView *)collectionView{
    return self.maxImgCount;
}

# pragma mark - <AliOSSKitDelegate>
-(void)aliKitFinishUploadImgswithNameArr:(NSArray *)imgNameArr{
    [SVProgressHUD dismiss];
    [SVProgressHUD showWithStatus:@"后台通信中..."];
    
    // request
    NSString *token = [[MYUser defaultUser] token];
    NSString *uId = [[MYUser defaultUser] userId];
    // get jpgs' strings
    NSMutableString *contentUrl = [[NSMutableString alloc] init];
    NSMutableString *contentSuffix = [[NSMutableString alloc] init];
    NSMutableString *contentName = [[NSMutableString alloc] init];
    for (NSString *tmpStr in imgNameArr) {
        [contentUrl appendString:[NSString stringWithFormat:@",%@",tmpStr]];
        [contentSuffix appendString:@",jpg"];
        // content name tmp str
        NSString *tmpSubStr = [tmpStr stringByReplacingOccurrencesOfString:@".jpg" withString:@""];
        tmpSubStr = [[tmpSubStr componentsSeparatedByString:@"/"] lastObject];
        [contentName appendString:[NSString stringWithFormat:@",%@",tmpSubStr]];
    }
    NSRange firstCharRange = NSMakeRange(0, 1);
    [contentUrl deleteCharactersInRange:firstCharRange];
    [contentSuffix deleteCharactersInRange:firstCharRange];
    [contentName deleteCharactersInRange:firstCharRange];
    if (self.sectionName) {
        // 「view controller」
        NSDictionary *paramDic = @{@"token":token, @"detailId":self.detailId, @"userId":uId, @"contentName":contentName, @"contentSuffix":contentSuffix, @"contentUrl":contentUrl, @"projectId":self.projectId, @"sc":[NSNumber numberWithInteger:self.sc]};
        // net
        [[BeeNet sharedInstance] requestWithType:Request_POST andUrl:@"project/detailSpeed" andParam:paramDic andHeader:nil andSuccess:^(id data) {
            // success
            [SVProgressHUD showSuccessWithStatus:@"上传完成！"];
            [SVProgressHUD dismissWithDelay:0.5];
            [self.navigationController popViewControllerAnimated:YES];
        } andFailed:^(NSString *str) {
            // fail
            [SVProgressHUD showErrorWithStatus:@"出了点问题？"];
        }];
    }else if(self.isCommitCompleteViewController){
        // 最后提交施工 （施工完毕）
        NSString *url = [NSString stringWithFormat:@"constructioni/AppInsert?token=%@",token];
        NSDictionary *loLDic = @{@"constructionName":contentName, @"constructionSuffix":contentSuffix, @"constructionUrl":contentUrl, @"constructionType":@2};
        NSArray *loList = @[loLDic];
        NSDictionary *paramDic = @{@"projectId":self.projectId, @"loList":loList};
        [[BeeNet sharedInstance] requestWithType:Request_POST andUrl:url andParam:paramDic andHeader:nil andRequestSerializer:[AFJSONRequestSerializer serializer] andResponseSerializer:[AFJSONResponseSerializer serializer] andSuccess:^(id data) {
            // success
            [SVProgressHUD showSuccessWithStatus:@"项目完成！"];
            [SVProgressHUD dismissWithDelay:0.5];
            [self.collectionView clearDatas];
            if ([self.delegate respondsToSelector:@selector(finishTheWholeProject)]) {
                [self.delegate performSelector:@selector(finishTheWholeProject)];
            }
        } andFailed:^(NSString *str) {
            // fail
            [SVProgressHUD showErrorWithStatus:@"失败"];
            NSLog(@"%@",str);
        }];
    }else{
        // 施工中图片
        NSString *url = [NSString stringWithFormat:@"constructioni/AppInsert?token=%@",token];
        NSDictionary *loLDic = @{@"constructionName":contentName, @"constructionSuffix":contentSuffix, @"constructionUrl":contentUrl, @"constructionType":@1};
        NSArray *loList = @[loLDic];
        NSDictionary *paramDic = @{@"projectId":self.projectId, @"loList":loList};
        [[BeeNet sharedInstance] requestWithType:Request_POST andUrl:url andParam:paramDic andHeader:nil andRequestSerializer:[AFJSONRequestSerializer serializer] andResponseSerializer:[AFJSONResponseSerializer serializer] andSuccess:^(id data) {
            // success
            [SVProgressHUD showSuccessWithStatus:@"上传完成！"];
            [SVProgressHUD dismissWithDelay:0.5];
            [self updateSubmitTime];
            [self.collectionView clearDatas];
        } andFailed:^(NSString *str) {
            // fail
            NSLog(@"%@",str);
        }];
    }
}


- (IBAction)submitBtnClick:(id)sender {
    if (!self.sectionName && !self.isCommitCompleteViewController) {
        // 「施工中最大次数」
        if (self.sentTimeToday >= 3) {
            [SVProgressHUD showErrorWithStatus:@"最多三次"];
        }else{
            [self.aliKit pushImgsAutoSetName:[self.collectionView imgsOf1stSection]];
            [SVProgressHUD showWithStatus:@"上传图片中..."];
        }
    }else{
        [self.aliKit pushImgsAutoSetName:[self.collectionView imgsOf1stSection]];
        [SVProgressHUD showWithStatus:@"上传图片中..."];
    }
}
@end
