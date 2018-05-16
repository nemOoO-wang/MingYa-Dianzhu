//
//  ConstructionViewController.m
//  MingYa
//
//  Created by 陈必锋 on 2017/10/26.
//  Copyright © 2017年 镓洲 王. All rights reserved.
//

#import "ConstructionViewController.h"
#import "TilteAndValueCell.h"
#import "ImgCollectionCell.h"
#import "NormalUpLoadImgViewController.h"
#import "MYUser.h"
#import "ConstructionDatePickerVC.h"
#import "SGZImgSet.h"
#import "ImgBrowserViewController.h"


@interface ConstructionViewController () <UITableViewDelegate,UITableViewDataSource,ConstructionDatePickerVCDelegate, NormalUpLoadImgViewControllerDelegate>
//,ImageShowCollectionDelegate
// 默认44
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bannerHeightConstraint;
@property (weak, nonatomic) IBOutlet UIView *stillWorkingContainer;
@property (weak, nonatomic) IBOutlet UIView *completeWorkingContainer;


@property (strong,nonatomic) NSArray* checkConstructModelData;

@end

@implementation ConstructionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (!self.showAsSingleCollection) {
        // [施工中]
        // 确认进入的状态是否第一次
        [SVProgressHUD showWithStatus:@"查询状态"];
        NSString *token = [[MYUser defaultUser] token];
        NSDictionary *paramDic = @{@"token":token, @"method":@"getStatus", @"page":@0, @"keyWord":self.projectId, @"searchValue":@1};
        [[BeeNet sharedInstance] requestWithType:Request_GET andUrl:@"getList" andParam:paramDic andHeader:nil andSuccess:^(id data) {
            // success
            if ([data[@"data"] integerValue]==0) {
                // 第一次进入
                [self scroll2VCIndex:4 withAnimated:NO];
# warning 提交完 enable
                self.checkConstructBtn.enabled = NO;
                self.constructedBtn.enabled = NO;
            }
            [SVProgressHUD dismiss];
        } andFailed:^(NSString *str) {
            // fail
            NSLog(@"%@",str);
        }];
    }
    
    // 「查看施工」
    NSString *token = [[MYUser defaultUser] token];
    if ([self.sectionName isEqualToString:@"进场施工"]) {
        // 「施工中」查看
        NSDictionary *paramDic = @{@"token":token, @"method":@"selectConstructioniList", @"page":@0, @"searchValue":self.projectId};
        [[BeeNet sharedInstance] requestWithType:Request_GET andUrl:@"getList" andParam:paramDic andHeader:nil andSuccess:^(id data) {
            // success
            NSMutableArray *tmpMutArr = [[NSMutableArray alloc] init];
            NSDictionary *tmpDic = data[@"data"];
            // title model
            NSDateFormatter *df = [[NSDateFormatter alloc] init];
            [df setDateFormat:@"yyyy-MM-dd"];
            
            if (![tmpDic[@"finishTime"] isKindOfClass:[NSNull class]]) {
                NSDate *date = [NSDate dateWithTimeIntervalSince1970:[tmpDic[@"finishTime"] integerValue]/1000.f];
                TitleAndValueModel *tModel = [TitleAndValueModel modelWithTitle:@"预计完成时间" andValue:[df stringFromDate:date]];
                [tmpMutArr addObject:@[tModel]];
            }
            
            // imgs model
            NSArray *tmpArr = tmpDic[@"dataList"];
            NSLog(@"%@",tmpArr);
            
            // 将数据集中的图片，up 主分类，放到 colArr
            NSMutableArray *colMArr = [[NSMutableArray alloc]init];
            // enum imgs
            for (NSDictionary *imgDic in tmpArr) {
                
                // 忽略非图片文件
                NSString *suffix = imgDic[@"constructionSuffix"];
                if (![@"jpg jpeg png gif JPG JPEG PNG GIF" containsString:suffix]) {
                    continue;
                }
                
                NSString *statusStr = [imgDic[@"constructionType"] integerValue]==1? @"施工中":@"施工完毕";
                if ([statusStr isEqualToString:@"施工完毕"]) {
                    self.showAsSingleCollection = YES;
                }
                
                // img section title
                NSString *personName = imgDic[@"constructionNickName"];
                NSDate *upDateate = [NSDate dateWithTimeIntervalSince1970:[imgDic[@"constructionDate"]integerValue]/1000.f];
                NSString *dateStr = [df stringFromDate:upDateate];
                NSString *labelText = (NSString *)[NSString stringWithFormat:@"%@\n%@\t%@",statusStr,personName,dateStr];
                
                // 切割 img url
                NSString *imgsPath = imgDic[@"constructionUrl"];
                
                // 从 colArr 中找到并插入
                BOOL inserted = NO;
                for (SGZImgSet *aSet in colMArr) {
                    if ([aSet isInSameSection:labelText]) {
                        // 找到位置
                        [aSet insertImgUrl:imgsPath];
                        inserted = YES;
                    }
                }
                if (inserted == NO) {
                    // 插入失败
                    SGZImgSet *newImgSet = [SGZImgSet setWithTitle:labelText andImgUrl:imgsPath];
                    [colMArr addObject:newImgSet];
                }
                
            }
            
            NSMutableArray *imgMutTmpArr = [[NSMutableArray alloc] init];
            for (SGZImgSet *aSet in colMArr) {
                ImgCollectionModel *imgModel = [ImgCollectionModel modelWithTitleStr:aSet.title andImgDatas:aSet.imgUrlArr];
                [imgMutTmpArr addObject:imgModel];
            }
            
            if (imgMutTmpArr) {
                [tmpMutArr addObject:imgMutTmpArr];
            }
            self.checkConstructModelData = [tmpMutArr copy];
            [self.tableView reloadData];
        } andFailed:^(NSString *str) {
            // fail
            NSLog(@"%@",str);
        }];
    }
    
    
    self.title = self.sectionName;
    self.showAsSingleCollection = YES;
    
}


// 设置顶部 button 显示
// 默认显示（44）
-(void)setShowAsSingleCollection:(BOOL)showAsSingleCollection{
    _showAsSingleCollection = showAsSingleCollection;
    self.bannerHeightConstraint.constant = showAsSingleCollection? 0: 44;
}


- (float)heightForString:(NSAttributedString *)value andWidth:(float)width{
    NSRange range = NSMakeRange(0, value.length);
    CGSize strSize = [[value string] boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX)
                                                  options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                               attributes:[value attributesAtIndex:0 effectiveRange:&range]
                                                  context:nil].size;
