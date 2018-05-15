//
//  CheckProjectTableVC.m
//  MingYa
//
//  Created by 镓洲 王 on 10/16/17.
//  Copyright © 2017 镓洲 王. All rights reserved.
//

#import "CheckProjectTableVC.h"
/// kits
#import "ProjectFlow.h"
#import "MYUser.h"
/// views
#import "SubTableViewWithinCellView.h"
#import "ProjectUpperTableCell.h"
/// viewcontrollers
#import "ProjectConfirmViewController.h"
#import "NormalUpLoadImgViewController.h"
#import "ConstructionViewController.h"
#import "FileAndImgViewController.h"


/// define
#define NMCellHeight            60
#define NMOffsetInterval        0.3
#define SubCellHeight           41
#define SubCellSpecialHeight    22
#define NMUsedWidth4Status      221
#define NMSubTable2CellBottom   15


/// interface
@interface CheckProjectTableVC ()<ProjectSubTableCellViewDelegate>
@property (nonatomic,strong) NSArray *specialHeightCountArr;
@property (nonatomic,strong) NSMutableArray *indexPathArr;
@property (nonatomic,strong) NSArray *dataArr;

// 指向最新完成的流程的 index
@property (nonatomic,assign) NSInteger sectionIndex;
@property (nonatomic,assign) NSInteger subTableRowIndex;
@property (nonatomic,assign) NSInteger speedCode;
// 有一部分节点不需要显示预计时间（两行）
@property (nonatomic,assign) BOOL canShowActiveSubCell;
// 网络获取的每个子节点信息
@property (nonatomic,strong) NSArray *workFlowInfoArr;

// 子表的 cell 回传的信息（prepare4Segue 中使用）
@property (nonatomic,strong) NSDictionary *segueAttributesDict;


// 记录用户权限、完成情况的 array
@property (nonatomic,strong) NSArray *autorityArr;
@property (nonatomic,strong) NSArray *finishArr;

@property (nonatomic,strong) NSMutableArray *openTokenArr;

@end


/// implementation
@implementation CheckProjectTableVC

# pragma mark - set projectID
-(void)setProjectID:(NSString *)projectID{
    [super setProjectID:projectID];
    
    /// request
    // token
    NSString *token = [[MYUser defaultUser] token];
    NSString *uId = [[MYUser defaultUser] userId];
    // param dic
    NSDictionary *paramDict = @{@"token":token, @"method":@"getAllSpeedDetailById", @"page":@0, @"keyWord":@"",@"searchValue":projectID};
    [[BeeNet sharedInstance] requestWithType:Request_GET andUrl:@"getList" andParam:paramDict andHeader:nil andSuccess:^(id data) {
        // success
        NSArray *requestArr = data[@"data"];
        self.workFlowInfoArr = requestArr;
        // 遍历返回最后一个完成项目 dict
        NSDictionary *flowDict;
        BOOL wholeProjectFinish = NO;
        for (NSDictionary *tmpFlowDict in requestArr) {
            // 遍历 request
            if ([tmpFlowDict[@"isfinish"] intValue] == 0) {
                // 返回第一个进行中的任务
                flowDict = tmpFlowDict;
//                if (tmpFlowDict == [requestArr firstObject]) {
//                    // 默认最少第一个
//                    flowDict = tmpFlowDict;
//                }else{
//                    // 返回最后一个完成的流程 dict
//                    NSInteger tmpIndex = [requestArr indexOfObject:tmpFlowDict];
//                    flowDict = requestArr[tmpIndex-1];
//                }
                NSString *subCellName = tmpFlowDict[@"speedName"];
                NSString *shouldShowTimeCell = @"测量中 设计中 待报价 待店主确认 待生产招牌 待备料 待发货 货到待施工";
                if ([shouldShowTimeCell containsString:subCellName]) {
                    self.canShowActiveSubCell = YES;
                }
                // 找到第一个未完成项目，结束遍历
                break;
            }
            if ([requestArr indexOfObject:tmpFlowDict]+1 == [requestArr count]) {
                wholeProjectFinish = YES;
            }
        }
        if (wholeProjectFinish == NO) {
            // calculate index
            int sectionIndex = [flowDict[@"speedCode"] intValue];
            self.speedCode = sectionIndex;
            self.sectionIndex = sectionIndex / 100;
            NSInteger largeThan0RowIndex = (sectionIndex % 100)-1;
            if (largeThan0RowIndex > 0) {
                self.subTableRowIndex = largeThan0RowIndex;
            }else{
                self.subTableRowIndex = 0;
            }
        }else{
            // 项目全部结束
            self.speedCode = 804;
            self.sectionIndex = 8;
            self.subTableRowIndex = 3;
        }
    } andFailed:^(NSString *str) {
        NSLog(@"%@",str);
    }];
    
#warning deleted request
//    // set authority arr
//    NSDictionary *paramDict2 = @{@"token":token, @"method":@"getStationRole", @"page":@0, @"searchValue":uId};
//    [[BeeNet sharedInstance] requestWithType:Request_GET andUrl:@"getList" andParam:paramDict2 andHeader:nil andSuccess:^(id data) {
//        // success
//        NSData *jsonData = [data[@"data"] dataUsingEncoding:NSUTF8StringEncoding];
//        if (jsonData) {
//            // 存在权限数据
//            self.autorityArr = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:nil];
//        }
//
//
//    } andFailed:^(NSString *str) {
//        NSLog(@"%@",str);
//    }];
//
    
    // set finish arr
    NSDictionary *paramDict3 = @{@"token":token, @"method":@"getAllSpeedDetailById", @"page":@0, @"searchValue":projectID};
    [[BeeNet sharedInstance] requestWithType:Request_GET andUrl:@"getList" andParam:paramDict3 andHeader:nil andSuccess:^(id data) {
        // success
        self.finishArr = data[@"data"];
    } andFailed:^(NSString *str) {
        NSLog(@"%@",str);
    }];
    
}

