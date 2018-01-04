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
#import <SVProgressHUD.h>
#import "MYUser.h"
#import "ConstructionDatePickerVC.h"
#import "SGZImgSet.h"


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
//        [[BeeNet sharedInstance] requestWithType:Request_GET andUrl:@"getList" andParam:paramDic andHeader:nil andSuccess:^(id data) {
//            // success
//            NSMutableArray *tmpMutArr = [[NSMutableArray alloc] init];
//            NSDictionary *tmpDic = data[@"data"];
//            // title model
//            NSDateFormatter *df = [[NSDateFormatter alloc] init];
//            [df setDateFormat:@"yyyy-MM-dd"];
//#warning 空数据？？？
//            if (![tmpDic[@"finishTime"] isKindOfClass:[NSNull class]]) {
//                NSDate *date = [NSDate dateWithTimeIntervalSince1970:[tmpDic[@"finishTime"] integerValue]/1000.f];
//                TitleAndValueModel *tModel = [TitleAndValueModel modelWithTitle:@"预计完成时间" andValue:[df stringFromDate:date]];
//                [tmpMutArr addObject:@[tModel]];
//            }
//            // imgs model
//            NSMutableArray *imgMutTmpArr = [[NSMutableArray alloc] init];
//            NSArray *tmpArr = tmpDic[@"dataList"];
//            NSLog(@"%@",tmpArr);
//            for (NSDictionary *imgDic in tmpArr) {
//                NSString *statusStr = [imgDic[@"constructionType"] integerValue]==1? @"施工中":@"施工完毕";
//                NSString *personName = imgDic[@"constructionNickName"];
//                NSDate *upDateate = [NSDate dateWithTimeIntervalSince1970:[tmpDic[@"constructionDate"]integerValue]/1000.f];
//                NSString *labelText = (NSString *)[NSString stringWithFormat:@"%@\n%@\t%@",statusStr,personName,[df stringFromDate:upDateate]];
//                // 切割 img url
//                NSString *imgsPath = imgDic[@"constructionUrl"];
//                NSArray *strArr = [imgsPath componentsSeparatedByString:@","];
//                ImgCollectionModel *imgModel = [ImgCollectionModel modelWithTitleStr:labelText andImgDatas:strArr];
//                [imgMutTmpArr addObject:imgModel];
//            }
//            if (imgMutTmpArr) {
//                [tmpMutArr addObject:imgMutTmpArr];
//            }
//            self.checkConstructModelData = [tmpMutArr copy];
//            [self.tableView reloadData];
//        } andFailed:^(NSString *str) {
//            // fail
//            NSLog(@"%@",str);
//        }];
    }else if ([self.sectionName isEqualToString:@"施工完毕"]){
        // 施工完毕
        self.showAsSingleCollection = YES;
        NSDictionary *paramDic = @{@"token":token, @"method":@"getFininsh", @"page":@0, @"searchValue":self.projectId};
        [[BeeNet sharedInstance] requestWithType:Request_GET andUrl:@"getList" andParam:paramDic andHeader:nil andSuccess:^(id data) {
            // success
            NSMutableArray *tmpMutArr = [[NSMutableArray alloc] init];
            NSDictionary *tmpDic = data[@"data"];
            // title model
            
            NSDateFormatter *df = [[NSDateFormatter alloc] init];
            [df setDateFormat:@"yyyy-MM-dd"];
            NSDate *date = [NSDate dateWithTimeIntervalSince1970:[tmpDic[@"constructionDate"]integerValue]/1000.f];
            NSString *upStr = [NSString stringWithFormat:@"上传员工：%@ %@",tmpDic[@"stationName"],tmpDic[@"constructionNickName"]];
            NSString *lowStr = [NSString stringWithFormat:@"上传时间：%@",[df stringFromDate:date]];
            TitleAndValueModel *tModel = [TitleAndValueModel modelWithTitle:upStr andValue:lowStr];
            [tmpMutArr addObject:@[tModel]];
            // imgs model
            NSMutableArray *imgMutTmpArr = [[NSMutableArray alloc] init];
            NSArray *tmpArr = tmpDic[@"dataList"];
            NSLog(@"%@",tmpArr);
            for (NSDictionary *imgDic in tmpArr) {
//                NSString *statusStr = [imgDic[@"constructionType"] integerValue]==1? @"施工中":@"施工完毕";
                NSString *statusStr = @"施工完毕";
                NSString *personName = imgDic[@"constructionNickName"];
                NSDate *upDateate = [NSDate dateWithTimeIntervalSince1970:[tmpDic[@"constructionDate"]integerValue]/1000.f];
                NSString *labelText = (NSString *)[NSString stringWithFormat:@"%@\n%@\t%@",statusStr,personName,[df stringFromDate:upDateate]];
                // 切割 img url
                NSString *imgsPath = imgDic[@"constructionUrl"];
                NSArray *strArr = [imgsPath componentsSeparatedByString:@","];
                ImgCollectionModel *imgModel = [ImgCollectionModel modelWithTitleStr:labelText andImgDatas:strArr];
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
    }else if ([self.sectionName isEqualToString: @"测量完毕"]){
        // 测量完毕
        self.showAsSingleCollection = YES;
        NSDictionary *paramDic = @{@"token":token, @"method":@"getInitContent", @"page":@0, @"searchValue":self.detailId};
        [[BeeNet sharedInstance]requestWithType:Request_GET andUrl:@"getList" andParam:paramDic andHeader:nil andSuccess:^(id data) {
            // success
            NSMutableArray *tmpMArr = [[NSMutableArray alloc] init];
            NSMutableArray *tmpimgMArr = [[NSMutableArray alloc] init];
            NSArray *tmpArr = data[@"data"];
            for (NSDictionary *imgDic in tmpArr) {
                NSString *imgsStr = imgDic[@"contentUrl"];
                NSArray *imgUrlArr = [imgsStr componentsSeparatedByString:@","];
                ImgCollectionModel *imgModel = [ImgCollectionModel modelWithTitleStr:@"测量完毕" andImgDatas:imgUrlArr];
                [tmpimgMArr addObject:imgModel];
            }
            
            if (tmpimgMArr.count != 0 ) {
                // 有数据
                [tmpMArr addObject:tmpimgMArr];
                self.checkConstructModelData = [tmpMArr copy];
                [self.tableView reloadData];
            }else{
                // 没数据
                [self scroll2VCIndex:3 withAnimated:NO];
            }
        } andFailed:^(NSString *str) {
            // fail
            NSLog(@"%@",str);
        }];
        
    }else if ([self.sectionName isEqualToString:@"所有材料已打包"]){
        // 所有材料已打包
        self.showAsSingleCollection = YES;
        NSDictionary *paramDic = @{@"token":token, @"method":@"getInitContent", @"page":@0, @"searchValue":self.detailId};
        [[BeeNet sharedInstance]requestWithType:Request_GET andUrl:@"getList" andParam:paramDic andHeader:nil andSuccess:^(id data) {
            // success
            NSMutableArray *tmpMArr = [[NSMutableArray alloc] init];
            NSMutableArray *tmpimgMArr = [[NSMutableArray alloc] init];
            NSArray *tmpArr = data[@"data"];
            for (NSDictionary *imgDic in tmpArr) {
                NSString *imgsStr = imgDic[@"contentUrl"];
                NSArray *imgUrlArr = [imgsStr componentsSeparatedByString:@","];
                ImgCollectionModel *imgModel = [ImgCollectionModel modelWithTitleStr:@"测量完毕" andImgDatas:imgUrlArr];
                [tmpimgMArr addObject:imgModel];
            }
            
            if (tmpimgMArr.count != 0 ) {
                // 有数据
                [tmpMArr addObject:tmpimgMArr];
                self.checkConstructModelData = [tmpMArr copy];
                [self.tableView reloadData];
            }else{
                // 没数据
                [self scroll2VCIndex:3 withAnimated:NO];
            }
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
        return allHeight;
    }else{
        return UITableViewAutomaticDimension;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == [self.checkConstructModelData count] - 1) {
        return CGFLOAT_MIN;
    }
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}

#pragma mark - <UITableViewDataSource>
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.checkConstructModelData.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.checkConstructModelData[section] count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    id cell = nil;
    id model = self.checkConstructModelData[indexPath.section][indexPath.row];
    if ([model isKindOfClass:[ImgCollectionModel class]]){
        cell = [tableView dequeueReusableCellWithIdentifier:@"ImgCollectionCell" forIndexPath:indexPath];
        [cell setupWithModel:model];
    }else if ([model isKindOfClass:[TitleAndValueModel class]]){
        if ([self.sectionName isEqualToString:@"进场施工"]) {
            cell = [tableView dequeueReusableCellWithIdentifier:@"TilteAndValueCell" forIndexPath:indexPath];
        }else if ([self.sectionName isEqualToString:@"完成施工"]){
            cell = [tableView dequeueReusableCellWithIdentifier:@"MultiColumnCell" forIndexPath:indexPath];
        }
        [cell setupWithModel:model];
    }
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
    
    if ([segue.identifier isEqualToString:@"stillWorking"]) {
        NormalUpLoadImgViewController *controller = segue.destinationViewController;
        controller.isCommitCompleteViewController = NO;
        controller.projectId = self.projectId;
        controller.sc = self.sc;
        
    }else if ([segue.identifier isEqualToString:@"completeWorking"]){
        NormalUpLoadImgViewController *controller = segue.destinationViewController;
        controller.isCommitCompleteViewController = YES;
        controller.projectId = self.projectId;
        controller.sc = self.sc;
        controller.delegate = self;
        
    }else if ([segue.identifier isEqualToString:@"pickDate"]){
        // 选择完成日期
        ConstructionDatePickerVC *controller = segue.destinationViewController;
        controller.projectId = self.projectId;
        controller.delegate = self;
    }
}

@end
