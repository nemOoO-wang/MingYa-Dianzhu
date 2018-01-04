//
//  SubTableViewWithinCellView.m
//  MingYa
//
//  Created by 镓洲 王 on 10/16/17.
//  Copyright © 2017 镓洲 王. All rights reserved.
//

#import "SubTableViewWithinCellView.h"
#import "ProjectSubTableCell.h"


#define NMUsedWidth4Status          221
#define NMSubTableSpecialHeight     63
#define NMSubTableNormallHeight     41

@interface SubTableViewWithinCellView()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,weak) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *specialHeight4IndexPathArr;
@property (nonatomic,strong) NSDateFormatter *timeFM;
// true 表示本 section 是 active（蓝色）
@property (nonatomic,assign) BOOL shouldShowActiveRowType;

@end


@implementation SubTableViewWithinCellView

-(void)setActiveRowIndex:(NSInteger)activeRowIndex{
    _activeRowIndex = activeRowIndex;
    self.shouldShowActiveRowType = YES;
}

// pre set time formatter
-(NSDateFormatter *)timeFM{
    if (!_timeFM) {
        _timeFM = [[NSDateFormatter alloc] init];
        [_timeFM setDateFormat:@"yyyy-MM-dd HH:mm"];
    }
    return _timeFM;
}

# pragma mark - set status
-(void)setProjectStatus:(MYFlowStatus)projectStatus{
    _projectStatus = projectStatus;
    
    switch (projectStatus) {
        case MYFlowStatusDone:
            //
            break;
            
        case MYFlowStatusActive:
            
            break;
            
        case MYFlowStatusToDo:
            //
            break;
            
        default:
            break;
    }
}

# pragma mark - special height arr
-(NSMutableArray *)specialHeight4IndexPathArr{
    if (!_specialHeight4IndexPathArr) {
        _specialHeight4IndexPathArr = [[NSMutableArray alloc] init];
    }
    return _specialHeight4IndexPathArr;
}

# pragma mark - setFlow
-(void)setFlow:(ProjectFlow *)flow{
    _flow = flow;
    [self.tableView reloadData];
}

#pragma mark - <UITableViewDataSource>
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    // declare identifiers
    static NSString *basicCellIdentifier = @"subcell";
    static NSString *alterCellIdentifier = @"alterCell";
    static NSString *activeCellIdentifier = @"active subcell";
    static NSString *activeBasicCellIdentifier = @"active basic cell";
    
    // declare cell
    ProjectSubTableCell *cell;
    