# pragma mark - specialHeightCountArr
-(NSArray *)specialHeightCountArr{
    if(!_specialHeightCountArr){
        UIFont *font = [UIFont systemFontOfSize:13];
        CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
        NSMutableArray *tmpArr = [[NSMutableArray alloc] init];
        // enumerate flow
        for (ProjectFlow *flow in self.dataArr) {
            NSInteger index = [self.dataArr indexOfObject:flow];
            tmpArr[index] = [NSNumber numberWithInteger:0];
            if (self.canShowActiveSubCell) {
                // can show active cell++
                if (index == self.sectionIndex) {
                    // n++
                    NSNumber *number = tmpArr[index];
                    NSInteger n = [number integerValue];
                    n += 1;
                    number = [NSNumber numberWithInteger:n];
                    tmpArr[index] = number;
                    /// n++
                }
            }
            // enumerate subtitle
            NSArray *subTitleArr = flow.subTitle;
            for (NSDictionary *subTitle in subTitleArr) {
                CGSize strSize = [subTitle[@"name"] sizeWithAttributes:@{NSFontAttributeName:font}];
                CGFloat unusedWidth = screenWidth - NMUsedWidth4Status;
                if(strSize.width > unusedWidth){
                    // special height found!
                    // n++
                    NSNumber *number = tmpArr[index];
                    NSInteger n = [number integerValue];
                    n += 1;
                    number = [NSNumber numberWithInteger:n];
                    tmpArr[index] = number;
                    /// n++
                }
            }
        }
        // vonver 2 immutable
        _specialHeightCountArr = [tmpArr copy];
    }
    return _specialHeightCountArr;
}

# pragma mark - dataArr
-(NSArray *)dataArr{
    if(!_dataArr){
        NSString *filePath = [[NSBundle mainBundle]pathForResource:@"ProjectFlow" ofType:@"plist"];
        NSArray *tmpArr = [NSArray arrayWithContentsOfFile:filePath];
        NSMutableArray *tmpMutArr = [[NSMutableArray alloc]init];
        [tmpArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSDictionary *dict = (NSDictionary *)obj;
            ProjectFlow *newData = [ProjectFlow projectFlowWithDict:dict];
            [tmpMutArr addObject:newData];
        }];
        _dataArr = [tmpMutArr copy];
    }
    return _dataArr;
}

