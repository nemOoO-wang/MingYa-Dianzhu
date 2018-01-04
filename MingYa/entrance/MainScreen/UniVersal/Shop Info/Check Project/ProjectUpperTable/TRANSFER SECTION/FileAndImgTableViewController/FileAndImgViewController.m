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
                    if ([@"jpg jpeg png gif" containsString:suffixStr]) {
                        // 图片
                        [tmpimgMArr addObject:fileStr];
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
                    if ([@"jpg jpeg png gif" containsString:suffixStr]) {
                        // 图片
                        [tmpimgMArr addObject:fileStr];
                    }else{
                        // 文件
                        NSString *wFileName = [NSString stringWithFormat:@"%@.%@",fileDic[@"contentName"],suffixStr];
                        FileItemModel *fModel = [FileItemModel modelWithFileName:wFileName andFileUrl:fileStr andFileSize:0];
                        [tmpFileArr addObject:fModel];
                    }
                }
                
                // tmpFileArr
                ImgCollectionModel *imgModel = [ImgCollectionModel modelWithTitleStr:@"设计图片" andImgDatas:tmpimgMArr];
                self.modelDatas = @[tmpFileArr, @[imgModel]];
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
            [fm setDateFormat:@"yyyy.YY.dd HH:mm"];
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
        return allHeight;
    }else{
        return UITableViewAutomaticDimension;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == [self.modelDatas count] - 1) {
        return CGFLOAT_MIN;
    }
    return FooterHeight;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}

#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    self.noDataTipIcon.hidden = self.modelDatas.count != 0;
    self.noDataTipL.hidden = self.modelDatas.count != 0;
    
    return self.modelDatas.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
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
        [cell setBaseVC:self];
    }else if ([model isKindOfClass:[TitleAndValueModel class]]){
        cell = [tableView dequeueReusableCellWithIdentifier:@"TilteAndValueCell" forIndexPath:indexPath];
        [cell setupWithModel:model];
    }
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