# warning cell 基础视图
    // 词条太长两行显示?
    UIFont *font = [UIFont systemFontOfSize:13];
    NSString *nameStr = self.flow.subTitle[indexPath.row][@"name"];
    CGSize strSize = [nameStr sizeWithAttributes:@{NSFontAttributeName:font}];
    CGFloat unusedWidth = [UIScreen mainScreen].bounds.size.width - NMUsedWidth4Status;
    // 多个子表的 special height array 可以互通，在此先把本行的 index 从 array 中去掉，重新判断
    for (NSNumber *number in self.specialHeight4IndexPathArr) {
        if ([number integerValue] == indexPath.row) {
            [self.specialHeight4IndexPathArr removeObject:number];
        }
    }
    
    // 判断蓝色框中 cell 的类型
    MYFlowActiveStatus tmpActiveStatus = MYFlowActiveStatusToDo;
    if (self.projectStatus == MYFlowStatusActive) {
        NSInteger row = indexPath.row;
        if (row < self.activeRowIndex) {
            tmpActiveStatus = MYFlowActiveStatusDone;
        }else if (row == self.activeRowIndex){
            tmpActiveStatus = MYFlowActiveStatusActive;
        }else{
            tmpActiveStatus = MYFlowActiveStatusToDo;
        }
    }
    
    // 设置 cell 类型
    if (self.shouldShowActiveRowType) {
        // 本 section 是蓝色
        if (tmpActiveStatus == MYFlowActiveStatusActive) {
            // 最新的施工 cell
            NSString *shouldShowTimeCell = @"测量中 设计中 待报价 待店主确认 待生产招牌 待备料 待发货 货到待施工";
            if ([shouldShowTimeCell containsString:nameStr]) {
                cell = [tableView dequeueReusableCellWithIdentifier:activeCellIdentifier];
                [self.specialHeight4IndexPathArr addObject:[NSNumber numberWithInteger:indexPath.row]];
            }else{
                cell = [tableView dequeueReusableCellWithIdentifier:activeBasicCellIdentifier];
            }
        }else{
            // auto set alter cell (词条过长，分行显示)
            if (strSize.width > unusedWidth) {
                // alter cell
                cell = [self.tableView dequeueReusableCellWithIdentifier:alterCellIdentifier];
                // reset special height array
                [self.specialHeight4IndexPathArr addObject:[NSNumber numberWithInteger:indexPath.row]];
            }else{
                // basic cell
                cell = [self.tableView dequeueReusableCellWithIdentifier:basicCellIdentifier forIndexPath:indexPath];
                // set subview
            }
            cell.activeStatus = tmpActiveStatus;
        }
    }else{
        // auto set alter cell (词条过长，分行显示)
        if (strSize.width > unusedWidth) {
            // alter cell
            cell = [self.tableView dequeueReusableCellWithIdentifier:alterCellIdentifier];
            // reset special height array
            [self.specialHeight4IndexPathArr addObject:[NSNumber numberWithInteger:indexPath.row]];
        }else{
            // basic cell
            cell = [self.tableView dequeueReusableCellWithIdentifier:basicCellIdentifier forIndexPath:indexPath];
            // set subview
        }
    }
    
    
# warning 设置 cell 右边的小图标
    MYFlowCellType cellType = MYFlowCellTypeNone;   // 初始化
    
    NSDictionary *segueEditDic = self.flow.subTitle[indexPath.row][@"editSegueDic"];
    NSDictionary *segueCheckDic = self.flow.subTitle[indexPath.row][@"viewSegueDic"];
    
    // canEdit: 即逻辑图的开始节点【App】
    BOOL canEdit = [self.flow.subTitle[indexPath.row][@"canEdit"] boolValue];
    //  canEditAuthorized: 后台数据的 【role】
    BOOL canEditAuthorized = NO;
    for (NSDictionary *tmpDict in self.authorityArr) {
        if([[[tmpDict allKeys] firstObject] isEqualToString:nameStr]){
            NSInteger token = [tmpDict[nameStr] integerValue];
            canEditAuthorized = (token == 1)? YES: NO;
        }
    }