# pragma mark - indexPathArr
-(NSMutableArray *)indexPathArr{
    if (!_indexPathArr) {
        _indexPathArr = [[NSMutableArray alloc]init];
    }
    return _indexPathArr;
}


#pragma mark - <UITableViewDateSource>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ProjectUpperTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"subtable" forIndexPath:indexPath];
    // set sub table when reload row
    
    // subtable selected status
    cell.subTableView.enable = [self.indexPathArr containsObject:indexPath];
    
    // set cell project flow
    cell.flow = (ProjectFlow *)self.dataArr[indexPath.row];
    
    // set cell subcell info
    cell.subTableView.subCellInfoArr = self.workFlowInfoArr;
    
    // set speedCode
    cell.subTableView.speedCode = self.speedCode;
    
    // set sub table status
    if (indexPath.row < self.sectionIndex) {
        // 已完成
        cell.status = MYFlowStatusDone;
    }else if (indexPath.row == self.sectionIndex){
        // 进行中
        cell.status = MYFlowStatusActive;
        cell.activeRowIndex = self.subTableRowIndex;
    }else{
        // todo
        cell.status = MYFlowStatusToDo;
    }
    
    // set direction label
    cell.subTableStatus = [self.openTokenArr containsObject:[NSNumber numberWithInteger:indexPath.row]]? ProjectSubTableStatusOpen: ProjectSubTableStatusClosed;
    
    // set sub table authority
    /// warning 这里需要加一，因为 pc 端多了第0组{申请信息}操作
    //
    cell.authorityArr = self.autorityArr[indexPath.row+1][@"role"];
    cell.subTableView.isHandle = [self.autorityArr[indexPath.row+1][@"ishandle"] integerValue];
    
    // set sub table finish array
    cell.finishArr = self.finishArr;
    
    // set subtable delegate
    cell.subTableView.delegate = self;
    
    // set subtable section number
    cell.subTableView.sectionNumber = indexPath.row;
    
    // hide direction img
    NSInteger row = indexPath.row;
    if (row == 4 || row == 5 || row == 8) {
        cell.hideArrow = YES;
    }else{
        cell.hideArrow = NO;
    }
    
    [cell layoutSubviews];
    return cell;
}


# pragma mark - <ProjectSubTableCellViewDelegate>
-(void)shouldPerformSegue:(NSString *)segueIden withAttributesDict:(NSDictionary *)attributesDict{
    self.segueAttributesDict = attributesDict;
    [self performSegueWithIdentifier:segueIden sender:@{@"speedCode":[NSNumber numberWithInteger:2]}];
}
//-(void)shouldPerformSegue:(NSString *)segueIden withViewType:(NSString *)typeStr{
//    NSLog(@"%@",segueIden);
//    NSLog(@"%@", typeStr);
//    [self performSegueWithIdentifier:segueIden sender:self];
//}



#pragma mark - select cell
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row > self.speedCode/100) {
        return;
    }
    
    switch (indexPath.row) {
        case 0:
            // 丈量中
            [self performSegueWithIdentifier:@"fileAndImg" sender:@{@"speedCode":[NSNumber numberWithInteger:1],@"sectionName":@"丈量中",@"detailId":[self getDetailIdWithSpeedCode:1]}];
            break;
        
        case 1:
            // 设计报价
            [self performSegueWithIdentifier:@"fileAndImg" sender:@{@"speedCode":[NSNumber numberWithInteger:102],@"sectionName":@"设计报价", @"detailId":[self getDetailIdWithSpeedCode:102]}];
            break;
            
        case 2:
            // 客户审批
            [self performSegueWithIdentifier:@"fileAndImg" sender:@{@"speedCode":[NSNumber numberWithInteger:201],@"sectionName":@"客户审批", @"detailId":[self getDetailIdWithSpeedCode:201]}];
            break;
            
        case 3:
            // 店主确认中
            [self performSegueWithIdentifier:@"fileAndImg" sender:@{@"speedCode":[NSNumber numberWithInteger:301],@"sectionName":@"店主确认中", @"detailId":[self getDetailIdWithSpeedCode:301]}];
            break;
            
        case 4:
            // 备货中（no）
            break;
            
        case 5:
            // 物流中（no）
            break;
            
        case 6:
            // 进场施工中
            [self performSegueWithIdentifier:@"checkWorking" sender:@{@"speedCode":[NSNumber numberWithInteger:601],@"sectionName":@"进场施工", @"detailId":[self getDetailIdWithSpeedCode:601]}];
            break;
            
        case 7:
            // 完成施工
            [self performSegueWithIdentifier:@"fileAndImg" sender:@{@"speedCode":[NSNumber numberWithInteger:701],@"sectionName":@"完成施工", @"detailId":[self getDetailIdWithSpeedCode:701]}];
            break;
            
        case 8:
            // 完成结算（no）
            break;
            
        default:
            break;
    }
    
}


