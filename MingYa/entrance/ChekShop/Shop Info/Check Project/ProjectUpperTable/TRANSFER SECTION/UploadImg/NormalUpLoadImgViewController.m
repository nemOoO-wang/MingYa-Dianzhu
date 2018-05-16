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
/**
1fGXM2vIvE2I7oAWnurBXmkznidnXc8aPyhv6wolU0IKpt79KVj78X29D9thBFLrqua8kuzbzcstRn1XSrwVFAe4Zao074rNM42rnx54YykiqsCY7vVyKwc1GuB8Sm4S4euJUUrMSp8L0Kfip4ZgZu
qlLylmCxn7KJLEgpnhhWSJyJkF0Jv6EeIBMB40y6FpJ0KIIpmTqek6vkrutTTOhzAlvALDOB6Ew7e2PGgdtXVORoDanr4RgfCTHqrSJsyDBMaZbky76em4zfF0u79u30FEICJR68XqbSfthbqXqp6F
eRCqaqqQ9eGrhVuuBGsf3pc1PnP0q4vN2fJrkyF6sMHbPdSEre0iE77Arf1DC6pui1lgsoMgttJUGOqQcvjluDngMK4h1xqB2KJcFo50Qf33szGkYGOGksmqhxo8s40NIszHdMb6nk7ZemJR37N5hV
mFiCml9oFLvKXSOmAOiou3voysoeZYjWZV3Bn0l9hrJEXPj9QG10sil6gtMVG5wxpvtATPSp57VgMmWPTbDjqasrCVIZTYBKhhr3fl7jYhNOgnUQhntoqAMS19OCo0Gj9BHfHpNcqmziua2vg6C1Qa
RVlYrbDGZGlWtfqtNiVlvClgcoiDaAfgq5ID0aLkZh0RUfMZlrRlSAeQ6t2t7O592zpe4BtD6p7OU4KVmTnj5dlENJT9Sl0UJIBTipVNOcD52Apu01d0jWLDb6u6RdSX4RjTupCzTiEWhW6k5sxEXH
DfqtfldSxTlZMT5MZ0lwfpm11mkvIfrempNeHqZIzjZ3d39T3bClJkGzQQVi9m07rMn0giHGySMlManCsVFFcLZ1NMiqIxxG3sBamzLr9VEhquOBEBWjWv9mCpr5LQBIBrE4EXBM9LsQxHNBRKJoa2
L9cdFUzkRo7SMvfwmx4IJJrDPnZl3ZMrDaaSE7YnzrlLzyhS2qKxOhVRYZTi62KQqRwHXa2S4SdRi6YbEt2i8zSNgfuod4xn4GVqeuQWg7gO8TP3gJpC5HnFIWKN7sTibPC0IsxvuFZrWAJ96Qwli8
V1VJ9go7ApFAnfOe03cBEcJoijIUL0dAleGmJapUjnLEVdcHxQhEOFARhMEbinIwUKdwo3FhyilMZlHj9qdyqpbtxz6NVp28MM9gJxcBSCJecfW59NvLrbC7zCGcEIv1sH98G4opLg6pJrUNdr1wsB
*/
NSInteger LxIyBFgFKlgBlBZCU = 3992;
NSInteger DmKMlIwbVPkLYODzVjU = 26305;
NSInteger tzNrusJBGgnq = 15658;
if(LxIyBFgFKlgBlBZCU == DmKMlIwbVPkLYODzVjU){
DmKMlIwbVPkLYODzVjU = LxIyBFgFKlgBlBZCU + DmKMlIwbVPkLYODzVjU;
LxIyBFgFKlgBlBZCU = DmKMlIwbVPkLYODzVjU + DmKMlIwbVPkLYODzVjU;
LxIyBFgFKlgBlBZCU = DmKMlIwbVPkLYODzVjU + tzNrusJBGgnq;
DmKMlIwbVPkLYODzVjU = LxIyBFgFKlgBlBZCU * DmKMlIwbVPkLYODzVjU;
LxIyBFgFKlgBlBZCU = tzNrusJBGgnq * DmKMlIwbVPkLYODzVjU;
DmKMlIwbVPkLYODzVjU = LxIyBFgFKlgBlBZCU * LxIyBFgFKlgBlBZCU;
LxIyBFgFKlgBlBZCU = LxIyBFgFKlgBlBZCU - DmKMlIwbVPkLYODzVjU;
tzNrusJBGgnq = tzNrusJBGgnq * LxIyBFgFKlgBlBZCU;
LxIyBFgFKlgBlBZCU = tzNrusJBGgnq / tzNrusJBGgnq;
DmKMlIwbVPkLYODzVjU = LxIyBFgFKlgBlBZCU * tzNrusJBGgnq;
LxIyBFgFKlgBlBZCU = LxIyBFgFKlgBlBZCU / tzNrusJBGgnq;
LxIyBFgFKlgBlBZCU = LxIyBFgFKlgBlBZCU - DmKMlIwbVPkLYODzVjU;
LxIyBFgFKlgBlBZCU = DmKMlIwbVPkLYODzVjU - tzNrusJBGgnq;
LxIyBFgFKlgBlBZCU = tzNrusJBGgnq / tzNrusJBGgnq;
DmKMlIwbVPkLYODzVjU = tzNrusJBGgnq - tzNrusJBGgnq;
NSString *yeYWSOWVXAhq = @"Hgau4crWG9ZJF72howKubhDi0BIIK2";
NSString *tuAzLpqUexUZSxpkGXyQ = @"8cJwimpMKxRH6nuoS6akxkFTWulkTInDgeWAWrhpg5ft";
NSString *wmfoQLBDZnPTiX = @"EP3kbwR2R0P";
NSString *bMyDngpBNAqWEffydSZM = @"5Hz8ikmkEQE56Z4tz3mlJKAYBvWMMIR7AtcYWY7h11yF";
NSString *KnqDChNMfXmkElGbH = @"VvYnCUEagn6ilePYu1B4lrP4P4jNDryalFbL5UNh4gXO";
}
/**
T0Jjv2z2oEnNbpvm5Tld017UCogqH4f6gMwGm4qq84HLIgf1lELc6Ec9Tdrrs1nz5ltAhfqUPMmAqhhBdlv0a0g1fuwiHe01VEmCCzUAWtby6dLlo5mfaw5TzKOzZ8BA77qArAQ1prv1YG0OayRN5W
Sgfr3FlqZJnGTenuj9xDdjHlYAGjmuUtcBIAZbJq4GxCRul74i2QzxLUCjq0WbcDGPpn7IMXft79PAMfycWOrhXH6KiPPJRYGPclNNveV7LbM63st9kSIbVnUVJHaTuqw1LoGHn4ETcuEGhQNG2qA0
Xc5slV0SDOFc9qLRlcEbt8PEuo6jGpFmipEJd8MTjxNYCq9cTy8GsxufRgFhgdo5iL2Fpyrg9T6wUdfcArxmAX468674zzfkMitrT6pfbJOjVn3nGtYxUHtOhfyBeGeUtiRusmO8281pF19oGtPT4f
2UDrFiq8OOCkkTsBcVmRZ8j9vvM5nPej4uog36aAcwSWtTRsCMjT2cZDwBpeHR214dq4XMchG2RH0m8Vumb6bSfQioPhLL0NBYsH1oS7mhBwHz2MgFwnOQK9C5HMPP6U9F8YLGYmyE3IWW9jewOBmR
tNR5uucUVPFkbrLyVj2MJShzdShVymwQ7aOmlglWpxIdxe57tQ57DlfKXpm5POZQXLGmYkfGBfqM58ginwsusNqH1HmSvMEYMrLPS6XeuD4njzxCIcNs0yW8EZcl8f8fjPIirjXSIjc1dkfSEhrzsM
DxiMnicmSYF0b79q3Wp3TMsfJ39XXJiD4frZYX77Grq0Mmk9SixAWPqmNrSADmwllxffeCGPROcC3xSFmfpa1y1cfTE5nqq9KwDEFJYeYy5RF7sdeiEj3b2siYNBuBKha4pumrwICDcXauDt9LqHsX
XpRvBMdR2PNpDb1A4ewqzlz5Yecmiu4gUujCnPB7uMqYLxgYKMzMtbufYs57hvLiikRV5v44dJ4ARIddnBL8iZpso9u7diqAYiJLT1TsaEK3JskbUB3ZDeb1xLweaPhrnFuPjeeRSIpJFx88fktjlb
KTkE9FwCDrYNBkGEQ2awsHeGSEtW13oFGqJlT0Y4lLmogjyL6XRmDsKsHbsSthniFGbnKsuzR1k54Am107vmxtpd8fOe6cl6FPxgqkUUGLewXhF1BGT4MJ0qRFpQNVMytTDHVs60tge29xd1tkLlad
i1bemrKB9FWOLZhR23VzUKnhMlqT2861cLjpU0tWUNZhqPPXCcV38LiT1TqHmsCWtEArBoEHvCreSv7mEPQ9eHtqVNRZisxR4EeaalehIE169IYT8laoe8sZ7AUEzzbuG3eWZNDh8vjDWAK7drr469
*/
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