#warning ishandle: 1（操作、查看）；2（看）；3（no）
    // handle: 后台【ishandle == 2】
    BOOL handle = (self.isHandle == 2 || self.isHandle == 1);
    // nameStr isequal:@"待发货" 后台【待发货节点】
    // isFinish: 后台【isfinish】
    BOOL isFinish = NO;
    for (NSDictionary *tmpDic in self.finishArr) {
        if([[tmpDic objectForKey:@"speedName"] isEqualToString:nameStr]){
            isFinish = [[tmpDic objectForKey:@"isfinish"] boolValue];
            break;
        }
    }
    
    /// choose segue logitically
    if (canEdit) {
        // App：1
        if ([nameStr isEqualToString:@"待发货"]) {
            // 待发货: 1
            if (canEditAuthorized) {
                // role: 1 【无限操作】
                if (![segueEditDic[@"segueIden"]isEqualToString:@""]) {
                    // 存在编辑
                    if (self.projectStatus == MYFlowStatusActive) {
                        cellType = MYFlowCellTypeCompose_UnSelectable;
                    }else{
                        cellType = MYFlowCellTypeCompose;
                    }
                }
            }
        }else{
            // 其他节点: 1
            if (isFinish) {
                // isfinishL 1
                if (handle) {
                    // ishandle 1 【check】
                    if (![segueCheckDic[@"segueIden"]isEqualToString:@""]) {
                        // 存在跳转
                        if (self.projectStatus == MYFlowStatusActive) {
                            cellType = MYFlowCellTypeNext_UnSelectable;
                        }else{
                            cellType = MYFlowCellTypeNext;
                        }
                    }
                }
            }else{
                // isfinishL 0
                if (canEditAuthorized) {
                    // role 1 【compose】
                    if (![segueEditDic[@"segueIden"]isEqualToString:@""]) {
                        // 存在编辑
                        if (self.projectStatus == MYFlowStatusActive) {
                            cellType = MYFlowCellTypeCompose_UnSelectable;
                        }else{
                            cellType = MYFlowCellTypeCompose;
                        }
                    }
                }else{
                    // role 0
                    if (handle) {
                        // isHandle 1 【check】
                        if (![segueCheckDic[@"segueIden"]isEqualToString:@""]) {
                            // 存在跳转
                            if (self.projectStatus == MYFlowStatusActive) {
                                cellType = MYFlowCellTypeNext_UnSelectable;
                            }else{
                                cellType = MYFlowCellTypeNext;
                            }
                        }
                    }
                }
            }
        }
        
    }else{
        // App: 0
        if (isFinish) {
            // isfinish 1
            if (handle) {
                // isHandle 1 【check】
                if (![segueCheckDic[@"segueIden"]isEqualToString:@""]) {
                    // 存在跳转
                    if (self.projectStatus == MYFlowStatusActive) {
                        cellType = MYFlowCellTypeNext_UnSelectable;
                    }else{
                        cellType = MYFlowCellTypeNext;
                    }
                }
            }
        }else{
            // isfinish 0
            if (handle) {
                // isHandle 1 【check】
                if (![segueCheckDic[@"segueIden"]isEqualToString:@""]) {
                    // 存在跳转
                    if (self.projectStatus == MYFlowStatusActive) {
                        cellType = MYFlowCellTypeNext_UnSelectable;
                    }else{
                        cellType = MYFlowCellTypeNext;
                    }
                }
            }
        }
    }
    
    // cell 未到时间，不可点击
//    NSInteger currentSpeedCode = self.sectionNumber*100 + indexPath.row + 1;
//    if (currentSpeedCode > self.speedCode) {
//        cellType = MYFlowCellTypeNone;
//    }
    
    // 赋值 cell 跳转图标
    cell.cellType = cellType;
        
    // set cell with project status
    cell.projectStatus = self.projectStatus;
    
    // 设置子单元名称
    cell.status = nameStr;
    
    // 设置子单元时间 label
    NSDate *date = [self getDateWithCellName:nameStr];
    NSString *timeLStr;
    if (date) {
        timeLStr = [self.timeFM stringFromDate:date];
    }else{
        timeLStr = @"未设置";
    }
    cell.time = timeLStr;
    
    return cell;
}

// get finish time
-(NSDate *)getDateWithCellName:(NSString *)name{
    // detailId
    for (NSDictionary *tmpFlowDict in self.subCellInfoArr) {
        // 遍历 request
        if ([tmpFlowDict[@"speedName"] isEqualToString:name]) {
            // 找到子节点 id ，跳出循环, 返回 date
// 日期为空直接传现在的时间
            NSDate *date;
            if ([tmpFlowDict[@"finishTime"] isKindOfClass:[NSNull class]]) {
//                date = [NSDate date];
                date = nil;
            }else{
                date = [NSDate dateWithTimeIntervalSince1970:[tmpFlowDict[@"finishTime"] integerValue]/1000.f];
            }
            return date;
        }
    }
    return [NSDate date];
}