# pragma mark - prepare 4 segue
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    NSString *sectionName = [sender objectForKey:@"sectionName"];
    NSInteger speedCode = [[sender objectForKey:@"speedCode"] integerValue];
    NSString *detailId = [sender objectForKey:@"detailId"];
    NSDate *finishDate = [self getDateWithSpeedCode:speedCode];
    
    if ([segue.identifier isEqualToString:@"fileAndImg"]) {
        // 设计报价/丈量中
        FileAndImgViewController *controller = segue.destinationViewController;
        controller.projectId = self.projectID;
        controller.sc = speedCode;
        controller.finishDate = finishDate;
        controller.detailId = detailId;
        controller.sectionName = sectionName;
        
        // 「店主确认中」蓝条
        if ([sectionName isEqualToString: @"店主确认中"] && self.speedCode > speedCode) {
            controller.shouldShowBanner = YES;
        }
                
    }else if([segue.identifier isEqualToString:@"checkWorking"]){
        // 施工(中、完毕)、所有材料已打包、测量完毕
        ConstructionViewController *controller = segue.destinationViewController;
        controller.projectId = self.projectID;
        controller.sc = speedCode;
        controller.detailId = detailId;
        controller.sectionName = sectionName;
        controller.showAsSingleCollection = YES;
    }
}

// get detail id
-(NSString *)getDetailIdWithSpeedCode:(NSInteger)speedCode{
    // detailId
    for (NSDictionary *tmpFlowDict in self.workFlowInfoArr) {
        // 遍历 request
        if ([tmpFlowDict[@"speedCode"] integerValue] == speedCode) {
            // 找到子节点 id ，跳出循环
            return tmpFlowDict[@"speedId"];
        }
    }
    [SVProgressHUD showErrorWithStatus:@"找不到这个项目的数据，请咨询后台！"];
    return @"";
}

// get finish time
-(NSDate *)getDateWithSpeedCode:(NSInteger)speedCode{
    // detailId
    for (NSDictionary *tmpFlowDict in self.workFlowInfoArr) {
        // 遍历 request
        if ([tmpFlowDict[@"speedCode"] integerValue] == speedCode) {
            // 找到子节点 id ，跳出循环, 返回 date
// 日期为空直接传现在的时间
            NSDate *date;
            if ([tmpFlowDict[@"finishTime"] isKindOfClass:[NSNull class]]) {
                 date = [NSDate date];
            }else{
                date = [NSDate dateWithTimeIntervalSince1970:[tmpFlowDict[@"finishTime"] integerValue]/1000.f];
            }
            return date;
        }
    }
    return [NSDate date];
}

#pragma mark - upper cell height
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.indexPathArr containsObject:indexPath]) {
        ProjectFlow *flow = self.dataArr[indexPath.row];
        NSNumber *tmpN = (NSNumber *)self.specialHeightCountArr[indexPath.row];
        NSInteger specialHCount = [tmpN integerValue];
        return flow.subTitle.count * SubCellHeight + NMCellHeight + specialHCount * SubCellSpecialHeight - NMSubTable2CellBottom;
    }else{
        return NMCellHeight;
    }
}


# pragma mark - view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    self.openTokenArr = [[NSMutableArray alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
