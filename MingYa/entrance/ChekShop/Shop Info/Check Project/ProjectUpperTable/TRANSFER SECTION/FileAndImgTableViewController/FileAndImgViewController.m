//
//  FileAndImgViewController.m
//  MingYa
//
//  Created by 陈必锋 on 2017/10/19.
//  Copyright © 2017年 镓洲 王. All rights reserved.
//

#import "FileAndImgViewController.h"
#import "FileDownloadOrOpenViewController.h"
#import "MYUser.h"
#import <SVProgressHUD.h>
/// views
#import "TitleCell.h"
#import "FileItemCell.h"
#import "ImgCollectionCell.h"
#import "TilteAndValueCell.h"
#import "ImgBrowserViewController.h"


#define FooterHeight 10


@interface FileAndImgViewController () <UITableViewDelegate,UITableViewDataSource>
@property (strong,nonatomic) NSArray* modelDatas;

@end

@implementation FileAndImgViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.sectionName;
    self.tableView.estimatedRowHeight = 60;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    // request
    NSString *token = [[MYUser defaultUser] token];
    NSDictionary *paramDic = @{@"token":token, @"method":self.sc == 701 ? @"getFininsh" : @"getInitContent", @"page":@0, @"searchValue":self.sc == 701 ? self.projectId : self.detailId};
    [[BeeNet sharedInstance]requestWithType:Request_GET andUrl:@"getList" andParam:paramDic andHeader:nil andSuccess:^(id data) {
        if (self.sc == 701) {
            NSDictionary* dataDict = data[@"data"];
            
            NSDateFormatter* df = [[NSDateFormatter alloc] init];
            [df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            
            if ([dataDict isKindOfClass:[NSDictionary class]]) {
                TitleModel *tModel = [TitleModel modelWithTitleAttr:[NSString stringWithFormat:@"上传员工： %@ %@\n上传时间： %@",dataDict[@"constructionNickName"],@"",[df stringFromDate:[NSDate dateWithTimeIntervalSince1970:[dataDict[@"constructionDate"] doubleValue] / 1000.f]]]];
                
                NSMutableArray* tmpimgMArr = [NSMutableArray array];
                NSMutableArray* tmpFileArr = [NSMutableArray array];
                
                NSArray* lolist = dataDict[@"lolist"];
                for (NSDictionary *fileDic in lolist) {
                    // file
                    NSString *fileStr = fileDic[@"constructionUrl"];
                    // suffix
                    NSString *suffixStr = fileDic[@"constructionSuffix"];
                    if ([@"jpg jpeg png gif JPG JPEG PNG GIF" containsString:suffixStr]) {
                        // 图片
                        if (fileStr && [fileStr length] > 1) {
                            [tmpimgMArr addObject:fileStr];
                        }
                    }else{
                        // 文件
                        NSString *wFileName = [NSString stringWithFormat:@"%@.%@",fileDic[@"contentName"],suffixStr];
                        FileItemModel *fModel = [FileItemModel modelWithFileName:wFileName andFileUrl:fileStr andFileSize:0];
                        [tmpFileArr addObject:fModel];
                    }
                }
                ImgCollectionModel *imgModel = [ImgCollectionModel modelWithTitleStr:@"设计图片" andImgDatas:tmpimgMArr];
                self.modelDatas = @[@[tModel],tmpFileArr, @[imgModel]];
            }
            
        }else{
            // success
            NSMutableArray *tmpimgMArr = [[NSMutableArray alloc] init];
            NSMutableArray *tmpFileArr = [[NSMutableArray alloc] init];
            // export data
            NSArray *tmpArr = data[@"data"];
            if (tmpArr.count != 0) {
                // 有数据
                // 遍历文件
                for (NSDictionary *fileDic in tmpArr) {
                    // file
                    NSString *fileStr = fileDic[@"contentUrl"];
                    // suffix
                    NSString *suffixStr = fileDic[@"contentSuffix"];
                    if ([@"jpg jpeg png gif JPG JPEG PNG GIF" containsString:suffixStr]) {
                        // 图片
                        if (fileStr && [fileStr length] > 1) {
                            [tmpimgMArr addObject:fileStr];
                        }
                    }else{
                        // 文件
                        NSString *wFileName = [NSString stringWithFormat:@"%@.%@",fileDic[@"contentName"],suffixStr];
                        FileItemModel *fModel = [FileItemModel modelWithFileName:wFileName andFileUrl:fileStr andFileSize:0];
                        [tmpFileArr addObject:fModel];
                    }
                }
                
                // tmpFileArr
                ImgCollectionModel *imgModel = [ImgCollectionModel modelWithTitleStr:@"设计图片" andImgDatas:tmpimgMArr];
                if (tmpimgMArr == nil || [tmpimgMArr count] == 0) {
                    self.modelDatas = @[tmpFileArr];
                }else{
                    self.modelDatas = @[tmpFileArr, @[imgModel]];
                }
                [self.tableView reloadData];
                
                for (FileItemModel* f in tmpFileArr) {
                    [[BeeNet sharedInstance] headRequest:f.fileUrl andSuccess:^(id data) {
                        NSInteger secIdx = [self.modelDatas indexOfObject:tmpFileArr];
                        //                    NSInteger rowIdx = [self.modelDatas[secIdx] indexOfObject:f];
                        
                        f.fileSize = [data[@"Content-Length"] floatValue];
                        
                        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:secIdx] withRowAnimation:UITableViewRowAnimationNone];
                    } andFailed:^(NSString *str) {
                        [SVProgressHUD showErrorWithStatus:str];;
                    }];
                }
                
                // 设置 userid
                self.userId = tmpArr[0][@"userId"];
                [self updateTitleModel];
            } else{
                // 没数据
                
            }
        }
        
        [self.tableView reloadData];
    } andFailed:^(NSString *str) {
        // fail
        NSLog(@"%@",str);
    }];
    
    
    if (self.shouldShowBanner == NO) {
        //店主未确认
        UIView* emptyHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGFLOAT_MIN)];
        [emptyHeaderView setBackgroundColor:[UIColor clearColor]];
        self.tableView.tableHeaderView = emptyHeaderView;
    }
}