# pragma mark - <UITableViewDelegate>
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    // 未展开时误触，直接返回
    if (self.enable == NO) {
        return;
    }
    // cell 未到时间，不可点击
    NSInteger currentSpeedCode = self.sectionNumber*100 + indexPath.row + 1;
    if (currentSpeedCode > self.speedCode) {
        return;
    }
    // 查找跳转的 iden
    NSString *segueIden = @"";
    NSString *viewType = @"";
    NSDictionary *segueEditDic = self.flow.subTitle[indexPath.row][@"editSegueDic"];
    NSDictionary *segueCheckDic = self.flow.subTitle[indexPath.row][@"viewSegueDic"];
    NSString *nameStr = self.flow.subTitle[indexPath.row][@"name"];
    
    // canEdit: 即逻辑图的开始节点【App】
    BOOL canEdit = [self.flow.subTitle[indexPath.row][@"canEdit"] boolValue];
    //  canEditAuthorized: 后台数据的 【role】
    BOOL canEditAuthorized = NO;
    for (NSDictionary *tmpDict in self.authorityArr) {
        if([[[tmpDict allKeys] firstObject] isEqualToString:nameStr]){
            NSInteger token = [tmpDict[nameStr] integerValue];
            canEditAuthorized = (token == 1)? YES: NO;
        }
    }
#warning 1（操作、查看）；2（看）；3（no）
    // handle: 后台【ishandle == 2】
    BOOL handle = (self.isHandle == 2 || self.isHandle == 1);
    // nameStr isequal:@"待发货" 后台【待发货节点】
    // isFinish: 后台【isfinish】
    BOOL isFinish = NO;
    for (NSDictionary *tmpDic in self.finishArr) {
        if([[tmpDic objectForKey:@"speedName"] isEqualToString:nameStr]){
            isFinish = [[tmpDic objectForKey:@"isfinish"] boolValue];
            break;
        }
    }
    
    /// choose segue logitically
    if (canEdit) {
        // App：1
        if ([nameStr isEqualToString:@"待发货"]) {
            // 待发货: 1
            if (canEditAuthorized) {
                // role: 1 【无限操作】
                segueIden = @"sendParcel";
            }
        }else{
            // 其他节点: 1
            if (isFinish) {
                // isfinishL 1
                if (handle) {
                    // ishandle 1 【check】
                    segueIden = segueCheckDic[@"segueIden"];
                    viewType = segueCheckDic[@"viewType"];
                }
            }else{
                // isfinishL 0
                if (canEditAuthorized) {
                    // role 1 【compose】
                    segueIden = segueEditDic[@"segueIden"];
                    viewType = segueEditDic[@"viewType"];
                }else{
                    // role 0
                    if (handle) {
                        // isHandle 1 【check】
                        segueIden = segueCheckDic[@"segueIden"];
                        viewType = segueCheckDic[@"viewType"];
                    }
                }
            }
        }
        
    }else{
        // App: 0
        if (isFinish) {
            // isfinish 1
            if (handle) {
                // isHandle 1 【check】
                segueIden = segueCheckDic[@"segueIden"];
                viewType = segueCheckDic[@"viewType"];
            }
        }else{
            // isfinish 0
            if (handle) {
                // isHandle 1 【check】
                segueIden = segueCheckDic[@"segueIden"];
                viewType = segueCheckDic[@"viewType"];
            }
        }
    }
    
    // 通知 delegate 跳转
    if (![segueIden isEqualToString:@""]) {
        // 存在 segue
        NSNumber *speedCode = [NSNumber numberWithInteger:self.sectionNumber*100 + indexPath.row + 1];
        NSDictionary *attriDict = @{@"viewType": viewType, @"speedCode": speedCode, @"cellName":nameStr};
        [self.delegate shouldPerformSegue:segueIden withAttributesDict:attriDict];
    }
    
}


# pragma mark - height 4 row
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    for (NSNumber *number in self.specialHeight4IndexPathArr) {
        if ([number integerValue] == indexPath.row) {
            return NMSubTableSpecialHeight;
        }
    }
    return NMSubTableNormallHeight;
}

// table delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.flow.subTitle.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

// set delegate
-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.tableHeaderView = [[UIView alloc] init];
}

@end