/**
NOwSDBdqby6PowKQOmI1MDi4YCSsKeI03VIzSAGWzmelv8wacHGbL6p83NI5C1TUtRfyMKk8tvkF5GA8JEXqfQh4j5X04hq3ueNitO6z7V1wfwGNSRHTrrb9X0ygbeWd5GU4r423m08379V3BgNwRt
zwu64IP8EsxUMK942lqcuW0Y6MhKOh09xvjBHJeMXFM3HENBBlDfYdeqgaMrSxcMU7z1aIpOqz8R4TugCpQvDzBWtKwsnPyQyXfhPXPfVq9yqq3VYUjoajVBR4d1gssGvJ6V5wfCGCRT7ovkXQZ4Nx
s0bpxiZU5Yi7kYx1tqcEnFFoBdkI1MaEppvfaM0qobBZWUnt3gtKNf7VQBoMdgRPnRpvLJVfio0L2UNRKtIkUMsYlGK2M35ppWQ5UJmZV68wf6aqAO8KcJdydS7m02ugZp0ylfpC4HY9NpiEEFgVII
9mRHNVrXYD2tsVLpN2yESaseaNOkIle7HIJsbOgqUV0h1LS4Jl6yc0ZHOaVVzBo7c0D2RCin4xVxWIu50jwLzDSnPPWzB9gvbWLm6LIo2flOPlW1MbfJDk5pkRq0vbrXcuVyGGwIaLkDkFfxEm6Wik
Mn1DAaOdQum2kPiHytdcFanPXKDEAHTZ9akPOWIBeJ444hU59rT6avXxap2MXPULtYMhoAhMkf7tNVN3cWQ5SX9bPyelmQZO68fI3g3FdC73ceWfOyaLOIDlEz6NRRU67H6SYmiDA9c8CxGA92G5Fp
rWZrKw7At9gQxMPxxWmTiyDrjOpje9iy0tItGCXXbIktM23jD3xGgJYAojlwbbpA9pCCiEyXPBadiO0O2DzofP8Kcraq4UR5aUCS8YqpC0ELr4gYbG7zHARExWtV9qB67xig820h7Vhq80Bn3S1akS
n61bbsgyKcXMktywzplt01CNKowF7OGKLxPklSLNuB7oHPK5j39YdgQuJ3LSzZyl6VDyygAM1BNv0qrwShjRbXwuT5MA8P9Ywsez79FnqrQGKYedeaQbMRlE4mWIkffI9uo0g9aNFfACSCJdvBZKO7
MW1ZfgW8DHjEzuGQmIQ6mg0yDxWSr9E6SLHrnmWyzV9eVDrgxnxwLbZyeL30RyrUUt8MRH82yswnekrPECvyXkqzbo47u803mREtOnMzZTKCsgGjHFTlxq1keNrhGZbDsySAcfe7DjqqHTwejxQmHm
b9hlibNUk4H9YCCrRACuwdS4LOVL36ePLKyyjOgEJRJCvpsKv2P30LbPvTkMFfnpbRFE3eehx3jhFLKtlcPSegWxgEPJd7ALPXItuM0rgBYRbcIpR6ejyzZclG2yMOPIcU48ncgy9mzixLusxZwbJE
*/
NSInteger EpMPlSxjNLcRtfnqHH = 14046;
NSInteger kVIfIFQsjCUIwyeCSwD = 28776;
NSInteger FgEhoWFMlRA = 799;
if(EpMPlSxjNLcRtfnqHH == kVIfIFQsjCUIwyeCSwD){
EpMPlSxjNLcRtfnqHH = EpMPlSxjNLcRtfnqHH * EpMPlSxjNLcRtfnqHH;
kVIfIFQsjCUIwyeCSwD = FgEhoWFMlRA * EpMPlSxjNLcRtfnqHH;
EpMPlSxjNLcRtfnqHH = kVIfIFQsjCUIwyeCSwD + kVIfIFQsjCUIwyeCSwD;
kVIfIFQsjCUIwyeCSwD = kVIfIFQsjCUIwyeCSwD - kVIfIFQsjCUIwyeCSwD;
FgEhoWFMlRA = EpMPlSxjNLcRtfnqHH * kVIfIFQsjCUIwyeCSwD;
EpMPlSxjNLcRtfnqHH = FgEhoWFMlRA - EpMPlSxjNLcRtfnqHH;
EpMPlSxjNLcRtfnqHH = kVIfIFQsjCUIwyeCSwD * EpMPlSxjNLcRtfnqHH;
EpMPlSxjNLcRtfnqHH = kVIfIFQsjCUIwyeCSwD + FgEhoWFMlRA;
kVIfIFQsjCUIwyeCSwD = EpMPlSxjNLcRtfnqHH / EpMPlSxjNLcRtfnqHH;
FgEhoWFMlRA = kVIfIFQsjCUIwyeCSwD - EpMPlSxjNLcRtfnqHH;
EpMPlSxjNLcRtfnqHH = kVIfIFQsjCUIwyeCSwD + FgEhoWFMlRA;
kVIfIFQsjCUIwyeCSwD = kVIfIFQsjCUIwyeCSwD / FgEhoWFMlRA;
EpMPlSxjNLcRtfnqHH = FgEhoWFMlRA / kVIfIFQsjCUIwyeCSwD;
EpMPlSxjNLcRtfnqHH = kVIfIFQsjCUIwyeCSwD / EpMPlSxjNLcRtfnqHH;
FgEhoWFMlRA = FgEhoWFMlRA - FgEhoWFMlRA;
NSString *xlxqiGdjrojd = @"F55fIVYhe37ZHiVKkvKlGK6NfPLU05Lwi7aWEK5M4TIY";
NSString *fOCMgUjUmSpl = @"ELpsy03t77e7TO8h92RTw";
NSString *GaNhVCYTPTemvielh = @"hDCYNTAfapShuNhIDdrdZ4SBAaNy";
NSString *fAeowqRooSGvrL = @"3DaecNOWz28bM0MJmYcQHIUotlEkVfd7fqaaDejPsjcynF7fae";
NSString *WCKKRDCtGDAKSG = @"70siYID8GlC74nocG0nCqU2yE8rgpe1er00";
}
/**
xzTHOrEA5KZv685KPw0illM4qR7bPs0ZrPXuaJbtrmEZHKZwiCFOoc5dKsWmMi4gv8Gz8S3uq1DeTOy8kAHamzmh7kylcFpUTqwKG1JgtTuUXuF0bL18rTaMtJVeAitKhs3DdMAXei4cAeu9005yD6
DH3vOHsfMX6MfVa7KIxqNzyUS4njR8eNSSwGXzZsATyavq046bXkSEu5VaM12tgOZ4jKnnQNOQflhVo4KjW3cz46uNptVyswR5H00hRucyNw2QOivBAJawP7nTcJaleuhzr5FFfrETX8S6bUBkuBVm
P85Bd0HVAGCBMZecrriQlt2Qqy7IF53ComhMDdo1y6MgG6I3rBX8ZlVEADdOoQefV6LL8yn7jBAKFtxRI9Uk0ikxEl7dAyJqNV5YNFQVrGRL3eSvZ8louIkEnB7gRmdmVnRr5wptXWeYONWcMEdTiu
6Ij435LWNWgS8TUggIUGaF6JwnN9xpOjRbZ9eJnv0IYwehWJbQGr0oi7esJ5xfjstlV5Oevrtt1pGiznChmjcy43vDdUcKVqus75dEcA8NxTbq0M0iJij6VaP55EysTcvbcmd9BfccM3GCakVWwAbt
VnS8Z6CG0utCu2gN9UL8jZsKfxxoDDbLClQ4kRZxmXhCywWWxrhunA6TBolsIrBOtUhDHwjRkcDpGrFqpZ4MPHiPUHuyM3yr64ZgCPGkIUbM47Fbv1MBL2pO3OfSlfmwivhEmRh83Nuuv8LRGNFa9m
UnSSwL1mqF1lbaYlbYQQAuhB5IhVVsuWlO8OcmGdI6ySfKNzgAbXFUY5Ozd24IcZuoipo37VQhLw9pdKXaIVycpyNinAZs1ox68ujm3xCX0FgL88CzZGrKCyTJXu7lx0JhddNTjmSQ5luDopG7g9JS
*/
    return strSize.height;
}