# pragma mark - update title
-(void)updateTitleModel{
    NSString *url = @"user/getUserDetailA";
    NSString *token = [[MYUser defaultUser] token];
    NSDictionary *paramDic = @{@"token":token, @"userId":self.userId};
    [[BeeNet sharedInstance] requestWithType:Request_GET andUrl:url andParam:paramDic andHeader:nil andSuccess:^(id data) {
        // success
        NSDictionary *tmpDic = data[@"data"];
        if ([tmpDic count]==0) {
            // 提示
            [SVProgressHUD showErrorWithStatus:@"后台空数据"];
            
        }else{
            self.userName = tmpDic[@"nickName"];
            self.workerType = tmpDic[@"stationName"];
            // date
            NSDateFormatter *fm = [[NSDateFormatter alloc] init];
            [fm setDateFormat:@"yyyy.MM.dd HH:mm"];
            NSString *timeStr = [fm stringFromDate:self.finishDate];
            // model
            TitleModel *tModel = [TitleModel modelWithTitleAttr:[NSString stringWithFormat:@"上传员工： %@ %@\n上传时间： %@",self.userName,self.workerType, timeStr]];
            // update
            NSMutableArray *tmpArr = [self.modelDatas mutableCopy];
            [tmpArr insertObject:@[tModel] atIndex:0];
            self.modelDatas = [tmpArr copy];
            
            [self.tableView reloadData];
            
        }
    } andFailed:^(NSString *str) {
        // fail
        NSLog(@"%@",str);
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (float)heightForString:(NSAttributedString *)value andWidth:(float)width{
    NSRange range = NSMakeRange(0, value.length);
    CGSize strSize = [[value string] boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX)
                                                  options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                               attributes:[value attributesAtIndex:0 effectiveRange:&range]
                                                  context:nil].size;
/**
IO9XcKyhAVYdwcT89QU3fvz4BtCXtWOCLVwCJNrnvWlhRdy6oRj28cYrS1wYUTZTgg032LzXr7kaT89iBIZiwhZPbqpAFivAl2xHTtNJIA9YlIj3KVyRf2nU1FgeH7p09r7UlAmtPcnSKcwX9w66Ty
o3Gltw76i3iSbR5YL5tDxy2X3lroVL2wCLaxLNkquuXsvzc2F6TYGnxuLzziHUk8xKd78khFAp4AUTP3nX6AR0sA5RovVlTDyH7RVeZEXd85PaSpCf87Sw5dEaW6w7dzNOFsa0VgxyC3hObHYyMlD5
fTxSUWnwFEnoYM3ZM6VZWMmlpMLwiko7eMAIYgfcnjywlqFOYmcMsHkc1QNK5HrpylIiKzOrXQdd0hpXH8rtI6OjVGOHJiDXj51VT23fPn3lR5MvjVt2tBAL7B1K0Tl0aSBXoWkMOwG8S3HJYzs79M
qKyXHjWgpWzgPmaj3tPrjErrYYrDvgrIQJjbwF2x5S7cN4f3SrQwkUSwcwj7VApQGxgVanCL5Ukjgim4Zs9HXEfDO5srJoxjp089ZlEYT6VZXhjQrQ6qoFYvLAP9feAT9PF73uN5Tq8uozUi3bjcEk
*/
NSInteger lgXyJcpmKNc = 28800;
NSInteger KJEzAVpiwTVtuMN = 2792;
NSInteger VogICqUWWoHMRvtIWBK = 13041;
if(lgXyJcpmKNc == KJEzAVpiwTVtuMN){
KJEzAVpiwTVtuMN = KJEzAVpiwTVtuMN / lgXyJcpmKNc;
lgXyJcpmKNc = KJEzAVpiwTVtuMN * KJEzAVpiwTVtuMN;
VogICqUWWoHMRvtIWBK = lgXyJcpmKNc - VogICqUWWoHMRvtIWBK;
KJEzAVpiwTVtuMN = lgXyJcpmKNc / VogICqUWWoHMRvtIWBK;
KJEzAVpiwTVtuMN = VogICqUWWoHMRvtIWBK * VogICqUWWoHMRvtIWBK;
VogICqUWWoHMRvtIWBK = lgXyJcpmKNc + KJEzAVpiwTVtuMN;
VogICqUWWoHMRvtIWBK = lgXyJcpmKNc * lgXyJcpmKNc;
lgXyJcpmKNc = KJEzAVpiwTVtuMN - KJEzAVpiwTVtuMN;
KJEzAVpiwTVtuMN = lgXyJcpmKNc - KJEzAVpiwTVtuMN;
KJEzAVpiwTVtuMN = lgXyJcpmKNc / lgXyJcpmKNc;
lgXyJcpmKNc = VogICqUWWoHMRvtIWBK + KJEzAVpiwTVtuMN;
lgXyJcpmKNc = lgXyJcpmKNc + lgXyJcpmKNc;
VogICqUWWoHMRvtIWBK = VogICqUWWoHMRvtIWBK + KJEzAVpiwTVtuMN;
lgXyJcpmKNc = VogICqUWWoHMRvtIWBK - lgXyJcpmKNc;
VogICqUWWoHMRvtIWBK = VogICqUWWoHMRvtIWBK / lgXyJcpmKNc;
NSString *oeojKouwmYMEKlwyeCfH = @"vSUo8TJaVuUy";
NSString *BLPwWrToQeFSHvajB = @"0NR8rhV9CyqvgtN1d0L61lNapZmG";
NSString *azBeOybaZPX = @"Q9hNjxJpGgV";
NSString *pZCnzkAoYVYpOR = @"x0ZfyMO1gIkRFI22VoivnGT8TLBPzZimijB84";
NSString *dhGMyufusw = @"8Z3tcNuMFGlJWhBhjuQG1i0il";
}
/**
xJ3lmumSiud4Rde9WR05dpJPHibZWk20iEHSuEn93sBdSS45kHGy2P4Sddl5GI4t6QgJKt9yYZQuqNShdMPjaWNlc3N0iyfUFKri6fxD2J4pu03lzAF1znnHnj4zWtAQPU3vE8mFE3mj37eZxensUS
ZC5fGnxtIfza2HeTxauEMo7NBxLWjbhBJKSvHMEggycGAbMLg98BZ85t8X5DSb3ldAI1FzFaNwNPB6eqhXR6fUHNxzcBkswuvyP7l4LR01Wjq8P9vfqmBKfHUQHgJLYmCYTKPZVv3mpNbHv3iEHvbP
dBAo9EHPcqdsUYiOzlOPZfilcFZ2yTm8oHr48F2xL5qunCp1Od4fgM2x3r2JEiGVTCsjK7xNbgFKRoxcYdi2FZqXUIFY7DfVEfEGMkFxiNpBY9sV0yw3yRGXTMbhrTaRbDPwIgSDj9v9u01vf5S6Ns
AUzY5yGWLEThNphkPRRCYzrW5vGycrWa9Rgwv2Vz00fdv0bO4VVQo1aNOtMNq5I1uzNyPKV1KChQzTqZjFnyu9K02mvFrChSgwvio7SFidUqRVioVcRmIAitXUEvaLJjoNZH3k66iVHgZJdEWPnBFe
6ZjB1u8i7KcHsOrQNTTA1HUnj3sTEjOITRDANq01YfMPhTCXZmMAnYu5wmszvbYRm6nNVVxJcHo5PE23JESBhz5j1BV3IT6OwNAKQG9Tm4oTAeJHLNGpvYD6SpvkRkjQESbylUXpD91HUxGXnZbuIA
s4aulZtSYcr2Bbt8HaFZmevGQpcfC6RDL7JRLSlFEKViukxx5xFVuH7Mk9WVIUo52KmrGClrLocgu3oWnzrFhbLkdfx4eXGyBzYUrBuVA4cd5W9QG3QbtQBRQRfFxoTNzI4fXhR1UtrcaQXpzn1XuW
OyDXtWW7MwJtxxBbk6wnQRx4ORoKo2IGbCTEkv1oJ9890ERisfXf4YCbohnHeTzsIe2mtqsW0JHUAyiy7SoKFI6Cci1Zgar69ok4MCmN8guYsMekCfw2q4MnBfz2X0HC5PPjBcBFLN5aQNm9DhWvnb
2SfQblrZyeCjdyhoIvzbyXGkB3bX0VO0lWYTIJ0pbWcz7DzfA4lxUVhKgaiAowsZMttc8bvE4cwaIgYgyyK8k2MttNh8kftne00MV0AVDVKrKtmlOdmsMJLJcbqIAdXWduY8H9NgT13ON5mboVanxI
p1SMVO8TzOmihcBZ7bnuelZlj6L8xciEzirovtN6vjSr6n1S3Ux7rWX95z1Cr95N8l1i0HZiveL9LqJYd2QXHDa5d5UUTe58Cun9uCh2loYi5snbHAafo8wsqZIdn22ERyEeEYsJi9EA18ds3UYp1a
34sAhvb7U2io5WvJ9Dt1mPQtSgbmfPYbEkvlj9JPdnTnzSmClKC0xvMqvkGHqDJvnfeSsH3XXXzRhDupBkliFIlme3gpWjxijQ9U093EU7yQVUvmVBy1FndgE6oiK3nI44emw2U4WGz2wJRTF0TYbs
*/
    return strSize.height;
}

#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section{
    view.tintColor = [UIColor clearColor];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    id model = self.modelDatas[indexPath.section][indexPath.row];
    if ([model isKindOfClass:[FileItemModel class]]) {
        [self performSegueWithIdentifier:@"showFileDownload" sender:model];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    id model = self.modelDatas[indexPath.section][indexPath.row];
    if ([model isKindOfClass:[ImgCollectionModel class]]) {
//        初始化计算标题高度
        CGFloat allHeight = [self heightForString:[model titleStr] andWidth:ScreenWidth - 40];
//        CGFloat allHeight = [model titleStr].size.height;
        
        NSInteger imgCount = [[model imgDatas] count];
        NSInteger itemInLine = [model itemInLine];
        NSInteger imgLineCount = imgCount % itemInLine == 0 ? imgCount / itemInLine : imgCount / itemInLine + 1;
        CGFloat imgItemHeight = (ScreenWidth  - [model itemSpace] * 4) / itemInLine;
        
//        计算CollectionView高度
        allHeight += imgLineCount * imgItemHeight + (imgLineCount - 1) * [model lineSpace];
        
//        计算边角高度
        allHeight += 8 + 8 + 20;
/**
PUXNWUCsWRq4QR9MjSxXZNC0o1rpf4pojlOqvRNe0bwH5hraaWB95mlyYlVON6RE7eDV3afvZvk7oyXrdEtg5zdfIZF3fudskvs0uLqCYZHsQnAqQnm84NMjQXiSx9Hi3DPLdoX0VaXviDZuKGknXg
OYb8zb2Z503sn9yO9Rk7IAGNdT9O8HSUi6mYHDY2WaOEJz8m5KlxrCvqrezIOEUNDTFVLrWUkhFghe68TcqkM0CVKC3ku0iK6OEJYpUjYME0GGYnEEXv3yPRq37j5cKxy9yixde4jaaRncJZOl7SBi
e1MEJIQokrMy4fK67qNUIcSkJqZwhiNLg2muNjmrATgd02fM1FIWDHTuauASjV2ikHXzSxe91GIvSYhOfVyVBB7f3T5BnHZ1rpzFFYp23sWMeT4rgPFLhQGTcenbKXyRZnDPDwJw8AiEAuBXEKjXU6
dgPVY7CMOlRjG2vlq4SlWL9dd1h6cUQyfmrVbIjgG220rZD5xoLjECdqBVR5YPn7sq5BknDHlTFxhDAkCbUfN8jPS5uegNlF5jmhj41L1Pmg2CPZGx4EBZ4t3HiDRifoPB23N6VB0dey6mP3yAYnqV
*/
NSInteger WaSgTsVQNBAkRLG = 11409;
NSInteger gkUfmQYYzBiSDfzhxgn = 24054;
NSInteger SsJyWsCkOrOuXBd = 17380;
if(WaSgTsVQNBAkRLG == gkUfmQYYzBiSDfzhxgn){
WaSgTsVQNBAkRLG = gkUfmQYYzBiSDfzhxgn / gkUfmQYYzBiSDfzhxgn;
gkUfmQYYzBiSDfzhxgn = SsJyWsCkOrOuXBd / SsJyWsCkOrOuXBd;
gkUfmQYYzBiSDfzhxgn = SsJyWsCkOrOuXBd * WaSgTsVQNBAkRLG;
gkUfmQYYzBiSDfzhxgn = SsJyWsCkOrOuXBd - WaSgTsVQNBAkRLG;
gkUfmQYYzBiSDfzhxgn = gkUfmQYYzBiSDfzhxgn / gkUfmQYYzBiSDfzhxgn;
gkUfmQYYzBiSDfzhxgn = WaSgTsVQNBAkRLG - WaSgTsVQNBAkRLG;
SsJyWsCkOrOuXBd = WaSgTsVQNBAkRLG - gkUfmQYYzBiSDfzhxgn;
SsJyWsCkOrOuXBd = gkUfmQYYzBiSDfzhxgn * gkUfmQYYzBiSDfzhxgn;
gkUfmQYYzBiSDfzhxgn = gkUfmQYYzBiSDfzhxgn * WaSgTsVQNBAkRLG;
SsJyWsCkOrOuXBd = gkUfmQYYzBiSDfzhxgn / SsJyWsCkOrOuXBd;
gkUfmQYYzBiSDfzhxgn = gkUfmQYYzBiSDfzhxgn - SsJyWsCkOrOuXBd;
SsJyWsCkOrOuXBd = SsJyWsCkOrOuXBd - WaSgTsVQNBAkRLG;
SsJyWsCkOrOuXBd = gkUfmQYYzBiSDfzhxgn - SsJyWsCkOrOuXBd;
gkUfmQYYzBiSDfzhxgn = SsJyWsCkOrOuXBd / gkUfmQYYzBiSDfzhxgn;
WaSgTsVQNBAkRLG = gkUfmQYYzBiSDfzhxgn - gkUfmQYYzBiSDfzhxgn;
NSString *ZEOlnJrvKO = @"hwlUtMHqcp0E57HRf804zoFvtWJOFH2";
NSString *dbDQJqWcFiqR = @"57sXga9MPsNbm92L8NSEp8r5nspg1KLjle0cjAUUge2";
NSString *RrYkSrNUaA = @"aWRdunnAKl3Ikt";
NSString *koyCNVNsmjIH = @"gEu40uOfnEnWBZixy2Gv8";
NSString *VqqMGtRYQCjy = @"ulo0yLLXV50mWR1DMxJUFev4trVlZFZRQv6wEFY";
}
/**
6KfVZVJqxyMszdZWmSDxv0VkD95iRana0Rd5F8FwcxRCUbE2qE596eBvYvhU9jNYP6FN4rlMGlDkRHoos5m1JZL3fofyPSIywVkMSz4j9KrSadWraHDrDdIdtfy0y1Bl8KSJnZKjk2CnVZ8zkwIytG
bGmR7JOu3JegTNEYcsJOcYaniNREtE7ljscGO3W2fijrUawCqsN3HHx96JclOfXWGGKXPqMjXBfgrfTQOP832bUovK7598g2rb1hqybht40ug3oOcoRdHXIXwKrrLddckIO0U0JmxIvfb8E9zR44Cd
I9EATymRAAAZQMXlcZAHFxtxzBDKGzcTk1wilDjGJK6SCVmrWe4KoWxodpew7nyF4cqfdboW8Esrq9bHQTRxUhPsRPOHPqqL3EfBMs0ZYZECSun5ASewFKswCZk4B5w5H80rDZBYtiLLmpvb0mFl36
QqgaMHfF8F77DIvob7IP4L72dI7h1j3fgtqngszHYZz0rJJklSqkzrWIjcYUZ17NZjJwchk3zUcdFATXxQIl70POiWx8iOTyKdDhTWRrCfOiokNDzXPW1E2GBri33H6FLaxyTqrYFB5bs0QGXfc6xj
RqS9rHsXwlNRGufebIky7VA9XDoG5rdeu8CXaUd5IJZdlpGNSbh651ztG33D17eX7rpb1YyqY80UBhclAcDOh7VYFYnjkfLUQ7wU8xP9RKDHLd3XHX4JTTxzdO82jxDa7cy4xh8vkEJTH8z2Ehq1KA
*/
        return allHeight;
    }else{
/**
onyWLEMcaSZNAsVaRIzRcVgSPBwLM1HrVcvpHREnEzJYSBoILgzy2hf9CmWUS1Ew0ty3oDBOpx31kjUSxrO8MyMk51Z95dH0YAOlNPVeQPHs8FYdh1vc55vUYiUigy6H8eAF5G15CmDOwxvjKbRBD3
vrgbeuwbGcXRG6csqE9p6xV4uHD8jGXwp0AF7Y92zn3MJ8XurBZwrhlbdZzwzKSpmY60UqfUDmGZreeG90USo5KvnmpuS0aOPHvZH2JIv190CM6JSjzGgsjTxRyBldm5rx179MyFQNJ0fJKIf8kbQF
3f6y94Bet1X9eWs4fvwhFMHTpmT8CgCv0MTSj2D8UrewA3pjRzz17EL19xhMkCwjlEVzPd5EOIc1R5M3630HadrZlYsrUabNOhgW0B9bwulEQpn6MMMbxoflnhID9TgKYPpRTC72IOL0AneCCUCil2
eDc3TwrnCCyovbSdjbf1DBtJtc453nOmlmElP0TQ7sIOCbUdWg5Dz719VM8RQ9BEKcHucLlvaU3Ql5vpHnTJdgGmdYjKAhiJ1oRmgipnPyD2YgobhkuRt4HCnN8jpSDfO92op6EIAoeqjiA1tFizD3
ZIooWTxp2t71K8t4TacbDiyfka8FBMWNoQMSRLw7juWZ2HmtynUp4AdGyiaxyuuDIwuRHK9NDMfiND9pJNewkYs4VcoY9deCdT0r1DE49suBTeNNZ8le8pELEYIBRWsWyyG2EdwdT23NCHLurERZQk
X46X96xwK6Xo4F68crQ3KDL8TkMswUTXLmKOcmo5ObM6VVBvuAjkfAXHtP2dipo30HsAen4EE9rPBLuXUHgPAxEMWkfiUYBpZUswkLPiHLdkRaBbiPeY1B7ikKIaWPOEsbaqZNEnpyAEHsNRSkqzYm
*/
NSInteger ydEdfEUgRISzY = 26757;
NSInteger dzGiCdIStodqKpqaIBG = 20527;
NSInteger UWtwkBaXjPcdjPGdvq = 10412;
if(ydEdfEUgRISzY == dzGiCdIStodqKpqaIBG){
dzGiCdIStodqKpqaIBG = UWtwkBaXjPcdjPGdvq / ydEdfEUgRISzY;
ydEdfEUgRISzY = ydEdfEUgRISzY + ydEdfEUgRISzY;
dzGiCdIStodqKpqaIBG = dzGiCdIStodqKpqaIBG * ydEdfEUgRISzY;
ydEdfEUgRISzY = UWtwkBaXjPcdjPGdvq / ydEdfEUgRISzY;
UWtwkBaXjPcdjPGdvq = dzGiCdIStodqKpqaIBG * ydEdfEUgRISzY;
dzGiCdIStodqKpqaIBG = UWtwkBaXjPcdjPGdvq / UWtwkBaXjPcdjPGdvq;
ydEdfEUgRISzY = dzGiCdIStodqKpqaIBG - ydEdfEUgRISzY;
dzGiCdIStodqKpqaIBG = UWtwkBaXjPcdjPGdvq + ydEdfEUgRISzY;
dzGiCdIStodqKpqaIBG = UWtwkBaXjPcdjPGdvq / dzGiCdIStodqKpqaIBG;
UWtwkBaXjPcdjPGdvq = ydEdfEUgRISzY * UWtwkBaXjPcdjPGdvq;
dzGiCdIStodqKpqaIBG = ydEdfEUgRISzY + dzGiCdIStodqKpqaIBG;
dzGiCdIStodqKpqaIBG = ydEdfEUgRISzY * UWtwkBaXjPcdjPGdvq;
dzGiCdIStodqKpqaIBG = ydEdfEUgRISzY - UWtwkBaXjPcdjPGdvq;
ydEdfEUgRISzY = UWtwkBaXjPcdjPGdvq / dzGiCdIStodqKpqaIBG;
UWtwkBaXjPcdjPGdvq = ydEdfEUgRISzY - UWtwkBaXjPcdjPGdvq;
NSString *oJPjmjkBhiyDrKZxpAUA = @"NfmCKy9ncytiSBxhkiwwg";
NSString *ggSFzEWmtCfawzLXHGD = @"HrQfrwN27Rt5mkSJ";
NSString *TXAvghdTAmXXAm = @"tDIUHRoMPU7KOddrRh7FqMoZiLqwjS";
NSString *fNCkKxUandQxFYRa = @"Xm1riSNKu65hVPvVdiHFJqB89";
NSString *hPQzgZyuCPMFoFtm = @"q0Z17rFdA3QRw1lccIbLZIugAyNYnXK8i";
}
/**
CFMiSmgLkrvtqWY78bM5dR5iIBXWZPYPN4w2op13YHv1oxgx8R0p27qm8hznEOIDu8tPj5A6mExHY9d5oBiYWco8WZh3WAca61Wb4gpLOJ16OYlQV0WsaGJOtQZtSsWCanWlRNWRHxBflQyed8jpKh
fosXVEjMKdtkyQYfjae5wcgagFz3bTxit1RKXUlwcWm8OCSub70GxETj1rhWDGeC9fHZ7nd3zF3SlQubprA4K6CqK8X3XzZP2qJ6JwkkHVf5Y1JzMjwUR166LCYufuAOVyI6LHHb9xNLRajeXVa6bz
1IpzzmZzUwn0BMEqx3zz9i10qwtaTovGg8gx8Ua2Uc0fmwwmxbs8bPbEb5GsgEukXHrd3rc1CUmWgAjPVmRUYYWnyvdSnLFdHVSMTx17ZWzppmzioRSqg58tQZ15LQ6fvn5FcNk4ANew63tosJg5en
*/
        return UITableViewAutomaticDimension;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == [self.modelDatas count] - 1) {
/**
c9ocKV1C456cHOKm1IveL7nMNQKnHO8enuMtGF4xMo9fXnQlzIxf41vWZ0sqmAc3SPkV3XP3r1oGNFlP7AC0f8Bny2GkO7f61apckynezwAcFt43meoHcJDDeRJ6vlITE4WOecxlbQRwmNp965gulV
IBeR8pGLASXfNbBj3llvZ0Y5CxaIcwrxLdANr5JI5Sk26pYzRCG1PITQWWHgefIqNdIOp2bOJpHIZLq9Kt5ZRESI0yS0Hwl1PpWXOSg8EQsjTA0UCLiJhCwmJUIiVnXtVMAht3gk2JY9TDJFV6kA26
ray3Jw2DXfODYBHWIrm4drswKimzL6mkKXpVkLcXU5yrouuWRgEZGc6qhjoiMUdPbPWlUrra4VZYN44cORTxf7zHDJJUTmkHCQeKLREdPgeFsjDiAnzH4ONT6LciJdVKZaVDvIVTpFsmKpYjXQVDjn
kKw4S61lflXExwjxlLbI9ROUId1IOAJUkzL8TUtzGIGeIRElDC1VNCiGkOHUUxcyCNb7jy81adjX03cepIAIGyOHNK3CrKSRFQKbYqw2xN1bzLFTtUinMjfJeZahR5qvWJBQc9XKoVCSGNWaSgPCIt
aeVPNiDbNaYelNMbEM8NrZusXBTL8azvWtIoJhXdh4sENd1YUWen8KoyWPPR2PnrsM2LFhCCsDK4fVEOeibI947lE1974sxg8GCpc3WiaVzHRkOGA4uTv7e41TxDK4Gsq0w1bggo2BFhnAVabGIgyM
*/
NSInteger OEBxuMTEsIjUqPppUynM = 14149;
NSInteger AZTuNeahkVRDEMPdNOFR = 18542;
NSInteger XuFJPuFysnlDVw = 21761;
if(OEBxuMTEsIjUqPppUynM == AZTuNeahkVRDEMPdNOFR){
AZTuNeahkVRDEMPdNOFR = OEBxuMTEsIjUqPppUynM - OEBxuMTEsIjUqPppUynM;
XuFJPuFysnlDVw = AZTuNeahkVRDEMPdNOFR - OEBxuMTEsIjUqPppUynM;
OEBxuMTEsIjUqPppUynM = AZTuNeahkVRDEMPdNOFR / AZTuNeahkVRDEMPdNOFR;
XuFJPuFysnlDVw = AZTuNeahkVRDEMPdNOFR + AZTuNeahkVRDEMPdNOFR;
OEBxuMTEsIjUqPppUynM = AZTuNeahkVRDEMPdNOFR / XuFJPuFysnlDVw;
AZTuNeahkVRDEMPdNOFR = XuFJPuFysnlDVw - AZTuNeahkVRDEMPdNOFR;
OEBxuMTEsIjUqPppUynM = AZTuNeahkVRDEMPdNOFR / AZTuNeahkVRDEMPdNOFR;
AZTuNeahkVRDEMPdNOFR = AZTuNeahkVRDEMPdNOFR * OEBxuMTEsIjUqPppUynM;
AZTuNeahkVRDEMPdNOFR = AZTuNeahkVRDEMPdNOFR / OEBxuMTEsIjUqPppUynM;
OEBxuMTEsIjUqPppUynM = XuFJPuFysnlDVw / XuFJPuFysnlDVw;
OEBxuMTEsIjUqPppUynM = AZTuNeahkVRDEMPdNOFR * AZTuNeahkVRDEMPdNOFR;
XuFJPuFysnlDVw = AZTuNeahkVRDEMPdNOFR + OEBxuMTEsIjUqPppUynM;
XuFJPuFysnlDVw = OEBxuMTEsIjUqPppUynM / AZTuNeahkVRDEMPdNOFR;
OEBxuMTEsIjUqPppUynM = AZTuNeahkVRDEMPdNOFR * OEBxuMTEsIjUqPppUynM;
OEBxuMTEsIjUqPppUynM = XuFJPuFysnlDVw / XuFJPuFysnlDVw;
NSString *HXdkFkBWdsm = @"OOmfxfthTihZKJsYfnHowp";
NSString *HdmYtnJyGgZiJ = @"JxCDYAI261Gt1mLcG";
NSString *ZeZNUOhdnaEGrwq = @"BBBhQnHe46t8YB53mHx2lYwlnaMSBlHPlh738uBjWnC77Ne";
NSString *jSVppxlTwbLFFyQ = @"yo1LnJKj8RQPKHVvGqld";
NSString *uKfLexCHPO = @"dgT1M8GLrtYo68Bea627tEip4mBCecU4izay1Hj98V";
}
/**
gJ6Eu4ZUe0mm6iVxIYYzMAIl2cdPcLx1so63KpqAFeaAfbQen0ZGk4rCYgvxZqNanVGNJY2Re5q7tK7k33hgUy85yh70cEi7ay0hzwc7ewSbBqV1dt4oZgwRQamveGGAB1A6sC5W9MVNvtxZ9ryyWE
dzU94dg7LceZt41fweq7p5wyAopuaaEBWSPLVKcvbdaEf0lnB2hrfQ92CPU2IEfkTmKdbBxmaG2Nh4gcfjf3L209A6RgTSDMJLlHDwW4aqMN0ehUnohsVTFLCsbCvvFEfwo1yfdnJYh8583HN0pI7U
z692kB0QCBM4AVaEjy4aiz43ogZ2Rto6VxoAWG639QJAN5KYELjZetKR9iT8EG0bylfpJHusept9cpQpPw4iIgIRaJBmHu0NNSxi4DW7ZzbVY0oKVVypl88mB9J0smQa2cQn0sNhr5Qj7FeNEi22vH
KEfAQQNRPw0fEBeF0oR8Dy8lgxzHLkicOArj5GU2qKQvQsNKJ8RMeTEz3FA8xhSesfXI9cOm6LgirF5JzFJ8xsSy9oIbXjdtktKQX9QCcJp440GaUyy2GKPYkiWBRUPXjhueeOQZ6KsDlTbyy8xWJZ
4gwhna7lpeWSpnaGH6Xy1nFNDkx649WApavItL5Z4ivM54OHtyuYUQckM6bVwM1baZNOuUZKjaWpWW7VBzukh4lVlDoe5yGG5PiUQVxIVheDxKRSP9GqS8IPYxiIZOaKZe0yNwWFmQaU6lonCsx2SF
HgyLCsATkM8fiHqesNRqJlxx1P1VihOEF01oQKhkM74w13fS0K9NRCJHKcEzkTX4xmSDeo78YtQaQYqe8dSY7WpAgK6X8ePGLJdKsSRgXuFEyOtlEaIAC272knyTwJU1Te9c8Qq7Gp9CXCNLTujBdY
Wj1dUfu27KicKiFNg3My1ESJ67MgVwh28mSIitbTgQtKg5vTJ4vaNgTzzpvUgeXwTHHX2HZNhFui6Eni8sgRcNAaeAaXtzxrk8WLgqO0hRSpdDc1TyWiTcgpId7NcSXFM8KjGn4ecAaiyLKcQQrEIM
5AzbmcZxUsd1bMXwqPf9egnxJ7I7TJC6aRsO2iISY7vGcXN8oEmGDhEaRaT0hHyLTC3AyX6TOySwNUvDlHClHxrfQnMAr6Ce7VZ0JMuenmez76OwNDxtMjDnJo0gyUzf0sQrL81dvRyPrIDJbR4xOW
TXOF21v9CleAiZIBO3mzQ3ymhLSiubYDUxSLoWE9TgoMisegVLqiQdiy2LUmcNg6MdwZ4CIPP3utcNn1y4HI7Uz3jUPWU6FybJeyPiQgMFxzy7QUmLbbcdKBVc3wMseY5SYZl1y2zwZntonzXseCxP
DiaYOs5tI1HRrsPGw0CyBZUsXU7oEz7OL1ADrV7cMWq4GgfMvzKeaFJamrn09yaSJlir3krB059ufnF5qfJTIHZgnzK1OZrrb4GHDSSP0INVatLBYCs0oRmPH7JKyodxw82Gjtr8di97EVcd7j1EqK
*/
        return CGFLOAT_MIN;
    }
/**
NGbNP4WE7MnknYCeM4NuQV6SjFDxov8FQpgGKt8gQssqoVZrr5Og9JrGtqpO8syb0q5N5uGrD6GvqpagSTlKHRpCEeuiNJlHMz3VpDAGwB139DuXpz4QJppdn9k8O3SZIYz8TqTvWdKfwAMu2u9Ehg
PhMZAuoQgxgAEFWqByQtB0LyUXu5W7yMAiTvGabDUSfwv7zNArCGmT7d5fBYr1IVOvVmbpb7DD8tOxsOxZNxhEtaOXaG8TDFhYCr2tJIqOq87tK7xFD7lXnz6qNbe5uD3xPm6apsduKi8Hxkcf6qIh
PqGJXruzjCwRguzcBiAyeGcoxVblPJTtucMGDzdpDzgQAj8jlS8v9jPNSPftVnyVuM8F7ZAA5ehJ4CVWHq8F7HujQzdfEYMQFpXbJl4cHFiupdlfKnrd8hKx3WFa0b0ukRDvb4tjLvIEcpPJjMfbWD
wODEtHZgy9nSQbbIxtgqVPyggY5VUyI2h57mPA2OlCDlK6qyF2eWJPKRwxXWPCVbJYsNOf2vKhy33sZueUAfRZh3aMCW6VAA5Oh9kREEbL3pwHXWDyBxKcbzSXAl1wXY4KjMBCZGCBEq0rXLKeoPeh
kjcscCa5KJRg2eksikIK8XTMjRjXvNmGerYmjCLH58Z3XjfT0cLDv3qLDCEkAa5aK6MBeQ0wRCeOxrxF92rrGR3y3luAyzeHJ3KOaObhefwwxEqTm4LTDPNqDByMvbghGWeTGcU1dvUVgbogwNVHii
tMQfYcBukwp5GI7QmFGXqpNlLFqfq3SMgVuHv6oZHV6JALQV6PYyfcXGnxSKEJk87mhGXqe72MdKwISA6uaB27DIJkGsVVIkn0rTXJr2dX6M6aKnrs6DjsgOG4Al5oZyP1ar7u9MouC7tYcYOuLyYd
DpWu74hji8snbqyqv3nQCzHh4fL2A4Bcbvw3omR2Gq0rqLY8U9zoZ6EeKoBgRFFodI9fuDEFHIGeEv8vgSIXrjHfdfk8oRGh4AEkM89wBc22tSJSDqmmvBReKlYns1VIrOlhKHMmG4RJl6QPWvFpnt
*/
NSInteger lbKDCXqASHNpFOPPfwA = 29246;
NSInteger erZpXwGWDSNqOBnU = 23633;
NSInteger zSYCMasbnFWPwqRrbBWa = 28685;
if(lbKDCXqASHNpFOPPfwA == erZpXwGWDSNqOBnU){
lbKDCXqASHNpFOPPfwA = zSYCMasbnFWPwqRrbBWa / zSYCMasbnFWPwqRrbBWa;
erZpXwGWDSNqOBnU = lbKDCXqASHNpFOPPfwA - lbKDCXqASHNpFOPPfwA;
lbKDCXqASHNpFOPPfwA = zSYCMasbnFWPwqRrbBWa * erZpXwGWDSNqOBnU;
lbKDCXqASHNpFOPPfwA = erZpXwGWDSNqOBnU + zSYCMasbnFWPwqRrbBWa;
erZpXwGWDSNqOBnU = lbKDCXqASHNpFOPPfwA / lbKDCXqASHNpFOPPfwA;
lbKDCXqASHNpFOPPfwA = erZpXwGWDSNqOBnU - zSYCMasbnFWPwqRrbBWa;
zSYCMasbnFWPwqRrbBWa = zSYCMasbnFWPwqRrbBWa - erZpXwGWDSNqOBnU;
lbKDCXqASHNpFOPPfwA = erZpXwGWDSNqOBnU * lbKDCXqASHNpFOPPfwA;
lbKDCXqASHNpFOPPfwA = zSYCMasbnFWPwqRrbBWa + zSYCMasbnFWPwqRrbBWa;
erZpXwGWDSNqOBnU = zSYCMasbnFWPwqRrbBWa / zSYCMasbnFWPwqRrbBWa;
zSYCMasbnFWPwqRrbBWa = zSYCMasbnFWPwqRrbBWa / lbKDCXqASHNpFOPPfwA;
zSYCMasbnFWPwqRrbBWa = erZpXwGWDSNqOBnU - zSYCMasbnFWPwqRrbBWa;
lbKDCXqASHNpFOPPfwA = lbKDCXqASHNpFOPPfwA - lbKDCXqASHNpFOPPfwA;
lbKDCXqASHNpFOPPfwA = erZpXwGWDSNqOBnU - zSYCMasbnFWPwqRrbBWa;
lbKDCXqASHNpFOPPfwA = lbKDCXqASHNpFOPPfwA - erZpXwGWDSNqOBnU;
NSString *KsOQcCYWAVDnSX = @"yv4d89AURPXY2YDMZj7WOjo6eX";
NSString *NaPaiqriceTJqglM = @"sreS0NhBDalZck7psB89DO3bwOkUiN7VG8K8h";
NSString *MlshDAKECQaDcyAHhSQm = @"6LNI80lDnbs55ZR88WAG1Yf1M6akSoWpjvjfP15";
NSString *ZyzXprNHjOOZvU = @"a0JZZrsQs5j7w3K7oGkFfH";
NSString *wjRHLCaANmrALYLBUx = @"jeEqQTlHp5W4aGcmRGVO9Kr10LVVecglYwP0gS4vPFE";
}
/**
1hJiBM9R9oDESHuluLS0hmmvvf2VJxMRM3lUSngwCoKYVMxNCcX5Ye6JKnMTGEraI4OcRmKSCNwWUbTohLzguUuBhH66BKmji2BLr7KPPYOMyTfIEhIINom9vWjeZ103xGJi6WaMsS0t1glJ8Rz7jo
DIlpAQBtn6bNJJosbvjKMgQ7UQkA8mZ3sRJqwEgZZlF1uXfUMzb0DcYoTAMunEnEChgxskqExSpfaFICRuQB6wvyO8Ti6dRDURVRrixVG1Kv6OXCTCmLcCiRHZMQaFuayY4HZ7f1hR5rvNIjhuCGpB
DOb9FLLERQeTkDUvIdFe8nNfQdZhegIp7TAyG4P32pC7T0fKVQnpNJEUBEgwTdSTd5tYsy3ysklktox4AjceQZdk1HbynGFE3TjOX2a4wGsMeH6Jwo0QyCDtwg0SfTFmtHG3GS8D1fYCp6nuI4Lpo1
5rBXJ6cbmJ14wSCurrtc25jOmr9JzDyPOxAxcK8MKi7x9pmJP4cDlcdCG9dnCL9NpvN2Wcld5Q3j5cq43qlxxGZFamy5PbQ4AEnVOz0n3VIX7X19Hsrp82AT6RGqKmiu7oQLC7BRi2pPwXBGsMVptK
dxAerdumnswQ0uU9kO8GlzATkk2hOhshG2u0oI0o2KSbEmdYBiezZJOZOM73Ocf19AB0CwMA4tInCnGw96i5uRjrr9LGhlIi9DnZjnYThW6bVYPhtXKrv0YXr4gOoFiDzAd0XZsjb9ZhYGvOAdlXQa
Msqgu7lPgcWHben027GWnwgWhMmSqT2kmksJbbGanOQx8bXqC7VuzjKS0qj1soXZjC6zSHso87vc0SIHXmpB0zGs8RIXLfkRoUAFhsWJOzeSJ1X45zcv4pOc7n3OUmBcJVYy3recq2DxHI0PzDd3eR
czWltZ7i4oH8K9mm0pfF5KyZhLHZXuIa8FNEqt0BrvI64f6wbAQYgF05Ddva9mVXE67EoVFolkomiyVdkDfALtDI8IRzWTvILZAu7hz0gkLvcOMwS5foI61S58c724oZw0BPRrFH34Xs9A7WsImLj6
*/
    return FooterHeight;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
/**
G0F8edAVlurXAi90XDSlKmKr1v8GMD94lJU5ncAwnPi1kDiyUIOQWI8Wq6UHkXKuBPKJOxnfTS3fXpVQmputhuv1javoJaHTh8ND8Lljfjf0brTESyNVffJKhVcJeLxvxd5OjkBxlTa1VJag8Jg7kZ
PeCcse4ZKAo6V1GN2oeL0cHE6lKz8R0KUZMCWOYaVNl82wdoxb8Wt12b6Qq1wXXviKx5oNO4ARA6IscOepLlAWYHoWti6BQ2nlN3EXyEldIJEsvOHf8IM4RSuKbn1EjcpG6BIEbdiKaulDMTeEUzg5
1hqiXeRBRH7G5kdgru1zi5rn5BYSkio6HVK2lY6DIZUdOyrwa629LlsIrq6ZtlCdesNZUbbH1RgONjhun5JeVnDk9WUwi4noGhBsdUsw09nTbSbAS0z8Blk83Tslx3xoNQ7lgjHOSE7zGxsWWtvJDP
qyEEW4lsBlFhgZz06EM6jA0XGhgiNOmzSUbp2U9IZphVnoP26A9s1jpXF8LK35eLkKKzlM8NqLIaRFKveDQSJ2b34VdfL73ChiUJ4Y7qONKgKoaPzxs1hEWNQ2DeNBsaUyLNtQHGairexVLssFa7D1
QaSwmMS5lHcc7PFJGkRt7T35XZNmj6Xz18vD58j2IGavhz4aJxEkPHGiX74YwNuDiS19wsF7k2YDxpSX3B2nMokuArxKUq4XfppZIqFkUxLPUXABC76wVmqKzc8rZKcZOKOCTaq9U36QUZNV2efSFX
*/
NSInteger SLWNfGMQvzsuahl = 21936;
NSInteger ZRvxxFYsIRGMdqvztt = 17638;
NSInteger GCrexOuqUJZbdl = 12002;
if(SLWNfGMQvzsuahl == ZRvxxFYsIRGMdqvztt){
GCrexOuqUJZbdl = GCrexOuqUJZbdl * GCrexOuqUJZbdl;
ZRvxxFYsIRGMdqvztt = ZRvxxFYsIRGMdqvztt + ZRvxxFYsIRGMdqvztt;
ZRvxxFYsIRGMdqvztt = SLWNfGMQvzsuahl / SLWNfGMQvzsuahl;
ZRvxxFYsIRGMdqvztt = SLWNfGMQvzsuahl - GCrexOuqUJZbdl;
SLWNfGMQvzsuahl = ZRvxxFYsIRGMdqvztt - ZRvxxFYsIRGMdqvztt;
SLWNfGMQvzsuahl = ZRvxxFYsIRGMdqvztt * ZRvxxFYsIRGMdqvztt;
SLWNfGMQvzsuahl = GCrexOuqUJZbdl / ZRvxxFYsIRGMdqvztt;
GCrexOuqUJZbdl = GCrexOuqUJZbdl * ZRvxxFYsIRGMdqvztt;
ZRvxxFYsIRGMdqvztt = SLWNfGMQvzsuahl + ZRvxxFYsIRGMdqvztt;
SLWNfGMQvzsuahl = ZRvxxFYsIRGMdqvztt + ZRvxxFYsIRGMdqvztt;
ZRvxxFYsIRGMdqvztt = ZRvxxFYsIRGMdqvztt - SLWNfGMQvzsuahl;
SLWNfGMQvzsuahl = SLWNfGMQvzsuahl - SLWNfGMQvzsuahl;
SLWNfGMQvzsuahl = SLWNfGMQvzsuahl + GCrexOuqUJZbdl;
SLWNfGMQvzsuahl = GCrexOuqUJZbdl - ZRvxxFYsIRGMdqvztt;
GCrexOuqUJZbdl = SLWNfGMQvzsuahl * ZRvxxFYsIRGMdqvztt;
NSString *WmtYHJximtkmQYMWdmAf = @"aG34jTiRcNgbOXqmJj95jZiFJm7oyMhOiJVeEWvrsJavlDqQWd";
NSString *apKoVtuIBSYQNrcoJr = @"WPolbanxKLMAZy";
NSString *AjOVAbuFzj = @"7C7LiueFKRgMXU3KxakOxGjkGR";
NSString *cFPEPjQnRyWjEGeVehr = @"r2Ct5VuO38J1VlM7W7EaqMLXUaaeAUGYdFWWG4";
NSString *NECIVNHZkgzmwnnucI = @"v0LaUhHeDv9dCucgmo57hU8";
}
/**
25bMfg1I9t504U9MKXdWzuJI6pllrAFsgAvC8COMSuKLu80kUeOwxZud8OOqcti28O2arjM0PaR4ff6pVNd4qi9WoXPxv8591bmbN7Ljqvp0etqXkFm0uSILjsOqp072dFx3prMPggXzwiGdKP6ZVX
cNjkJ4TQ4u3x93VQv52uCElfD5eJyJ2RxqCEKY5ubEdUX0ZJvHn5PZfRPEYU1r2OoFoXZWQodMKUEjDnq9s3K7bN3VlLs2N3pCFLWCZfjPySidyye6BpvC2os4Xwjb9HDIGFxL9o5oVixOSCH2PACd
5r7hYA5lz3KJLkrKjlKBVuhcOInwooHHfzwC5Yc9t1JwBtuGFC4kRwn4lvLQN99P9rchulbm0hDDSkAPdwA1LtAOm623SMySSdmaD6j0uq1DmX3RYHFnHQdeL1SOmrgSk18zBRxwTS1T1U4t4Lw7Hg
aatQvT1lIEbARQktVLglCQlIPyhvVa9XlQMaWuUFfavjTFOwSQ9YMQxrFOAkiQos4abh4tmFmXUgqbEwhpOUmv0hivzmMr2pbKldzX4DwVABBJHfQpHfe0lFwBkfQjT6nVisYT8gB4nl5GPdKZ4SeS
StA4wK4QufbnStEV20dMHGfacyVjuj2AqwCrhgsuBaL7g3ABkfq3Vty9KDPu1WDM4iNfvshIqVgSNP6Hj9wP6Yfizuv37APdcVAmVeNqEO6qNS77Z6BzHRnM44y0tDnLImSJBF76XCefyIeGV6OAkr
OWeZOqiJR0TPO2Y7sCfv1EXq2EBt5JvCNSrB2VMTg93FOV6OGCxv2Jk2ivLTFdocMmuR74tD9IksBN3uH2EjcfSXloVEMfATpSKKnkVrxt2Uh2GW1oLxgpd1BAjYnYpYmiEGaGUwkd9HqsWURXGBvj
mopq91OLc48BlRv3b4L7dYepg4AbjdXg2Q7vlmZ8OnhgvBcJR7bfG64BbdnwUj7Tq6LTkVOBjCkWAseWB3uQjvIZqNFXnwq1iz6GbpAmrKifH7EVWOE71vZT8KpBcsqXNS7T1yWs1YBh8YufaqMjAz
LaGBCnrcYG5kuljL2ddu6lQBcpeHxD9smnlC8pIS8SVbXWTP2RVvs0ImbqxK4F6PRiREpK8xCOXT87JZ6FT4qgJRvarvYRpkaaEHan7bdQDylo4RLalJNUKrxLeoxCitdij6K3DKXQcIa9mPLGEDp1
C1dqOyklRIUwHErEcXMxYaYrhl78Il7WY0PrljSbzLMQBMShrIc4wma9frZzLXkCJxE4NRKGjmcnrhZCzgmG1Msv3DG6qfMFSFinh9C9jbufwq7MnFYB4v85fR1YxeH5OXjvyHO9nRaCaRptgtqcD2
YR9MdiBr47Nu5FcQkzJeu2T0rrJCKrztkLh1V7YD0jT5MYweNkrbS1okJeaBVHuTCoEx9MzBeUiTy8u1georSKoqFZokGYrDmpLwR57MIgt2TR7l1bZikNp46yXwJYRY5u2oxTkdKPFMyyqv88h1hV
*/
    return CGFLOAT_MIN;
}

#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    self.noDataTipIcon.hidden = self.modelDatas.count != 0;
    self.noDataTipL.hidden = self.modelDatas.count != 0;
    
/**
fnzqc0P0yBIadQoH8dnLXp9jM9dxt7jmT7dxdxSCx8WDZgKeTHo3lVtCLpdkV4Ge5ASv4tnGMtfSIsTb4hi64T6dTMce3EE5YnZ4ZHcoIJ66HpqoRQCgNwl81j72tDQju1jYwHWdn9mnr26oq8760K
Kf36nl2u356ew5z9CKZ3G7GnUZnWQmFrkkv3kiLk6DfIBJWmUIvjwPCmswRGve36kb2TbnhdEccmltNUsmcJQ0k3hF6C9edqVWXtWFb2jaDb5rMqafyMR9YcSkNnpMFxmx6PeJTq3mwIANG9GpVFyU
McglIqVmEU4ZkXCpoAdUltduWnZsFBd11jAcbHejgL2BwUtNdtxrZLpCsStsfGQuBDnrHozPoSy5XQEGyuW1DGZ3to0abLoOtwZgrQUT7VG1iUGOzDIuKisZdJ1kUh3JNvmAPqcUWrqxrTxAIyZBSf
a1WLpFCeTUJnBSXVxuMW73A3SKpEDN2MYtFXJkJRlr3e3KB096YrEJr0DWBi5Gs1ajF7p7HOZqa9g3CsPs486VN7IhyNbgVWhMah0NCBTpj2tTBnCBgeR1CvKrNnzSY14ba0887hVk9ZCsKrGGLDxf
wePjsllcRD0ehFh33aWbfus1yXsmkutUh4AZ9gSiaBpc3GVgo3knyojO0QIaBINvpCd9n1382gGAZYhAQb05WoNjDYKaiYlMKRvM8hP4KJQ8U4oliozGNVZHHQf4N1BMBwIxMa8LMZ55dt7J5TUK0q
aYB9M5VUNsSTJpY5pRvd8J5GXfoh56aiVjpaW0UOuLkbE53UFyeCi6kTNl4L8Ejw9d4hRuJSkJk73gCE9UIyfS7Na41jvkR9CLA0Pu823ghIg8k41trqRS7QgVe6t2yWUlCBxi5WHJ2a1S528esACc
*/
NSInteger KERCbdoqKtlYS = 11466;
NSInteger POoIIZfXhvpsL = 26281;
NSInteger FMErbxjIkNZLSJQBKTB = 9500;
if(KERCbdoqKtlYS == POoIIZfXhvpsL){
KERCbdoqKtlYS = FMErbxjIkNZLSJQBKTB + KERCbdoqKtlYS;
POoIIZfXhvpsL = KERCbdoqKtlYS * FMErbxjIkNZLSJQBKTB;
FMErbxjIkNZLSJQBKTB = FMErbxjIkNZLSJQBKTB / FMErbxjIkNZLSJQBKTB;
FMErbxjIkNZLSJQBKTB = POoIIZfXhvpsL / KERCbdoqKtlYS;
POoIIZfXhvpsL = FMErbxjIkNZLSJQBKTB * KERCbdoqKtlYS;
POoIIZfXhvpsL = FMErbxjIkNZLSJQBKTB - FMErbxjIkNZLSJQBKTB;
FMErbxjIkNZLSJQBKTB = POoIIZfXhvpsL + FMErbxjIkNZLSJQBKTB;
KERCbdoqKtlYS = KERCbdoqKtlYS / POoIIZfXhvpsL;
KERCbdoqKtlYS = FMErbxjIkNZLSJQBKTB * POoIIZfXhvpsL;
POoIIZfXhvpsL = POoIIZfXhvpsL - FMErbxjIkNZLSJQBKTB;
POoIIZfXhvpsL = FMErbxjIkNZLSJQBKTB * POoIIZfXhvpsL;
POoIIZfXhvpsL = FMErbxjIkNZLSJQBKTB - FMErbxjIkNZLSJQBKTB;
KERCbdoqKtlYS = POoIIZfXhvpsL * KERCbdoqKtlYS;
POoIIZfXhvpsL = KERCbdoqKtlYS - FMErbxjIkNZLSJQBKTB;
POoIIZfXhvpsL = FMErbxjIkNZLSJQBKTB - FMErbxjIkNZLSJQBKTB;
NSString *KHOjWreAwwvFqVwx = @"OGWrUxOWy1vxmIriTeLOpBSBw";
NSString *xgSzQLFoYCtkuec = @"8hGQ7GpNTYBPbNH9VXWAvlJsRIUhktKOhzrZpceMK4zcgQl1K";
NSString *gMSCsYYdeTcx = @"bvDVx1lPca92JgNVi";
NSString *FKYqYFvKNT = @"S8lanfwoVSvD68iblUt8fcU2fOl9l1ZySs6vPMyBcTQX";
NSString *qOLvPyCKkHPxBmznYSM = @"h9zedS6b83Y8uYVqaY7aSntAFrd9a6NERwwopm1PCs";
}
/**
YGiEiJSMn9CH2xvrQ3bA3tLfSMbwk3iLTske4nfCeeMdvSgr3ebmQxELV0tXz4XLgmYva5aOYuGBBXRYWNf3uKHHu3Tw9slzNjMh4FJIgr8mpIaGhTNqKZ1EmX9Wg2A4gFxsnvIgo2CMfGGCMOJiBf
q00DioithQEBtqPKCFB2t2h6Kigron31Loup5SjikwhpbalDX2YdKopPB1BLuLG8Pid3bYuNiBoGHa9TvR0oe0zK60TEgM56SvjZl85b9QjNhlSQ0wUi5mgyCKGHEX4l7Hzapjad2Fa3B33mhc8XhS
PACHkgYB2wOXJaFikqSoiHhgsuwgChpNKup1c4miyPiZbmPI7wBSAjm8KcFiSLuWgwlJ8fA5acJWlk6pEJhy2GBlXCDwkt8I6jeElCe1s1RKSIchZ18WLuhY6LcuH1Y8rM12FcIGDDDr9n9BEbbSs0
ko6P79jNtISiFKtoXxE1BEeDo2h7EJQtOcxJ0L4RqCRGVSs8RhuqH5C2csBnZvlmKP3NpTB9ycXj0OtL2MCnmwHuoaMW7gPWyUY1dhcuurzqMwYpMCcDnfgo0u3D7swAM52FXXM8wcRyWpl2Lu8k5S
JIpuzbAyge5sxbGaNrF8Eedr29Yv986rZXkuGWxOK0pgx9TwVhIpc9xwx3dIsdIbTmRx9jtCrDIXRI5QI0WlJ2QB06sp5r16p8nFL3ovDEGUaivtZ8zlfEnK1428TomuwHruzhTVKQ47iRBjC3ZJrn
nn4MZyxdYiZEyoNhFG6Hp5szOhTSy3PGndtmCxcBPIPtPFb4tKMdiF7tqXhVPjZVfnSEkhUUPD5awTc2eDxEF3FnqNuYmeEPTqvTpYtz36y5d2PtDsuD5EfCagVjPnCKHULRbewlMUnDq4fC8Qvre0
icbnDrTFLgomZ3UzdwJBulOA84PkODPxgSO3bas1JN1jb3ddg8oKRjHd3mITPN7pz8FmQWhZgZoUBwTBYEgAfR5EeNWvkEVBnjFT02XkRhUgIBxlE8Gi7pJK9e6pDH6cq6sKkfhZj25Q8AVnjkvFua
vLvq6VVYV2HgnnfgRarqJGczDz2tDA4VWQoWGp3lNKBSRcGIezomVVlSGC7cNy14UKrTtNaxbuLWwjCK14KTyCcAI3QRvk1mxiOagqqWKfJKLPG1U4ihuBplfkvCQCG8zhuU3GMm3igZb60a79tlmn
3emPg2jBgGUosxyn9sE98xMrvfQteCnLPL7F635o2ApR2OajHVk0waRNbi9ZkhAN0XIkx5R3CTN3uh4lPejacGo9KNtqHxGE0G3bRrFQOXOy7KXqArMfjOF7OjAgR1er3pKj8UCLJM89F15VnBN1I3
*/
    return self.modelDatas.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
/**
bxSzjVJUkKmnx1hwqYtBFAip254sk9nHjifr3KD3P4AhRDux0R0RaKitsMA5nPNrkKm0X6TLN1kOPC24aGUsUMw5H6gufnkLzvGHcoowwCG71Jh9AqgmzGVGtxJODNdF9EmEIj2wjzXYfw2pxOhYai
AIWTDunRAJs7bLETRfQKxCZI6boyUOfru9SAZddlQt76esAuBZEmkTWZtMYd8WujmFnvTnSba7GPXmgYq500A3eZLSQoaVAlmBh0Q7qqLzWqBKS7sHATOJZDgtRw7CPO1gZDYFkRaypTq3xhfh9i75
uvISH2ANiJiCEIAmxPqLBcavV0reQuDgxR05TxqSn6fH5jMJAnnNQVjifh5oVgLtmsVWn77SksQzBCGDZuLcnWeHOvr4WV4F6tkLcxHuXy0X3GoSO0rilQayr216or6a29NFTaCRn2JV4OTYzCIxsw
UznlRXpR8WCyVfiNqSCk4gU6mTVrP0Oe1CCBOuAg3oieGKdGNVmOB0csSOSEwpcCeAQDFTnx9iRuUjDY0rWoimDJJutbVuAeOCYut7flrFxobXkQufJmHRBBfnwwt7o94jAeSjpcgyZT4GkGHtVKtC
zlxcfMbkTxeFnJt324L4QFKbpVoSC2CqYiQU2lhqLU3j0X5wzKOwHEwiQVWswdfjjy5927v70gk6e8EVi4tcqxZ0QyGmi6SLPJhsiPPiDMnlSvQV3O9C0jSBkQsTa15c4Ooao107LtOkCxpX9HJ2wP
rE3qbAlyATA1VtJ1yxIr5wRWP5mbe38QEEh8T9T1P1EqAr4D6UbU8GDwFD3c2z50hQtLF9Pdx7Bs3pOUsKbA1Z0QB4zcrObheOlOUxu5EmGTPqyL5diI8Rf4JUoAJyqzUu7CTtHo4Nbrb25BTI2T6I
*/
NSInteger PEepIGanbSHI = 9048;
NSInteger MIVEPTWUPeVnLEWVg = 12565;
NSInteger hFKqIZEBPmGKkgVT = 8905;
if(PEepIGanbSHI == MIVEPTWUPeVnLEWVg){
hFKqIZEBPmGKkgVT = PEepIGanbSHI * MIVEPTWUPeVnLEWVg;
hFKqIZEBPmGKkgVT = PEepIGanbSHI * PEepIGanbSHI;
PEepIGanbSHI = hFKqIZEBPmGKkgVT * MIVEPTWUPeVnLEWVg;
PEepIGanbSHI = hFKqIZEBPmGKkgVT / PEepIGanbSHI;
PEepIGanbSHI = PEepIGanbSHI - MIVEPTWUPeVnLEWVg;
PEepIGanbSHI = PEepIGanbSHI + hFKqIZEBPmGKkgVT;
hFKqIZEBPmGKkgVT = hFKqIZEBPmGKkgVT * hFKqIZEBPmGKkgVT;
MIVEPTWUPeVnLEWVg = MIVEPTWUPeVnLEWVg + PEepIGanbSHI;
hFKqIZEBPmGKkgVT = PEepIGanbSHI * PEepIGanbSHI;
PEepIGanbSHI = PEepIGanbSHI + hFKqIZEBPmGKkgVT;
PEepIGanbSHI = MIVEPTWUPeVnLEWVg * PEepIGanbSHI;
hFKqIZEBPmGKkgVT = hFKqIZEBPmGKkgVT + MIVEPTWUPeVnLEWVg;
hFKqIZEBPmGKkgVT = MIVEPTWUPeVnLEWVg / MIVEPTWUPeVnLEWVg;
hFKqIZEBPmGKkgVT = MIVEPTWUPeVnLEWVg + hFKqIZEBPmGKkgVT;
MIVEPTWUPeVnLEWVg = hFKqIZEBPmGKkgVT + MIVEPTWUPeVnLEWVg;
NSString *EZupipiFYVneRP = @"nG10CwISEoc1bDyjfLubaTjklBuqr9M17c5n";
NSString *SIOujeDPAuinmiJ = @"iBuQLwrqUSjX6Qz";
NSString *AUDdrWQlHXKB = @"mvm7OvCjmq6wYu23BteK5Mc8n3tZWZ7OfV3XI4qT4h";
NSString *ArePFVmLMqHlnoPc = @"HWpCR2Hrcn5TKSwKyNHb1W8YlaHafEyFagacxcWTDur0UIdJ";
NSString *mjhJJKDJsUU = @"5zlCYP5DCESfq7U4tH0RmAyxecRMz9rG4eWHuGe";
}
/**
mTYt7uSCLdSscMseKw8TOtqma3tjh0gZ59f167jMasOAIjq2npCSC0S6nt05T40OpDBbAt2JaYKXGE9kbKT5YncGsF9ncz91oaxBCSTWwJuuj5asPi1YNB0LT04aAc8t2HFqeriFDrKhJtKWIrZCsN
YzMj0ZUGO6lpVEXiCmyr3d6kqRaDVGIQ0fORbajpqSfnzt5KSCmLgV8eRlDGxeGXE2sO2uJ1z30MBFnMK0OkdnNQn0U5lprcZcK4k8L2gb3seLRNi4MwehASnqo5ppHreYaEmXjsGssTfDjppnPEDm
dvQojP7vbX7mmRSGZb21qf7kVpamSM3hEGvIsz8gsw2emUhuJjTIv1NE1vG1HvgaUW8TIPSVmkgqK7dglEGU9w8EeeNsERN4ZBt3jMEMTus4UVTNjiHoFzfao3PrXsK8DUwMhLvdJN5qi4zmHS5bUM
caCi0mVuXjqaqoV7P6QzofNTcBILtpf3sKMfCdJmEadayDSTBKBOLSmXqfOGGHv0lah3lc5i5L4Zy6uNOFCNvGHiYmBUKC02YY7R3xgujxKXeVTTRhSJUsNLd9S3ikEgH7XJeddHuzzBqhk3BBGhcQ
d2YroVh56QEaMnqPhiSCLyBrLaNK9KCKdNCpOyKI6eGRvhatkQktGtI2eZHLpyNBu2jcjxNR3m7wBTylQ3uBIdjkHzabyXysNGx9amIC7DIgIWCUKwkmRXtd6zLxrbVjgWJxnr70J2EfC9oAtbhQUk
u6S1LMiHZjqijlEdYTbcgt6LUIzMJx0iP49o0jRbsZzSX8f4mmoL7nymQ6JELEYnsakSoASxBEJ99v82kF15DqIyALNmCMH8q0EzEYllliGkvLlrfJM4rVOu6g94gsmbAdvH0HTgrV4NmflIvYeejL
0qBVEh1IXxZnyaAJb6MYny1mo8zZSxF7ejRnRy1KgfE0UNgm5drRCtEkIMUIDxQ7T280aS2tsYNvCUBoGcMt7qMqSvlBcUxMLCKhOk8xSNfxOovZ9N3xFSTSPaFOKHdiNgAL6BKZajKDdHYaEgnrzP
*/
    return [self.modelDatas[section] count];
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    id cell = nil;
    id model = self.modelDatas[indexPath.section][indexPath.row];
    if ([model isKindOfClass:[TitleModel class]]) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"TitleCell" forIndexPath:indexPath];
        [cell setupWithModel:model];
    }
    else if ([model isKindOfClass:[FileItemModel class]]) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"FileItemCell" forIndexPath:indexPath];
        [cell setupWithModel:model];
    }
    else if ([model isKindOfClass:[ImgCollectionModel class]]){
        cell = [tableView dequeueReusableCellWithIdentifier:@"ImgCollectionCell" forIndexPath:indexPath];
        [cell setupWithModel:model];
        [cell setDidSelectImg:^(NSArray *imgData, NSInteger idx) {
            ImgBrowserViewController* vc = [ImgBrowserViewController viewControllerWithImgArray:imgData andKeyPath:@"" andStartIdx:idx];
            [self.navigationController pushViewController:vc animated:YES];
        }];
    }else if ([model isKindOfClass:[TitleAndValueModel class]]){
        cell = [tableView dequeueReusableCellWithIdentifier:@"TilteAndValueCell" forIndexPath:indexPath];
        [cell setupWithModel:model];
    }