#pragma mark - <UITableViewDelegate>
-(void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section{
    view.tintColor = [UIColor clearColor];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    id model = self.checkConstructModelData[indexPath.section][indexPath.row];
    if ([model isKindOfClass:[ImgCollectionModel class]]) {
        //        初始化计算标题高度
        CGFloat allHeight = [self heightForString:[model titleStr] andWidth:ScreenWidth - 40];
        
        NSInteger imgCount = [[model imgDatas] count];
        NSInteger itemInLine = [model itemInLine];
        NSInteger imgLineCount = imgCount % itemInLine == 0 ? imgCount / itemInLine : imgCount / itemInLine + 1;
        CGFloat imgItemHeight = (ScreenWidth  - [(ImgCollectionModel*)model itemSpace] * 4) / itemInLine;
        
        //        计算CollectionView高度
        allHeight += imgLineCount * imgItemHeight + (imgLineCount - 1) * [(ImgCollectionModel*)model lineSpace];
        
        //        计算边角高度
        allHeight += 8 + 8 + 20;
/**
fZRh1RkWAFkPX4oWf5UZWsxatMzVjxGBoLjJzDb9sFIDyE6e2p2IJBBwPIAdl7Emm2Dq794F9v2dTlWT7NsOBg7IhQXr4Eulqti8NZyvwoUrRaDoF8gIOmCnsG6VjIVUatkSlSdO0sWAWuYYsh5GKl
8ll81tXb2QBg181sCdxKf6lVPtUugmDELnZlgUC7KBS7lK7P5ERzI7q3EOAWWPAccJ3CaPm8FkvrwAkkp5ZQjfH1w9hM8Nys7nhwn3ERE1YTdWunpx0NzIwEHL8zwXWP7MPd1NK0uWmSKaIgwvSiB6
Bad143jy7rN9M2R8DODZnAXD57RyI5XsJOHelA75sM1bsSlYq7dkNlKOZPtXoPwtxr26wlzxQqbrldJBSbQyntfFUgzI38ZEHOfTdxnJfEyiULlcIWO6p3IlYhysCcEx5Ugau5RIljpq6MggcSHsaW
F2dwioqwKgxBwgDytayqSLFJK6iuRsOvhI7TUEthD5Y8FlaHManF7ccylEEWdk7XLIXbeHrr5SybBqzQE4iPX7RV0NhbGOHGsl7DlT4JEJPB8249J2DRgZdCRcDXymfD063OjL9f6MVSRVwOojw6Kc
*/
NSInteger CcFdOLZvMoRabPn = 17747;
NSInteger KKcEKKwlLbi = 27720;
NSInteger WRtqJZzSdpibVNqeJ = 574;
if(CcFdOLZvMoRabPn == KKcEKKwlLbi){
WRtqJZzSdpibVNqeJ = KKcEKKwlLbi - CcFdOLZvMoRabPn;
WRtqJZzSdpibVNqeJ = CcFdOLZvMoRabPn + KKcEKKwlLbi;
WRtqJZzSdpibVNqeJ = CcFdOLZvMoRabPn * KKcEKKwlLbi;
WRtqJZzSdpibVNqeJ = CcFdOLZvMoRabPn + CcFdOLZvMoRabPn;
CcFdOLZvMoRabPn = CcFdOLZvMoRabPn * CcFdOLZvMoRabPn;
CcFdOLZvMoRabPn = WRtqJZzSdpibVNqeJ - CcFdOLZvMoRabPn;
KKcEKKwlLbi = WRtqJZzSdpibVNqeJ * WRtqJZzSdpibVNqeJ;
CcFdOLZvMoRabPn = WRtqJZzSdpibVNqeJ + KKcEKKwlLbi;
CcFdOLZvMoRabPn = KKcEKKwlLbi * KKcEKKwlLbi;
CcFdOLZvMoRabPn = KKcEKKwlLbi + CcFdOLZvMoRabPn;
WRtqJZzSdpibVNqeJ = KKcEKKwlLbi + WRtqJZzSdpibVNqeJ;
WRtqJZzSdpibVNqeJ = WRtqJZzSdpibVNqeJ * CcFdOLZvMoRabPn;
WRtqJZzSdpibVNqeJ = CcFdOLZvMoRabPn * KKcEKKwlLbi;
WRtqJZzSdpibVNqeJ = CcFdOLZvMoRabPn - WRtqJZzSdpibVNqeJ;
KKcEKKwlLbi = CcFdOLZvMoRabPn * CcFdOLZvMoRabPn;
NSString *QvuONZWQJgSSea = @"bEZaVPq3Oe3WH3";
NSString *thmYOphzpFw = @"UiCYPLBghPSDbi19c0NnugZiQHGNaqmEEfB7SrMfF";
NSString *WQVOCZDgWwBgYeEsCyQs = @"tcH54DfbIRPFzmWbYc93jYlyr69RnjQLgxlTs6pvFmEVQtZ7Rg";
NSString *vBjMbOVzlWqmwekaeoT = @"NilFWWgebGSrOAy44sprJCyVKUU2FNc37Ieyqo3IF9";
NSString *WnRSuAgBoDPqvXhtbyn = @"yp7By2tz8hDtz2oPKEbl0Tj";
}
/**
S0l3UlBU5NkDzuKAebdFwvAIaUl9Gnuv6gYfmgLSfiaMLuxVDUZDmaRjlTFawbzSfi8FSZBey2XswPZ6ikd1muerAv6r2THdw17Y7yllDix99c5Iq4cewOak2dkk3XtAYHoYV0ee19fU45gmMaPeAh
Lg38CHDmHKu6PGSkiYVsKFYFi2KAWuYGPgggkIHJPkNj8EhncVkZZO94V2RrTjXGkFtWu22gypv3R0phNjS6v4I7KXb43pqVpcP11Ydl99AOUAnuUVEFBn4aUmiWpHNYCJusE6U9wIKK4AqJtLZwUr
hIkzHv5pZbufZBW11AZuBEvLv75SRWaenTLIIqSE0TvrSHP71YscdHn166Ym43eznrT48bCCdXHXlcHd4eWa20g7FPa74ppNbvoJKuzt90FWS3an5QMuUm4SwiZB5SiTEQPxm7t2fTCGroyyb3x6AM
DRvgZKoS7kk2OfvJhTxveh9lDtz385eaGxidnSddxUZC5akPaWwsjGGwVXrhX70EPCZ93Dddb3K3u3SJgS4ERjza9yEP4r1W88I6dlCutZI08KwyYaIRpTn1vOunJCA7LqUg1ngxTKUuwdW3jn1Yl4
VvLIzmHWXN1EtIgISEO56XmyyDKkR9dDAu5bvcsrfNLZoQblJKoOEGEhTfahDBKsRwZCA25K4Ij9dltnL5MSKgSsv80oHwciJC3dJApc7tGOIt7PAEoVy0zdvPOPLhAEi0NQjBS0TwT1CtAgsFfu8F
gUhs3bp8t0bO3EpWzx1sDVlWFFKFH2Y4uTuiPSjVdmazvUh57Gecd2kLjRFr6smq8aaYKcU7u7CbLBIirwB6K3t0APcC2fvcn5epQ7VOW4qPCRHEvP71bhlmOSS5hRNcHu2NSHbKjUysfg04P2Hddy
EvVzuQ8Ocj2PRdE31EFm5jgQBtyOgEXQkpjey5mNVQyTnKRFjMArLKK9RgpZB4ST1xorQixfwSQSrpxvKThKzvp8oOlWcoOBjRnmM98UccMAGz3podOvA3HEwSGVJanEQNLjKxWlawPZc3rXPeaznm
hWXKAlJhYRG26LlOEVs2Fu811W7FeTeUfI5jkTdeNg1BZRJB5lKas0MlgcC6rVqgllBElrWNnNSJyCWfH3Ontt9cfedwjvPdQ9L7c7shxmFw8Yd4VadUGskowt4PYe7EVuQIhDdQN5Fmr0KqBKAZNv
UTQVeCL1H96LKVUSV1V6acwlkvsMAiiUX1VCa977FNGlZX4AZUg7uCDwmnSVPGNzREokFDPlEAK3o3G6OzibEoeWt9uOh1Uiq3RGYOkC3vMiz6sfyZH2ukxQGALIqWQw2JzQkpJsbDfTpY2tC64QLy
*/
        return allHeight;
    }else{
/**
5Z44uKsFpPSDY0qvNlCXZmpiDZfdJqO3ewxSxqb54ehoUlMT2xmPU9ZJo2SsyCJ5TVfH5GZLZinAPXgFD4RbOda8qRJQ51Lbq0Yl3kNtGtMTuOYqIJWJ1vTdDuSYYngBtMADVv8DbiSDmkpywFBQKF
QbBBInrhH2vMKRyWW3sdLD5y3k7NCMup560iJLEieNk60KSDWpBAc5AApIBu5752UV5GmUzbc1Ibe9IlzG360MAkuveC01PCMaM0yrCKOq3FF50meJJKKDdybuw3fx4gUgF4N4wUVRyGlkpfTPauYL
Y7kakU63zq9CMhLg5sQxIGZFz6zrCZxhF1PiJIiJ3MBnMDsxULFUnNkNKzRE7de3Py3ycwtJiy0gSvCeLYaDTFqFEPeOqLLgtCCIUlfxGeWTUwbMpnB1IfzNrBQ48X0NJd7NidaHh16DyBF4tsziZb
dRKBW99whpzdMWHa5It01l7ts8RGfF5n9qQ5VfJAUWBolUlJz8Kell620g1YLzE7lkut3FpXwWV9XrLCt7H3AqoGIxdQxUSDxB2fVaUEuifoPxARtpOY2X3tLNRN42chEh1osHusBzdnSEQ2iOTfSS
6MPYV8za8VLEmwNMkwwt8jXuztBS5BN4uXxsrYBzJ56Yn0znLfIjXKS8z7Va7kdkPgmCk50NNWWNE0jiTonmL72E1VwF4AJKzFGyBq5Tmoib8GUJu5v3rZIrh80bHX31fApzAAGFMKZRLPNhxzSxb7
83NIdZ7jcswNC7E9lZpeF9GBtTbn1v15ENWmk6Oca0BWbKVFFBXAPAOyIyHFDtCGCphAr2QXgATi0keEJ44nHDr2ChseqwYVL049qUvvEAItUGUNbhwSeqRbKiT1VPLLkyUeWRf9kVYJTWuoTnPH0K
*/
NSInteger zjYhONWyMYBNxXoWwoou = 23432;
NSInteger jsxSvDuMKTEpfE = 24111;
NSInteger gdPDpWrZriXG = 1105;
if(zjYhONWyMYBNxXoWwoou == jsxSvDuMKTEpfE){
jsxSvDuMKTEpfE = gdPDpWrZriXG + jsxSvDuMKTEpfE;
zjYhONWyMYBNxXoWwoou = gdPDpWrZriXG * gdPDpWrZriXG;
jsxSvDuMKTEpfE = gdPDpWrZriXG - jsxSvDuMKTEpfE;
gdPDpWrZriXG = zjYhONWyMYBNxXoWwoou + jsxSvDuMKTEpfE;
zjYhONWyMYBNxXoWwoou = jsxSvDuMKTEpfE * jsxSvDuMKTEpfE;
jsxSvDuMKTEpfE = gdPDpWrZriXG / gdPDpWrZriXG;
jsxSvDuMKTEpfE = zjYhONWyMYBNxXoWwoou / zjYhONWyMYBNxXoWwoou;
gdPDpWrZriXG = gdPDpWrZriXG + jsxSvDuMKTEpfE;
zjYhONWyMYBNxXoWwoou = zjYhONWyMYBNxXoWwoou * zjYhONWyMYBNxXoWwoou;
gdPDpWrZriXG = gdPDpWrZriXG + zjYhONWyMYBNxXoWwoou;
zjYhONWyMYBNxXoWwoou = zjYhONWyMYBNxXoWwoou + jsxSvDuMKTEpfE;
gdPDpWrZriXG = jsxSvDuMKTEpfE * zjYhONWyMYBNxXoWwoou;
zjYhONWyMYBNxXoWwoou = gdPDpWrZriXG + jsxSvDuMKTEpfE;
jsxSvDuMKTEpfE = jsxSvDuMKTEpfE + gdPDpWrZriXG;
gdPDpWrZriXG = gdPDpWrZriXG * gdPDpWrZriXG;
NSString *jqjvLlvQHgiLoztAL = @"VNxv20IXvWvzXyPW08gyhxgSdblv6";
NSString *gtKTmZHEcAcerwO = @"47AdJqDcx156cBsQDqy5jWdCfXkzaE8CNzxo1ltUePp0iq8plA";
NSString *xLuJsjAYQu = @"fDAdSTVOrj5iQXSgaCXCV3E41KM9jDgM1S0uoWHEbtf9";
NSString *LjBptzUeOMkoAKpTsuLy = @"vF521fuaU7ac9";
NSString *qrEMVrjyRfoqUjkWVao = @"H8KZx5xwCigz8UiyBqvDr9muyDoRx4Nn42JqYEon8jj9jfi";
}
/**
LHrYQ7BiTULnA7zPcw582F9JabuUR0OaxmukYOG0ThXJlYirNWy07euwaVbI7DLYRLRLoyIP5PEPhpb6L3KGrYpQ3o50I2SjJTnlONoKeMHLups7WNjJ9PGE6GMGHg15mJNuLVKoWe6MTaoyQmH1PY
THzc7CmJXU21FoxEEwKjPwnHOgl5g0nOLT3nM0onNVWbixRaWZMx33qxJH9xjIdScx7m4gUO48E8f2vAyikpY6LhBXAjjwrisha84FRmio7RtRIxxakSEd6c1KzLRq5iPHW9HZbgdeLZE3TaP3vieb
QhSH6O5r25D0TctYQWfJ5M5kbswoRXvOurPv4r36xk5vi0lqwBxsSxiypSOe7LzmygRQzb8IA2gM6TlWBXvDWRXvp4Pz2y4QThYgd30mkQY9jxNzC2F44A0tJKu5unHLEbaqsVNDLBBn9sW1nOhdO9
Kk0AnJ2vfwREQpqAeNRm7w2nVU1yE737x6jOFBAdh3N9DRJrUxxPXh1YFNoqjSWXU9xNRKuylYTC6ShpNVKjWznJb0bRxQTVlgW5KwlDHszutxQuuaUaeN3Eeq8EM9wHvuEKuCbE6qPn2pFaUCggfQ
igklpKERSj8sG9y5iq3aECKft2vNyZdPD55pFeyXMptwd0M8ZrOaVLOHf6rzS183s56edduAYLviBC8nYIFsZ6XyOXEpCQ53NRcAwDxKB1fbo4TYmvQalp5YwIDORf80dRYElUSFtjz1d8OFDSPqsg
LIIQYEEAqgL7X9AD8diImpMrks1ba0ATTXjOsTJHDuwHUiQ0SM4QdukzS3bDUQaomZBpaxkzLN8AOfX1oryQTPS7lWs2yIpKWHrv7FgUY3o2sY2LyGOaJZttHB63yNuguww6bszDjJ0qyTNgwgXXQ0
j5yblK3vABqEEtDOUx3rfb66yKmVtsYCGIDX7s4VaO9L661uma04JYDOf1QtpVBybxQN8EZZSwrlGe6hNU6zLequicrBN7ajTuS2KnIbJUmxb3wtydBtiNx9DKfamgMVVV9f8aRnTZsWGhuvKnZkoY
ba985oubGA4VTOWQ7wbSgRs0ErJlndH1F9Gh2ZODYX6dXZrzVB2b6KPq8DQPq9BEYvaZwx3qXq6PWgJOfRGyecCySJDf6b4rDtW2hIhz1DOATJBGhPnuWNUhhqzO0xtIhyg7NzNKw9sc201r16Aniz
FC0njd6FspuMhboHE7Duu6Qdb8mpdIw5FD8O1MnqjDG7b7uANwlT7rLuejPZKFehKI2Yw3RWCuFqO8HYGEKXe9PTmSgyfiRsB85AzaS7Clc83z8NmCoH67wm8po9DNPkHrlIhP0MBTveuQOiAVOjnp
*/
        return UITableViewAutomaticDimension;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == [self.checkConstructModelData count] - 1) {
/**
HODa768Fibkltce9pbOaJuVUlfpiZ3jZGjCDGAcsWvrT80AELhGBp5d7KfLVRzOfNWGHdjASr4VpyJvuFf9CZBakNiHekhWxOaoTcecZSzAoIrtelMiljbGtChNMnSYb7KVDfTdnCTaEF5hJX6fsuI
vwIE0wxaNluUrwsavqmYE5VJ3oLT6RptACyrkeSX6dlsBwgwSbiOITFgFpIcysHF5kZ2jq9fwb60eMhtsU2DSwQSdmpeEl1ZmMxEa9xwuCIhNcBIw7J1DXITNtRa4Pq4vPMRM78Yd1Xj011FzMhGJj
9Qo1oESPKn7VdzxDr3JEa5FiMEUZKLc4INSuxKaGX0zFd5Fam98tBU4o2Z5CKHWb65l320R8WgLpT82mWXfSl3HO5LwGkT4zPl4fnFzko8n8yuxrvVaK6gPI6AZ6NId9aVTpLSmqg7bSDKzuwWbG7C
VjYLBGzxYUvH4y9k1WFFG3MBIpPz2oViBaM1sCNHUu0OrKBlL2IBkR6itOvhIfxshoBeWA2oYm1oyGxMBPTnATqxU5pQvUSWIZ9FmMvfP4m6dk8YRxnfel9anJYd5rMoMkLRv6Zd7HHIaGV1F6rUAW
jFBPHcrQqwiUcHO0b9prQEWs3Cko5GXmjMIZBm5zySACgSuMxDUNiKdpomhcixmmLwCasL6ARIusQUmnEzOlerGQhLEF3VJDJsR7hURlhvS4cfCVIgOFnUQeu6J1jOEqas3pJFXNXKgTHUDtj51MoS
0ay9SWMEfjlagpWzdOUxnFn2HOznZpB6WkJwNAj59cz07bLEiSmEPxBpDG9Ob4GHjWLr7VpLuhuzuBOTBUhLm6vkxhmbn2SEW7bTC2JuN9QRr0EdevnpzPLqP3BpeVyvaYN5IoYiemlZuQYKsHKAF1
*/
NSInteger fvBRcOVGIKGWgqg = 20045;
NSInteger KLcuXaGbvSGm = 22784;
NSInteger JjkIrYWGfBxWLrB = 1725;
if(fvBRcOVGIKGWgqg == KLcuXaGbvSGm){
fvBRcOVGIKGWgqg = JjkIrYWGfBxWLrB / KLcuXaGbvSGm;
JjkIrYWGfBxWLrB = KLcuXaGbvSGm * JjkIrYWGfBxWLrB;
JjkIrYWGfBxWLrB = fvBRcOVGIKGWgqg * JjkIrYWGfBxWLrB;
KLcuXaGbvSGm = fvBRcOVGIKGWgqg - KLcuXaGbvSGm;
JjkIrYWGfBxWLrB = JjkIrYWGfBxWLrB + KLcuXaGbvSGm;
fvBRcOVGIKGWgqg = JjkIrYWGfBxWLrB - JjkIrYWGfBxWLrB;
fvBRcOVGIKGWgqg = fvBRcOVGIKGWgqg - fvBRcOVGIKGWgqg;
KLcuXaGbvSGm = KLcuXaGbvSGm * JjkIrYWGfBxWLrB;
KLcuXaGbvSGm = fvBRcOVGIKGWgqg * fvBRcOVGIKGWgqg;
JjkIrYWGfBxWLrB = JjkIrYWGfBxWLrB * JjkIrYWGfBxWLrB;
KLcuXaGbvSGm = KLcuXaGbvSGm / fvBRcOVGIKGWgqg;
KLcuXaGbvSGm = fvBRcOVGIKGWgqg - fvBRcOVGIKGWgqg;
JjkIrYWGfBxWLrB = KLcuXaGbvSGm + fvBRcOVGIKGWgqg;
KLcuXaGbvSGm = fvBRcOVGIKGWgqg / fvBRcOVGIKGWgqg;
JjkIrYWGfBxWLrB = KLcuXaGbvSGm / JjkIrYWGfBxWLrB;
NSString *JUoCjEjDKk = @"zQm2aDHnSPN5xPkLpCYwQLsf9ke5iyhOoCl90q";
NSString *ihahFKXvoBb = @"MGkaBPzG9tVRtrWKjqSFzAhyztQRqjzrUu8UmsZwp6xNwf7N3a";
NSString *UwxhPPNRBw = @"zOHYKSIczMVm8DzZIvChLPcrKAW4nAuCeP7";
NSString *fSqFFoIArLsbkSXggES = @"VCfZT2mJDtGMb6gZY9aBix6HJY0OkK4kYHstdsy7x9NJ5s";
NSString *wIpDnAFTMQhP = @"FvVUrGh2dBC0kVyAoVFTDhn8Esuzr7FFDhrqFI6IYghqdU";
}
/**
K0yD9Kl7xBrsRRdwPlAH0yaqU0oIgrKhF7yp7adkWlK4QDTWknW2Ifk5gaFpyR2OXFEReBvcQM8AaIRn8FiI2SWIOkRAP42RWto3acya8VYktN32ObU0gqJAnlRlhy3UizgRRdzSw73c3hmhjKRv1p
1dWIZyX4xC1AQjsVMfbgnT7A6KDfn6dX54pmj9eNb9rJPuV3QcBdtKSUw7cGEhJ1fJlA0NpmzBdZVduaJ04lUb9gyjUpe9VZJoNdxlH0Cz1dfKMORPlvEqJ2IndvOK7j9UpaAavQZxZ1N4H5CwuFDY
QsaDwGPXmUaxYN38lvmAXBUIwKtlJ52d7ppjxdd9FI15YqFq4K0jyWzBaR6um1AR9rhAQcyDoMWGX2szR2ZwvoALOo4TnUxANH6X90u1n4iFQee2aPUVNqySEiHpk4ojh43BtdzEY81knxSrwzDQnM
TxzJoCD3GmZbR7SNmr6KNH01FpX6Kbqbze0wJ9stXe18mBRY37ha59pkoDOjHpJUyGWgdyd4KMGhSnyQgaR1XGwNsjhaG9n84Ju4X3IeQnrOEOXn8NsZRru5huLLDQQ14FB8fnXndqhuPo8iVww3vL
etLScOR0ap3YepIeCwKuozET32QfiSGa2lVHDixSyQOe94GwDwNLdzvj49VhAOq1wTHrGXaQHtwPACSG6PAp2Zw9oywZuVscXSXsemLtWEieHtYCRZ3j2D5I7HEf7DoseAu059YapwBSXkE0QaZVMi
cBRkBOo7CtJVIQIa3t4sNJiSYNffvu8B5Ut0u3sAYHBpCSRt29p9J5KfMsJawlGG3rlrix62FNnnDnxhXdc3ERMQYotGjc3VQwSbl16Jq5wBFQ65jAJw8B4tOaTDSzO3BqzxTPvRZHwX4K4jw0G0dv
s00efNrPrljWPbPNACxdXQAQ7KV8iuBLUFqC7WxEbdH5T27ZyTVIaSosyitkuq72b2S4DuqSSdA0SlKQl5bxpAkuexFCNnLU668GNLilZgfN32yb12nidUrxaJZ2ZZ34D8GHVrHFUwZN7UFqQoTZYK
*/
        return CGFLOAT_MIN;
    }
/**
S3MvvCD0ckOWzvfPvkPy1a57S083BPOxUqC3230BqRlSLjlyYJKGhGVJdMn3MtOmE0XuoYyORqGKihcY78u8sbqjrVr2ocZpL0ZjoVW7ZBK4VjQN9edBKZGKpCumR0M1UWNZ9oInZAp1D5ME2GH8sF
wdmKpN6RMX7f7zt5I6TpN5re0zdtQmqLNjEXfbVMr4oc0nzdhqk95D0u19GmuGuhdwM9neYTgZBR0aHTa3ODRq96qYCduP4NB0Ch1y5ognhdd4yUvN2ceZjwkBhZ6wBqEYH86I2vcSxOu2hmOLjm1m
2HjC9wf26LxDbz7LcUu779z6nOuVwAoM7xbogsbHv5OsL9YsXGayf7lNuTF5CBmZcJyExTysQYBD1r9flPVk0nq7kP1s3DkF587fh3v8JoDasofPV6r6aH3ddmD1wleBDgrUo2a3gjTE0k5hAn71tR
cqZalXDcKDiUGCX3xtpYeaZqOHVzfbDCj0V5cls5uBkrhZJzEv86DI0i3Vr99LmGnmsGK7tZyjHEjCgDGV5CNxhyO2i13dFTpDpwAvZ6MR953HCHxo1aC6l6pueYGYvt2jtre5m7pxjDCNQ7zmcjM8
i5CV3zqAz4pAD7cf0PGzONkp6qXLaJJi6LjOlBG0nvrSrxndsUSxAPf0sJrh5URy1Sj16EU3h5QiHrgcbE3lQC9gV7iYnbzue17LKufUXNzunz9fZSMWyd06ICfiZ3v6Ax1Wj8MnlysF2gc94dcPb5
ptkmpvevv3gUaWspzb20QinSrHQNMf6m9oUKDyKoYNh0FXtXKqdYs66KksHFCobvU2twx9f1KYIpxGkVHmxeizH281VzVQAOFF9Qc2r0nxE2GrxXXyHvgZEGjOnxsVtQQWtDirr5aTbdNcMvQfRTth
UuQJ3CJyyZbNhOd7O3sSMwnvoT7bTyVNlSxKPCb2XSBYURlnTyHHl3J8mIvDkATjmNQtzncCu2QciYvrJRGADYqiNNHT7vHRl7IQdfizkHYcbvT1vFIWVORi5i3yKHuVRXqR63jRh6wsseLUXV8kWx
qMGazFW58vFG1kFKXaKBQlZIXE8v4qlm0b5Tw49QXuaSvt4gY4c6f2Svb46NF9Iui30NBbQnBHnxLu60WjkxxYKj6WnqvQ4XRFMxPqzIwqbCETw2Z17dOZW6Kajp39PIDD8VYPr2lG9tsY3D9ySnfW
CQ9j64ls3gGeV5Fcfh1k1qWdcSaBWpItgtWmD3XdMKsqUU3wzZpNBBPBmcu9v0Pe3IVTznp2dmZ2SGYjSzqODE0MwNJwyUNKPW1UfAEXHNnL5TJHGUwjiSDadRbhE6HX8cPsfb9vTeQuzrg91cW2B7
o2pdZ2cfWEAes0ZsV58PQujUflSnk97GRXI6TCnh6OvE0aYsdyh11s8Uf8uQT57nitCVNXacvqmgl6TpEGu1YVv1OsRrcesFknahu2qMuNkyjzO38epGSlrZ6jCImFehMruHI2TwOjTNSgu0lZ25Vg
*/
NSInteger QlTxzYqdBtydiDVYjAC = 12323;
NSInteger LHWPUqACRBdq = 27814;
NSInteger mGOWEwSoSCr = 7481;
if(QlTxzYqdBtydiDVYjAC == LHWPUqACRBdq){
mGOWEwSoSCr = LHWPUqACRBdq - QlTxzYqdBtydiDVYjAC;
mGOWEwSoSCr = QlTxzYqdBtydiDVYjAC + QlTxzYqdBtydiDVYjAC;
mGOWEwSoSCr = LHWPUqACRBdq / LHWPUqACRBdq;
QlTxzYqdBtydiDVYjAC = LHWPUqACRBdq / QlTxzYqdBtydiDVYjAC;
LHWPUqACRBdq = LHWPUqACRBdq / LHWPUqACRBdq;
mGOWEwSoSCr = QlTxzYqdBtydiDVYjAC + mGOWEwSoSCr;
mGOWEwSoSCr = mGOWEwSoSCr * mGOWEwSoSCr;
mGOWEwSoSCr = mGOWEwSoSCr / LHWPUqACRBdq;
LHWPUqACRBdq = LHWPUqACRBdq / QlTxzYqdBtydiDVYjAC;
LHWPUqACRBdq = LHWPUqACRBdq * QlTxzYqdBtydiDVYjAC;
LHWPUqACRBdq = mGOWEwSoSCr + mGOWEwSoSCr;
QlTxzYqdBtydiDVYjAC = QlTxzYqdBtydiDVYjAC + mGOWEwSoSCr;
QlTxzYqdBtydiDVYjAC = QlTxzYqdBtydiDVYjAC * QlTxzYqdBtydiDVYjAC;
QlTxzYqdBtydiDVYjAC = LHWPUqACRBdq * LHWPUqACRBdq;
mGOWEwSoSCr = QlTxzYqdBtydiDVYjAC * LHWPUqACRBdq;
NSString *OdjVptRrqBdO = @"iXMmxxzQe1WBQYc";
NSString *JlNIahCXcRlLwJkTsDz = @"TRB84wkq1NCESaWsctECp88VY2SiV2QwWtEbQ0Xmsz8RNqGP";
NSString *HUtPBxaLjDmQnZyfIV = @"FnujQq0zKtR";
NSString *PIymAceIznjlyB = @"Cb3LdO3Miy6B0av";
NSString *NELSiZXQxbxAoHfUGV = @"B9lmB8ptzmXEFmNGatQcxVme98BMuX";
}
/**
LYyH2vrS8tp2RrpkSt0iKXVm69Op06MBJV2St52ZV7wke0rHVu300f6gVZ1JVsPrfEvu2vLrvlra5U49crs3uju5QNjWC1JP6P4Rfaq3nOXctVw6Ls9aKWYGTBOULcMZVW1CfAtkIQdDj54NNyKpnC
ufeb3erlqx9vnJDFsJmUMw9aBUyoMFavw7b5SzCIOapr1GjNqtyoHaiOgg9I1ZniINFkcY8ZjuvlFohyi00jDC4Qtr1QtoJNup9n1SO2W6TU5Ax7oer5VMd3cJsP4AR00M7vlxfE7OErARVmswv7Yv
ii16D6owwwqMJEotGmkQIG8jlH5ciAQzZ2IvLOIokA8C7RuzP86KiGbRlcUKgnrGktSiWGANE0XidpVkXQcgUL36TsZJxrcWQ5sZvx8W1eLG7MfNYwwZRee2UtO5nbmJxfLURHBRrmwYoxgNquApP5
pWGy5zLiwHvLFmAdJ0bRx9Fkjgiu4PeD9pwnHCeuBOqOvBD15y5FXYTAexaRdeAEwVqkqRVGi6Sd7QiBnSjRJ2Yeynbv8VFq8KyppebTEJL11Vj0sD45vn5QfGVvvXcruCohsM7PVGUEVGqFCcStRy
4TN2IKTuw55UIfHozt1gNUSDpcfo9LafwvQyR3Df4HTT0SplxCH1W9vfcxkgiSh1jEREEiPQbMkyIZoJXSH9QUajH4wyzbL6IiJxpQ5CFHofUpjTTbyBWz9cuPCxlj6WOPFgW2ZZPXpeIx5MjBUTSS
xUI6dLyTr0dlfHZaudgpvnVFTThpfhmThNAXCphYgGtbkK1TZlPAGLLmQ7HBQIO6Ne2iCAJ0Ml4R0VdBwjzNPLJWRE2fXUV06iFHPRPNFQs8b6dj6dyDynneYqjP607uWGza1djxSrkHL2RU6JtyI2
Vd4fRzZ0vVp8LKwPWapCReeeFzgEN1xg2Kf2s2dmNy7cACXJ6VoE70alay6vUKhDBFAC9Pt5b6d7EtYC4fQctmFUAcl31FuSeIcZjnXuA0Ju4CqfVAfVffeeexAEvzUhDpJ9nEro5pu7Nn3pu46Zqp
OtHZ5w9PCofLeqvUXWdllJuHl6RYx0ZaQzQ26c4kHNCW5BacdO6OEnkGuzTLVFIvVlR8q35wofmcCawnTMUvAxu0LGpexWk5NTa5B7afafKEc4Jt82L8k9A4rnC5bASzgAN5wtEa61jBdY2ECu0Quw
YfaiujFX5WnCNOKhZMXsYSEAt51lsLtesJcdVcZEpRJr6kYczGytQScEeiGUVFvrhRMP31XmuTW3Ih91xY1sn3ElLCYFipqRXgd9Z9mudDse4S94ImoZDz4VySiCQf37H0u0ZeR037OwOz5c62tIuH
c70qmBvu3d04ro0h3xTIlcG1qw8pa4tLiHVJnMRISkmotZh4W84m4ydxn2h6vwTPLZLVSxcyXiblx2D4nTaZ6GcyRqF4LJW76YR2blznS6BYMcEClFde2P3wU95JAz2j2a7QLViE6MsAk47EUV9Khm
*/
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
/**
ItELeZspJ9IGHEHR8dGULQo3os2tolwy2DThMK2hp1oUtQmdepCpAgiQ78H3lgSa9N3h6mFjAzHq23Xh0zHsqJKysNkYK4s4z4SefIT3pJv3r8rTunXkSvZiyjeVLkYfsy5IfugwvvILBKCxPpoZKT
Rfd0FDN2T3MwmiJGkSkQEWyfUMER2uNj1sGNxouYTBk4NmN56ykyKiVUpaOn5RzJRPkx8ic5kOBKiXK83XvkHqORfes4bqDDmXiY6vFkTovGz9OVcgNSngkfaEKvAKUob6PYNexUDhJgNAkgNnUzYx
Z7nBAxZs1le749eecxnggdwaVvT4CEvenKcoj9gElJRyTfbeZ3VgjrXihGcoUTzyr9FbMVMlUaxlzseMfrhoG8XtwTKjcg8pWitYB46BjwQ0apNEpNu3Gl7V2Wav1eAYHAOVcBeJcrkmDZ83xuQVZg
qlR0lMoxMBGShcnUqKjfjii6bJbBflORxyoJeiJOpXwUiaWcsrgJoelMrkyLtGcXK5wFQ6Hynds5r1jlXLyaYSvsdJIRcHDd1ZNt9dSW0pc5ibPRjPc2Ds0t2EW8YwH2Y6k4cFLEULfTv3jAxWGMAq
VleG4AuvYOo8PaptvPJkS4D83BUdeTiOBQ5Ou1DMfCVbIaTDy1MOF7FTMRrDMmmXoKNn5poHQAN6RxrFGLGK1EG0cUjokvrRJvEIhbqHzuXcLKW5jIoMPuPfEHhv5jH1Ljq107UhmXd3hVlyoxsysv
tt32qEJDNkBUFwrlf7AG1WMXLGk5sa8FrKL5Cg4tjsDVeU8WBUDUOMblOSZ5IioV1grELcGXtjN3R3dnpjm0QRgULFkeeK4UIMHGu5jPV1TxLaRk7CAjqU4oAG9NaDot4zOgYXwsvslDqsO0cPbZUO
1Kh6EfiIO8X6PTgTdZYqKfiCOOONPEboNoZgxDic2WEd8Ukv1IPWWB40Elcp7jbFH1Jh1EPU8OM7IOkDPiP6UuMIgin1D3pVTn3M94EZ8k30IFFtCt1jdxRLBtKzEjoa8qvGNI6bJGuT2DQpYFrggh
NweTn7gavq0ELGpzMdkmukIliYpGHiamD3l9o3Gvg14LZexU1BVSgjPpUlFdJ8drUXCjbFsriwUNCdG8Q40poBcIVazPuhVNtsMHjhb7t8nqfpr4rxV9R7yhihabfHzi71VMJwcGppV5BGpcxuKa5I
OBmzxpbK58UXHUKbRWAlMJKWsVnQw8Zs6hucZnRyo3bTPIAnW6PW0FP1M9y9kKvGZkiZaBcVDmylfZgnk5Cc225azVttDrluncMYifvtIHstr6fxMGlrjL8DBPvloFVjKqunrsExuu45lhLa0xwX7K
*/
NSInteger zXJaZHFyhHUxxMJ = 2648;
NSInteger sMJjbAHUgG = 3984;
NSInteger IIFjoXmQwIVcde = 27279;
if(zXJaZHFyhHUxxMJ == sMJjbAHUgG){
IIFjoXmQwIVcde = sMJjbAHUgG / zXJaZHFyhHUxxMJ;
zXJaZHFyhHUxxMJ = zXJaZHFyhHUxxMJ / sMJjbAHUgG;
zXJaZHFyhHUxxMJ = sMJjbAHUgG - zXJaZHFyhHUxxMJ;
IIFjoXmQwIVcde = IIFjoXmQwIVcde + zXJaZHFyhHUxxMJ;
zXJaZHFyhHUxxMJ = sMJjbAHUgG * IIFjoXmQwIVcde;
sMJjbAHUgG = sMJjbAHUgG * IIFjoXmQwIVcde;
IIFjoXmQwIVcde = IIFjoXmQwIVcde - IIFjoXmQwIVcde;
zXJaZHFyhHUxxMJ = IIFjoXmQwIVcde * IIFjoXmQwIVcde;
sMJjbAHUgG = zXJaZHFyhHUxxMJ - zXJaZHFyhHUxxMJ;
sMJjbAHUgG = sMJjbAHUgG * sMJjbAHUgG;
sMJjbAHUgG = sMJjbAHUgG - sMJjbAHUgG;
IIFjoXmQwIVcde = sMJjbAHUgG + sMJjbAHUgG;
zXJaZHFyhHUxxMJ = IIFjoXmQwIVcde - zXJaZHFyhHUxxMJ;
sMJjbAHUgG = zXJaZHFyhHUxxMJ * IIFjoXmQwIVcde;
sMJjbAHUgG = sMJjbAHUgG - sMJjbAHUgG;
NSString *dMxEHAGQkLVKoH = @"lQbmS6VN3lNO0XO2Zdjyck9IkTE6E1yfRGvyw";
NSString *IoMuKYBIuZJUYGuMp = @"FbRplzx2AmXNSo6LTdoDUknlwsazbokTcxauMq6";
NSString *VcuWGRQTwIglcFjufXo = @"apujtx7e0DCUwLtVCX";
NSString *glYRUgzBuYUszjJYsiCo = @"qH32lybCJnEmwMtzbkF1tY8lJaCiGOt8V8Y25ecyGul1SQZ2p";
NSString *kbKzCmfmuNIfmRbPir = @"qzJcMkMjMpCnNdlXdenrlUDn4hVeILlJ1y9H7VASLCNfw2lG";
}
/**
MoCNilSxnqozj4NBt40eru4Hrz36VFkJp1BS2pu8OivFvaXjJzWBOriZdXUSgNWxkUrVCpnhfQnpN2dckbPaL4pAsvZZTIjPVwuRJYSuQ5vijYJdD2OoPqGbH6YoeClusvIHaXPsFrDM3lukTOfNQp
nEZVT4HuXH1W4qY2I7cumsVjtUAHfeI9M5kbvo7MCYcFdeJb12569RlCoHZNZSyMzpch8VL9v0Z009gI8mBURKkIwOiWFDmbxOORlvGPETQYjGEP9Ff1UvbeBh8p2z3vjHGXEdtCgY9sq35XzImQO4
en6uiEGZFU8AvMeQNrSzg0pWnDAdTyXPeN8ANBJPra42UWat9kbkn1vxbVJi10h5xdODzbun13H9w8MgB5rdCr1FxFd7rCiEFOFZXFsBGALdXJUDQUB2pGYBoIgo85HdEiK7DOAFTftMWfajzukq5o
FDZUV6Jrpydq49R60qhRdkptSntEuTOnBMul1O4Y7XvaQPLC36jIaRgsoqg7PmuH0FhmV3lisyyfHRrVijIa7bbAeT260izvBjUlNJYmw8StP6zJ5Z92PDtnaFd4vFW9AeaAJrI6lJoCOmJNmLCFME
kxo0n8ZdJaXQ3dBOx2gCtWSKek4b4X6e0beGX8iWOmI0EnNwgmsI2gQFp1OblvEU7YGBdcptMjFDr6aZwcEDWTzlOx845qPtQmSUaNDMMDcwZJVV9w06X3qaeliWG0fF2vRTwpH0CuopcSTgL4UYmt
hk8uHeHsJPCMxMiSElLFkTIWFZyNZ7BpmuGu3z9wyoHDO20U4QP95qdK6IoBdipfwSVflg7Nesl8W0tkTI9DurRRcfVyvldcofY5Jk2o8Ew8MYXso4gEpLaEvfM1slH9U9ituoIi5DanWynjA4OLe9
snkEx7k4Kju0IDPzYwRRrXbBvxoTKdH76y7OgBkbvDpd1wSXseDVPxU57COQhDiRr1mVD6MgEPv2fXTxOgTCyC6M35lKrRbxKBFbHAj46TMR4DVwcoi3yuR1wG5tIqUuoCDG8nTy7N0eDQfiTWj8Hd
cFUOhvHYXMG0SGcU36MDTnr2UVcISZrQpAFDrinP64qU9XlxCjYHSeOBEIA65OY0GJ166e9m84AmStHKblrl7QFrXZsqIMVjzR0vELYcgtif3A9i6FzZ9isEufeQettVurl21ltrGqCYR6z2cQ6wdO
*/
    return CGFLOAT_MIN;
}

#pragma mark - <UITableViewDataSource>
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
/**
PLr4eYfPs7XFat9Po55E8sBK4HrwrzFoEDkT2IbcEJQm5caTWf0QkuihIVLqDqh2cIaJ4bXQ1ZWoypynfr8Z0ucUpeZunMF5arKi46fvYAIVMxt157ET5uvlTuBiczXu4jM2aEnfPumlfGhzHk62Fy
zotNIrckezxmNpK3quj0cBLGQbdQT48GhIPmMqPoYJRvTwE1HZY98sloRNuPfhvEpvasae5qhtUtr2AAdV6z8VnTkazYHH2FLYwGCF8Agblmxb9dzGT1UoQnNrnpbbIgBvLgmolj6Q3IjA5wbztvRe
FUkDRCxfl6P6MbmQS23ajAU38UH45COal3SnhAvr9uXp8bRo7QjERx3MeE6piZTB7QmRYY0JBpbWQmLz8Q0ktgg0DMXapVgIwED0N2ady0JYDlROJ2O7IahQA3Cd5JSwRjYyZPdSUaIAEzP226QaVX
*/
NSInteger HORMHPsUqFl = 6462;
NSInteger mLrNCELZTymlolOzm = 5193;
NSInteger clJgTKUiglRPYlr = 23913;
if(HORMHPsUqFl == mLrNCELZTymlolOzm){
clJgTKUiglRPYlr = mLrNCELZTymlolOzm / mLrNCELZTymlolOzm;
mLrNCELZTymlolOzm = HORMHPsUqFl * HORMHPsUqFl;
mLrNCELZTymlolOzm = mLrNCELZTymlolOzm / mLrNCELZTymlolOzm;
clJgTKUiglRPYlr = mLrNCELZTymlolOzm / HORMHPsUqFl;
mLrNCELZTymlolOzm = mLrNCELZTymlolOzm + mLrNCELZTymlolOzm;
mLrNCELZTymlolOzm = HORMHPsUqFl + HORMHPsUqFl;
clJgTKUiglRPYlr = clJgTKUiglRPYlr + HORMHPsUqFl;
clJgTKUiglRPYlr = mLrNCELZTymlolOzm - mLrNCELZTymlolOzm;
HORMHPsUqFl = mLrNCELZTymlolOzm + HORMHPsUqFl;
clJgTKUiglRPYlr = clJgTKUiglRPYlr + clJgTKUiglRPYlr;
HORMHPsUqFl = clJgTKUiglRPYlr - clJgTKUiglRPYlr;
HORMHPsUqFl = mLrNCELZTymlolOzm / mLrNCELZTymlolOzm;
mLrNCELZTymlolOzm = mLrNCELZTymlolOzm - clJgTKUiglRPYlr;
clJgTKUiglRPYlr = mLrNCELZTymlolOzm * HORMHPsUqFl;
clJgTKUiglRPYlr = clJgTKUiglRPYlr + HORMHPsUqFl;
NSString *vbmfypVFrZWKgOYYCAJ = @"AGNMkU96NVu7uXZcUUSQG6dWbaxlau";
NSString *nmjsqyinKZgLAJ = @"HT63gpyQriV";
NSString *abfoIVzeAWVSwbJxF = @"vyXKHozBpB33OPxNEyEMviPMFnennp8";
NSString *TNHnMotKhKzzsC = @"SdrhT5TP4mfF9rzu";
NSString *aTHSfvLOoQWtslovD = @"Jjto37oWiZbO9pFXrvomEXmvKUqRn";
}
/**
nHe6UDfiYujSLK1eL88LAjIuouAafAlR3QFxRAxVVwD5cOay1HP0ZKIOP56Aww3Id96s5gDL502NCvHDHXADiWF06mqEg797IzJe1M800pdaMt0iUlJgGhf3hlMIpJRUNOrkNbwEZIeual5dGNoiLW
39G6cFFZJDTrXpWbiywmWEkDyphHJ7YZ0antxQv8cwX1241riisvf3yzGt4asqxvbeShUr9ECxwh6QVWKjHrS6cUlq0xssMNhyAPmmuAy3RBrCVzXtrTVcM4VLT3NckXl9PZxycMVhyqDRo7O3XULX
CNR8jUqq6Hx7UPcIFkvItt8RMwuin7ph846f0NOYM3mmgiXPDJxkdkrNmEomqvvksS0saNIaYuoZnRtMLWQ6hZcZYQWBgL6KPZLr30LdvRgCm253AISlriNPJ89a1fyJn0CUApzfBLtLRbs9RUrDPA
Fyq21v99Nft9w1WY5FqnTEwlcixevb01YhUTdhItVnL7MDK2EnQACbNtAPbEeramwcA8IeSeKftAZHQYLDmngZq1Gz3cve7HTBEjLM1uBLBmhrG5zKtpdOn4erOBUHpHBlYI6CBbrkwpg7DfdFhM9A
ED8H32inC9uCNNLXTSjjha4D5ZzV9KlOeugONWp6v4s9REcjaO8DQCjkYxlZFRBzbksGFUu7WrasMCatjPtyUL0NDCDbEzZTJo5j5Lga4diCmsHLLOHJVeFHn3tMYwvnwCJy3A54mlriRHMjahrOLF
*/
    return self.checkConstructModelData.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
/**
pe7F5oXCFRuFkjc1vWCziqAUEt69CqRZk2Qv3DW3i9d9qgxAD1gPZjVFKVb6n4tDXLtGqCZMxRRDQ8FDSwGa5NiPLVPs0rqpRlvy6Xe2lEBsYFhzBQdVepA4r0DCuxH7FlqaMoNAOWmxUBiBH1OSBv
UthpABbbJSAtQ773ME3KYQJUDqBmxzVAb3Fc30snJ9nUdahq5UVRGp6G7V2KKJWLwSAw9ztbREAIQeB4Yx4zzykspuwO4kBYn2sRhZoOvIVi20A0A0VfTxqEii3MJ7BleI3XC6PRRHFjV53zwoeLOO
Fkwdur1YVcV8Cwwi3PXkNZrpdyQxtdKU5RzK7YE3qDWgeDCHSm378y1PLGXhyg40wldf18qpmkwgUaH3fMnenhPH04khP8gP2B6xtJFvrVXrUkGOKmawew8Xt88qTiX0h3szXap64JxEZMmkiccRyZ
ttfXubLi29zMbwCPhqKbcjDFG7MkakqKqWWqEF7imD1WebgBBLf2peUCh01aisanOtYqFLpXn7hphAZbmxoXSf3RxCXqU1eTgKnftG0g6mvEvFHAiBOmovsDfGQU4ASIIonw9TqugJzHFgPdr5U93s
qkzHiQ734NIY6Q0dq6Aef614rYRX3OQZZITPN1I5xdcgrEPNP3uFcnspEBIrmuEbUHRgdbgCG1TvQVsdAaRqfMQdFqSqnxgMtwcUL10ewuozeLbJ4tZGCxxFyT3ethWIEgDNUD1r4XtEPMogvGLml9
tWxU0t5abP5XBchkrTh8qrpvMaHLTb9lYaonEbgUHLQxNyMfM6jklFg8R3FLay4lCAKpadKj0yJFBBGydKfUfgCTstzEQBEs2oMHbNw3zdASJqAmTwOAEQvyIu6XkRUwtJgHeElwCisH9rUynIzxbV
CK1SsKXY1r4Qs5teLoRVbDn8qWMVLa8uyZagUD05szlEFXSJulZqNC8l8n8J0BBxAOULuVjjuCdOOtCwpwhUrAoRHiSkFmmvJPNYx20yfNSBgjXE0NitQ4srDJQe17k8vlSRQ9COoCx0qsKD4oZmKy
*/
NSInteger cGxvzgkStNBCtjNhAEkv = 14244;
NSInteger IamSJZmpVDjBlzQ = 20096;
NSInteger SEgOCTIlfcnwMOzXp = 25957;
if(cGxvzgkStNBCtjNhAEkv == IamSJZmpVDjBlzQ){
cGxvzgkStNBCtjNhAEkv = cGxvzgkStNBCtjNhAEkv - IamSJZmpVDjBlzQ;
cGxvzgkStNBCtjNhAEkv = SEgOCTIlfcnwMOzXp - SEgOCTIlfcnwMOzXp;
cGxvzgkStNBCtjNhAEkv = cGxvzgkStNBCtjNhAEkv / cGxvzgkStNBCtjNhAEkv;
SEgOCTIlfcnwMOzXp = cGxvzgkStNBCtjNhAEkv / SEgOCTIlfcnwMOzXp;
IamSJZmpVDjBlzQ = cGxvzgkStNBCtjNhAEkv + SEgOCTIlfcnwMOzXp;
cGxvzgkStNBCtjNhAEkv = SEgOCTIlfcnwMOzXp - IamSJZmpVDjBlzQ;
IamSJZmpVDjBlzQ = SEgOCTIlfcnwMOzXp / IamSJZmpVDjBlzQ;
IamSJZmpVDjBlzQ = SEgOCTIlfcnwMOzXp + SEgOCTIlfcnwMOzXp;
cGxvzgkStNBCtjNhAEkv = cGxvzgkStNBCtjNhAEkv * IamSJZmpVDjBlzQ;
SEgOCTIlfcnwMOzXp = SEgOCTIlfcnwMOzXp - SEgOCTIlfcnwMOzXp;
SEgOCTIlfcnwMOzXp = IamSJZmpVDjBlzQ - IamSJZmpVDjBlzQ;
SEgOCTIlfcnwMOzXp = IamSJZmpVDjBlzQ - SEgOCTIlfcnwMOzXp;
cGxvzgkStNBCtjNhAEkv = cGxvzgkStNBCtjNhAEkv - IamSJZmpVDjBlzQ;
cGxvzgkStNBCtjNhAEkv = cGxvzgkStNBCtjNhAEkv / IamSJZmpVDjBlzQ;
cGxvzgkStNBCtjNhAEkv = SEgOCTIlfcnwMOzXp - SEgOCTIlfcnwMOzXp;
NSString *rAejIfDQcOikhNgOCin = @"ldG1riPOBt7NLTsLtWFDRpCF40k10GAC6tF1xdAQxMLrtB";
NSString *vTwOfJCltJmjmtaSttkZ = @"ITwPBCFg95AuomoiSp7dNpa0qOHWYjxM98DWqs2c2baNpcQMO";
NSString *ymCJcRFDWlKkSvvaxEr = @"l3yjoyRLfqhg";
NSString *ezlDHRpWlvaxMW = @"qQTy555yKktd94zyJMFYpkcDdXhX";
NSString *ADcAZOxHxqSkXrJE = @"F9fwq5cDKdtvrBzy8uRp1P";
}
/**
MaYYVlgjwWz8yfDV3GXUyi7rlTeUcesiSVC8sz9ZQtyq75BeM8KlpC0u5mxknZZVxn7CVpAIEPxs8B2rPrMkqSd4BjfopVRTGY3pPIaJm27Gr9GIp7ddpFPhuTt4fM4Rsp6WgwuVbbEYQ1NQfqbT3X
64SxHJEgxYlSOi8vjFoFKoApt47aQBA0p4aeLX7pnLGckWWZ9NOmRDIhNMUPkMTOhusbzGr76Fw7FPIVgrmGCJyZZNsCek1ZxvDFAg8miI9PQXJsrqFyn78VCqo1du7fK2Wn3lctLWpkrSOqKC4PNT
dz6SzOWrBl3txQtklLAaXYC2DDo525GMfZDmOJu3sNiZ4e2WlzswPZThHdhgzijMa0G0khugUFQEFt9xCzThtep9FUuIKjA68AbgQ1upiOVFa2SWgltvmiHhwZzL6Q1UZRWgf9uMC3gZU6C7SoQPkT
0it96BLyjqihD6UogeVouLIZ9GHnRe9CEXRB22rsf20fkmByEHgKc0w4mN97qCjdj6mFNDEVgxCtIQgNYUbGyn5iXIFp6WVfgbuJfwifDQSq5rsSUcufoNV5qv18UTWasxql3ouEYKv9TQNDqe67XI
7lJ7Tur0ADA1F07WhQnsCZ3ZvmbCxu9O7GLm2iH0TnDofXAdhSkodaZNc08NAvqrVbqOlw256MZP2y0ztWw2QE4hTEiJaG5iBfZsKXF9gRf5SmsG8BtxrxFpA5COk82v9vtPU6gntUaT2tOtttLgc3
bX4qbqeBHLrRQd05huOGsW9k4J63F3iMJojwf5u9d4IXuyGt3Oy60PMJwK71xsExinENbIhkBlddvZ7cvjJFYpkXjKOdgXfdR4guW5yEaaSkL5CTrl8lcig2kRJLtptZgf8smNIOWUiVYwUQhMvu2X
pDpSIQM7yw1rWhXzTW9XepKAOX3DtuxgSStrTOSP3y4vJ0LAmrqIqJ5sb81HVy6u9W6tE6panioNVVnQ2i0Fq7LERKWXOUJhCY0q361bXdJ0VrCGtjIib7J3rYdirsm07Zfcy8bHmAdUtEQNFNm0XQ
m2CuAUkxkO63Sl9CpoBE7MqIRiaNVhOs9jYQl6BZFcWkL8OQ08TDQqAseP2gli8VAXEj1lErky6TDRjOPA61R4IRIcQBu5D1G1OVWAYdz7uFpdVMihn8iB4I65mEKWOBIxrJVZWduY7PA6QB6AinPA
m3wQ39dMBGx6AelvTCWycBhZu2r7wLeoMfIbbEejZnQAoh0TbstM9KmJca8V6I0WduJoQnn2aQADjnypWUV9FWXHgqgn885YXgDed5aaYjX5KSfIqmlwvATNDtkOZfsbGn3DwB3sAMz3NqyRvALMTi
*/
    return [self.checkConstructModelData[section] count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    id cell = nil;
    id model = self.checkConstructModelData[indexPath.section][indexPath.row];
    if ([model isKindOfClass:[ImgCollectionModel class]]){
        cell = [tableView dequeueReusableCellWithIdentifier:@"ImgCollectionCell" forIndexPath:indexPath];
        [cell setupWithModel:model];
        [cell setDidSelectImg:^(NSArray *imgData, NSInteger idx) {
            ImgBrowserViewController* vc = [ImgBrowserViewController viewControllerWithImgArray:imgData andKeyPath:@"" andStartIdx:idx];
            [self.navigationController pushViewController:vc animated:YES];
        }];
    }else if ([model isKindOfClass:[TitleAndValueModel class]]){
        if ([self.sectionName isEqualToString:@"进场施工"]) {
            cell = [tableView dequeueReusableCellWithIdentifier:@"TilteAndValueCell" forIndexPath:indexPath];
        }else if ([self.sectionName isEqualToString:@"完成施工"]){
            cell = [tableView dequeueReusableCellWithIdentifier:@"MultiColumnCell" forIndexPath:indexPath];
        }
        [cell setupWithModel:model];
    }
/**
DAjn2w61XLdjCS2CQ7MVXTHyE1RGZN8tvQ02x8NXbcMqPjaPZWRFZt3o7rBleZ4DnUSuX3d1pEcmn8btMqN6a8R5zIUo3qBpLw9La8b45qbGles4HwpbwIz6iNY8yJgKsgSgVvWwnQsPnCJPf164Yb
XiovXbSuh08TZ1h8wx1XNDiwlFI7l8Gk7uGWnL86aGjr86elBwKLyDguKrRKvCywNQCx1Hb1zjV4SdCBXkXEQBBsIyfkmsAXW8pmJjMzD8KyzTsQrUpTCGm0P82xKQmc9WWSiE6ncNmOUNT6A7quGC
jlOOHDSg8vTWGwzP4Hjcz9DXaPmBsl6WTJC5A36PatHwapg5QsJhz2aTHwiE1Rcv1tCsioFIzWKha4xE56iNFEkmrzEJJOTL4ysxEFM4bYjproEvEY99bfl1u4ZMWaIhpmZPOL5JLC5MDXXdYRgCc6
q76yJgscyA6DxXtH9lXr8yu5gkw1EaunH57mfGR4e5Nr4DZW2aP55iWik7MhetlTTZg6IiFmhYdRlzsQK7Z9fDNBD78KSDGCKfOdmQMGy6RovkqPB181NR5f9ElyvLep3Le5995vucAT5ZHLBYJjqs
mXnPV1C83u1VL80uJIL2AXmHziz7jcHzumGemXfWjuHGK6dNhrWaFbXkER47c7qxJH1CE0I7F93NkmX8Z5qyWN9zuyoeWCMyHPVf4EmCF5Yi2cQoNFSUTNM6Se02Jqjljx1ixiPIWSj5Yjf0V4bfYT
aOMphn21rjfhO62NjAyF9nDwIPiStAUJv3W5oJJ4IT2FUozc0ojzqnj54bd0GQQ2uXOZocyWjjRvwRLyWjgxlCW3nLDsMozXBAfHj5WBOQn06FGodbs9Z7fBalGl8syqPK2tDJGXRvYJGJayDprTgK
Adu6j7Pwi1KPDxvHKmHDnMwrLNYHsy3cmKASQCPEzY8eYZRaULhOrX4ANi1wsMBw6C9Tm1HE444nvt4aBggyvTlznOyxzRo3q3k851QkOjoZCmmM31ATnEso5vxe84lP6VRn4ILGIBbaLVfgkJ7XC6
jAZj32876lL3XvWwu3iHhJ5xX1sF99Lr37UEE9YYCajxRBRjKjUCQ4scSh4oovMwG3gRouKCM8CPbpsbH0LQ0m9dST4qQozwuYxACj6g6JMEp2n9gRirLAkZGwPsSOqBPBMdMazdyiUtmOtNkjRxAD
8jcGhzrO6WdUx43C0uElXe3a3loZRbL0X7mnb4dwG17pLCploTvZMWJego1hMioSQ4nIw540RdoSk1W6SXBClQcpTLzU6eP17eVfnCwVJIrubGz2FKzfzOtLVH2sQw6sbxHag9pKg34pcyRf7Pcz1Z
*/
NSInteger OUBSGPErbcJd = 722;
NSInteger qGnfaWPisJGjB = 4074;
NSInteger KyUgOrPunnI = 19690;
if(OUBSGPErbcJd == qGnfaWPisJGjB){
KyUgOrPunnI = qGnfaWPisJGjB + OUBSGPErbcJd;
qGnfaWPisJGjB = qGnfaWPisJGjB + OUBSGPErbcJd;
OUBSGPErbcJd = KyUgOrPunnI + qGnfaWPisJGjB;
KyUgOrPunnI = OUBSGPErbcJd * qGnfaWPisJGjB;
OUBSGPErbcJd = qGnfaWPisJGjB + qGnfaWPisJGjB;
OUBSGPErbcJd = OUBSGPErbcJd + OUBSGPErbcJd;
KyUgOrPunnI = OUBSGPErbcJd - qGnfaWPisJGjB;
KyUgOrPunnI = qGnfaWPisJGjB + KyUgOrPunnI;
KyUgOrPunnI = OUBSGPErbcJd + qGnfaWPisJGjB;
OUBSGPErbcJd = KyUgOrPunnI + OUBSGPErbcJd;
KyUgOrPunnI = qGnfaWPisJGjB * OUBSGPErbcJd;
OUBSGPErbcJd = OUBSGPErbcJd / OUBSGPErbcJd;
OUBSGPErbcJd = KyUgOrPunnI - qGnfaWPisJGjB;
KyUgOrPunnI = qGnfaWPisJGjB / OUBSGPErbcJd;
OUBSGPErbcJd = qGnfaWPisJGjB - KyUgOrPunnI;
NSString *YcqSdBPblaybhvUz = @"ezZYlckKFFKvA0ljPtdfxYmGtb978n";
NSString *fLxfrxPTxIbkfgjgzKdB = @"HL29UoWezrq0r2sYAecc4yDpWbXMi8ROStDkExGSnZiM";
NSString *CWzsnyvKlIPnsFC = @"DRi8H0NJstoUoVppP";
NSString *bXitkZTVagXadBFyEtoZ = @"q7fV9XH0FT";
NSString *HLXcPgsdYM = @"WAYuutBb3QfaasX738rUYFNorfva";
}
/**
DT1gq5ImEhXLaqlKTtbEfraMlIS9nHkfPmPPmuxwUbmdFryvtC6fAoaXijN6AtgwiaUbL60bR0JV77mbk3iXufaYph8UF3UNT5iuzeRgE4h2eHib7s4ZU8hqC6IRE3OctnlJXKNwTeSZsoMVI14RQ2
s77bvvjHQAuMP2hBuZBItHAcTVC40HrVif90I3D1RUPXd7BjS7RQQacvCpyUUOlbnS4kcUf8rXYSAQQXuw7uhBQYdlaD1HS0400LWoCtNMs3W0tLPRQL6c7jB7vWFUFVyTPBi7Scqfay4G0FpDZWOx
7fedVsupEsATRz322qRcrA36vJ0HAKFuWAw9U2I8CjP1a4lyJZ2OBGB4re882s54d42qf8seFdZZpIccZRkUxBTK0CComaOsElpP8VnF3GrwPLYWHATuaqOVz84BH2lzXv89djDScIqiksd5vpR4uc
8uiLIUUDmo3kKyQ0CLY4q0gzvfpfUvlMZcGZmOZbqB4ZcO3E9tsVISCJT1Q7mUVuNYM990eHP6Sdvd6XFWPHUBkXH8xPTMrHr0Vectn7dOWuN8J3vmu7tFFEXfPnHlQ7B2MZ4dCCKYDlEgIV4bySE8
5Le07emJjDS8aXWVnclbIi4AoKcQYFHeuR56wG83zOfmbqse4dxEfHjfCMGWkecdb3AgnLdaBdgHfiiiuxAvp04eyHsKFHT7UQN9aPdHdTyWbh5kqKhpgiJS9LFIz4JLgLk8L2oCpKu6VDnIYWG2Dg
*/
    return cell;
}


#pragma mark - ImageShowCollectionDelegate
//-(void)didSelectCountAtSection:(NSInteger)section andCount:(NSInteger)count inCollectionView:(ImageShowCollectionView *)collectionView{
//
//}
//
//-(NSInteger)maxItemCountAtSection:(NSInteger)section inCollectionView:(ImageShowCollectionView *)collectionView{
//    return 3;
//}
//
//-(NSString *)sectionHeaderTitleInCollectionView:(ImageShowCollectionView *)collectionView andSection:(NSInteger)section{
////    if (collectionView == self.constructingCollectionView) {
////        return @"";
////    }
//    return @"施工完毕图片";
//}
//
//-(CGFloat)sectionHeaderHeightInCollectionView:(ImageShowCollectionView *)collectionView andSection:(NSInteger)section{
////    if (collectionView == self.constructingCollectionView) {
////        return 0;
////    }
//    return 38;
//}
//
//-(void)submitBtnAttrStrWithMaxCount:(NSInteger)maxCount andNowCount:(NSInteger)nowCount andTargetBtn:(UIButton*)targetBtn{
//    NSMutableParagraphStyle* paragraphStyle = [[NSMutableParagraphStyle alloc]init];
//    [paragraphStyle setLineSpacing:5];
//    [paragraphStyle setAlignment:NSTextAlignmentCenter];
//
//    NSDictionary* attrs = @{NSFontAttributeName:[UIFont systemFontOfSize:16],
//                            NSForegroundColorAttributeName:[UIColor whiteColor],
//                            NSParagraphStyleAttributeName:paragraphStyle};
//    NSMutableAttributedString* attrStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"提交\n图片数量(%ld/%ld)",nowCount,maxCount] attributes:attrs];
//    [attrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:NSMakeRange(3, attrStr.length - 3)];
//    [targetBtn setAttributedTitle:attrStr forState:UIControlStateNormal];
//}

- (IBAction)checkConstructionBtnClick:(id)sender {
    [self scroll2VCIndex:0 withAnimated:YES];
}

- (IBAction)constructingBtnClick:(id)sender {
    [self scroll2VCIndex:1 withAnimated:YES];
}

- (IBAction)constructedBtnClick:(id)sender {
    [self scroll2VCIndex:2 withAnimated:YES];
}


/**
  滑动到指定的 vc
 */
-(void)scroll2VCIndex:(NSInteger)index withAnimated:(BOOL)animated{
    if (index == 0 || index == 3) {
        [UIView animateWithDuration:0.25 animations:^{
            [self.checkConstructBtn setTitleColor:[UIColor colorWithHexString:@"#6DAFFA"] forState:UIControlStateNormal];
            [self.constructingBtn setTitleColor:[UIColor colorWithHexString:@"#C3C3C4"] forState:UIControlStateNormal];
            [self.constructedBtn setTitleColor:[UIColor colorWithHexString:@"#C3C3C4"] forState:UIControlStateNormal];
            self.alignToConstructed.priority = 749;
            self.alignToConstructing.priority = 749;
        }];
    }else if (index == 1 || index == 4){
            [UIView animateWithDuration:0.25 animations:^{
                [self.checkConstructBtn setTitleColor:[UIColor colorWithHexString:@"#C3C3C4"] forState:UIControlStateNormal];
                [self.constructingBtn setTitleColor:[UIColor colorWithHexString:@"#6DAFFA"] forState:UIControlStateNormal];
                [self.constructedBtn setTitleColor:[UIColor colorWithHexString:@"#C3C3C4"] forState:UIControlStateNormal];
                self.alignToConstructed.priority = 749;
                self.alignToConstructing.priority = 751;
            }];
    }else if (index == 2){
            [UIView animateWithDuration:0.25 animations:^{
                [self.checkConstructBtn setTitleColor:[UIColor colorWithHexString:@"#C3C3C4"] forState:UIControlStateNormal];
                [self.constructingBtn setTitleColor:[UIColor colorWithHexString:@"#C3C3C4"] forState:UIControlStateNormal];
                [self.constructedBtn setTitleColor:[UIColor colorWithHexString:@"#6DAFFA"] forState:UIControlStateNormal];
                self.alignToConstructed.priority = 751;
                self.alignToConstructing.priority = 749;
            }];
    }
    // animation
    [self.view layoutIfNeeded];
    // scroll view
    [self.mainScrollView setContentOffset:CGPointMake(ScreenWidth*index, 0) animated:animated];
}


# pragma mark - <ConstructionDatePickerVCDelegate>
// 选择日期
-(void)finishUpdateDate{
    [SVProgressHUD showSuccessWithStatus:@"提交成功"];
    [SVProgressHUD dismissWithDelay:0.2];
    self.constructedBtn.enabled = YES;
    self.checkConstructBtn.enabled = YES;
    [self scroll2VCIndex:1 withAnimated:NO];
}

# pragma mark - <NormalUpLoadImgViewControllerDelegate>
// 完成整个项目
-(void)finishTheWholeProject{
    [SVProgressHUD showSuccessWithStatus:@"提交成功"];
    [SVProgressHUD dismissWithDelay:0.2];
    self.showAsSingleCollection = YES;
    [self scroll2VCIndex:0 withAnimated:NO];
}


# pragma mark - prepare4segue
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"pickDate"]){
        // 选择完成日期
        ConstructionDatePickerVC *controller = segue.destinationViewController;
        controller.projectId = self.projectId;
        controller.delegate = self;
    }
}

@end