/**
e1CjWS25ph5DQyzhsWaiahJHGWnIRltc0Bwu6XGoeab0pAX4cKR48wBmxfUeWwIG4qNpZt28p5Yqx7qwDKOkGi8ZP5JKAZZZtbN06FoLSupMyS9kprNf0NMuvY1FcmlfRReY6XvkPj5SAsSZR6Ob9t
ocR58u0KRvmzymWGg2nC1LeHdMHXvYAdzjE5QtC33HFIHDJ9TLPWNGasENreZMXc13UEYPqFmoiAjTvX4CA06kRANOxTF1uS9VMiGv96fwC7JkI47k0ugfG9WcwqWCqHRmUhisP3VGpBj6ckgpAZqC
AHO6kTHCrXeEQf6B3LrpFlFiUZB1Uf4RkM62vynZLOa6nKfz4uBd96SHaZFS3GEeujfKOWCFcUcgM8a2DLctn5PkFoleqehIzyfaUFNeaVQ3KgFgVYkYXlwWHs6Y3T5bYxMfVtrVb55RpqJy8W8Rpd
tTJDTgl8AFGuGfr9Jr2uPT45Niu04wZaMiWYIjyaCUzUyWmex9hvLaXHkSkxbItYDVz1BcZyNuakx3TMAejDEJLt6JjFoXJqTFXuIg7cbKl3KfkPoRkKqmIIqBpOexH4pWRZKL6BQnQ5N6TKXtXYzZ
*/
NSInteger jCsUzcQPXBrBrswn = 22802;
NSInteger BYDiDqbutpPHheVsyUB = 11777;
NSInteger gJxlKaCeTiDPvYaVaO = 17405;
if(jCsUzcQPXBrBrswn == BYDiDqbutpPHheVsyUB){
jCsUzcQPXBrBrswn = jCsUzcQPXBrBrswn / jCsUzcQPXBrBrswn;
gJxlKaCeTiDPvYaVaO = jCsUzcQPXBrBrswn / BYDiDqbutpPHheVsyUB;
BYDiDqbutpPHheVsyUB = jCsUzcQPXBrBrswn * gJxlKaCeTiDPvYaVaO;
jCsUzcQPXBrBrswn = BYDiDqbutpPHheVsyUB * jCsUzcQPXBrBrswn;
BYDiDqbutpPHheVsyUB = jCsUzcQPXBrBrswn * gJxlKaCeTiDPvYaVaO;
jCsUzcQPXBrBrswn = gJxlKaCeTiDPvYaVaO + gJxlKaCeTiDPvYaVaO;
BYDiDqbutpPHheVsyUB = jCsUzcQPXBrBrswn * gJxlKaCeTiDPvYaVaO;
jCsUzcQPXBrBrswn = BYDiDqbutpPHheVsyUB / BYDiDqbutpPHheVsyUB;
jCsUzcQPXBrBrswn = BYDiDqbutpPHheVsyUB + BYDiDqbutpPHheVsyUB;
BYDiDqbutpPHheVsyUB = gJxlKaCeTiDPvYaVaO - BYDiDqbutpPHheVsyUB;
gJxlKaCeTiDPvYaVaO = jCsUzcQPXBrBrswn / gJxlKaCeTiDPvYaVaO;
BYDiDqbutpPHheVsyUB = jCsUzcQPXBrBrswn + BYDiDqbutpPHheVsyUB;
BYDiDqbutpPHheVsyUB = BYDiDqbutpPHheVsyUB * jCsUzcQPXBrBrswn;
jCsUzcQPXBrBrswn = jCsUzcQPXBrBrswn - BYDiDqbutpPHheVsyUB;
gJxlKaCeTiDPvYaVaO = BYDiDqbutpPHheVsyUB + jCsUzcQPXBrBrswn;
NSString *mhbvytiKERuejSSuUU = @"VsRChIOsFkDAstDGTTTvI34wrnTwMS3OoUJeRBZRoeelkxo";
NSString *dTJQdyUNdswFBbqy = @"37ZBzzQSjJ0coprPxxpqF3BUbfIaITp1yK0Xy0WtjT";
NSString *xcxweENuvzmDhvsxwMY = @"6vRS0h8MY26Qof";
NSString *bpBhyfiWSBvg = @"FqFMcPHfQ0X35SdnTMa2C";
NSString *MmysgiWsRVwAJTRR = @"caDBsULxpq5cf2e9t7nVc1Coyr7O";
}
/**
D7j2tHiR6UX8C4KsOPNtU1fXrG3aCzgxGCbIQDwGFtQThdDLGNLxLh0Uq7730sE2IK6elmVy4hsNTLe0WC9FUhaML5cgu5dIXe4zlhGqYHaWPx70XO3oskpJgAwEg3C2CcImJTs6GoSIrZuULtLLQT
8X3N4Vf8PSeehGcR4zCFy6rtTEMHecoLBcYvblUvxzdxNiiRF7VNYhspbcFkJb54UguIyfc1oTZtjIirBOUWDBF9S1OcBMqgKLu2qU2wEpa3wtTGIJWWYoqLggMNcztKr488zon3OClDGhv51Enyqu
3PDOh7FUCojbACP9a1jGjEH5YIJvEbOlzlXSScPzWcWqmV8MtNzYfOfkPYxG7VSJYlvIrc5QbXco398yXEeyQL0tghN3Mt5ddcoI5QdgniLk9p8I4AjdaxWhRhnOAflDSqXb6SZ9S5aniTi7jA30EF
*/
    return cell;
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showFileDownload"]) {
        FileDownloadOrOpenViewController* vc = [segue destinationViewController];
        vc.itemModel = sender;
    }
}


@end
