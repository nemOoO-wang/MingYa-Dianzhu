//
//  ShopInfoTableVC.m
//  MingYa
//
//  Created by 镓洲 王 on 10/16/17.
//  Copyright © 2017 镓洲 王. All rights reserved.
//

#import "ShopInfoTableVC.h"
/// views
#import "ShopInfoTabVC.h"
#import "ShopInfoTableCell.h"
#import "NMShop.h"
#import "ShopHeadTableViewCell.h"
#import "PickRoleViewController.h"
//#import "CommentTableViewController.h"
/// models
#import "MYUser.h"
#import "BeeNet.h"


@interface ShopInfoTableVC ()
@property (nonatomic,strong) NSArray *itemArr;
@property (nonatomic,strong) NSDictionary *projectDict;


@end

@implementation ShopInfoTableVC

# pragma mark - set project id
-(void)setProjectID:(NSString *)projectID{
    [super setProjectID:projectID];
    
    /// request
    // token
    NSString *token = [[MYUser defaultUser] token];
    // param
    NSDictionary *paramDict = @{@"token":token, @"method":@"getProjectDetail", @"page":@0, @"keyWord":@"", @"searchValue":projectID};
    // get
    [[BeeNet sharedInstance] requestWithType:Request_GET andUrl:@"/getList" andParam:paramDict andHeader:nil andSuccess:^(id data) {
        // success
        self.projectDict = (NSDictionary *)[(  (NSArray *)(data[@"data"])  ) firstObject];
        NSString *title = self.projectDict[@"projectName"];
        [self.tabBarController setTitle:title];
        [self.tableView reloadData];
    } andFailed:^(NSString *str) {
        NSLog(@"%@",str);
    }];
}

# pragma mark - itemArr
-(NSArray *)itemArr{
    if (!_itemArr) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"Shop" ofType:@"plist"];
        NSArray *originArr = [NSArray arrayWithContentsOfFile:path];
        
        NSMutableArray *tmpMutArr = [[NSMutableArray alloc] init];
        for (NSDictionary *dict in originArr) {
            NMShop *shop = [NMShop shopWithDict:dict];
            [tmpMutArr addObject:shop];
        }
        _itemArr = [tmpMutArr copy];
    }
    return _itemArr;
}

# pragma mark - View will show
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.estimatedRowHeight = 60.f;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.itemArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NMShop *shop = self.itemArr[section];
    return shop.information.count;
}

// cell for table
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(self.projectDict == nil){
        return [tableView dequeueReusableCellWithIdentifier:@"basic"];
    }
    
    NMShop *shop = self.itemArr[indexPath.section];
    NSDictionary *infoDict = shop.information[indexPath.row];
    NSString *cellIdentifier = infoDict[@"type"];
    BOOL stopping = [self.projectDict[@"isfrozen"] boolValue];
    ShopInfoTableCell *cell;
    if (indexPath.section == 0 && indexPath.row == 0 && !stopping) {
        // 第一行 && 工程进行中
        cell = [tableView dequeueReusableCellWithIdentifier:@"none"];
    }else{
        // 普通 cell
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    }
    cell.leftName = infoDict[@"title"];
    
    // project info/ basic/ phone/ detail & phone/ disclosre/ button
    NSArray *switchArr = @[@"project info", @"basic", @"phone", @"detail & phone", @"disclosure"];
    NSInteger idenIndex = [switchArr indexOfObject:cellIdentifier];
    id key4projectDic = infoDict[@"requestKey"];
    switch (idenIndex) {
        case 0:
            // top
            cell.projectIsStopping = stopping;
            if (stopping) {
                // 工程暂停
                cell.detailText = self.projectDict[@"reason"];
            }else{
                cell.detailText = @"工程进行中...";
            }
            break;
            
        case 1:
            if ([key4projectDic isKindOfClass:[NSString class]]) {
                if ([key4projectDic isEqualToString:@"beginTime"]) {
                    // 时间戳
                    NSInteger timeStrap = [self.projectDict[key4projectDic] doubleValue];
                    NSTimeInterval interval = timeStrap/ 1000.f;
                    NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval];
                    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                    [formatter setDateFormat:@"yyyy年 MM月 dd号"];
                    NSString *timeStr = [formatter stringFromDate:date];
                    cell.rightText = timeStr;
                }else{
                    // 字符串
                    cell.rightText = self.projectDict[key4projectDic];
                    
                }
            }else if ([key4projectDic isKindOfClass:[NSArray class]]){
                // 地址
                NSMutableString *mStr = [[NSMutableString alloc] init];
                for (NSString *key in key4projectDic) {
                    NSString *tmpStr = self.projectDict[key];
                    if (tmpStr == nil || [tmpStr isKindOfClass:[NSNull class]] || [tmpStr isEqualToString:@""]) {
                        continue;
                    }
                    [mStr appendString:tmpStr];
                }
                cell.rightText = [mStr copy];
            }
            break;
            
        case 2:
            // phone only
            cell.phontNumText = self.projectDict[key4projectDic];
            break;
            
        case 3:
            // name & phone
            cell.rightText = self.projectDict[key4projectDic[0]];
            cell.phontNumText = self.projectDict[key4projectDic[1]];
            break;
            
        case 4:
            // disclosure
            
            break;
            
        default:
            break;
    }
    
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    ShopHeadTableViewCell *view = [tableView dequeueReusableCellWithIdentifier:@"test head"];
    NMShop *shop = self.itemArr[section];
    view.sectionName = shop.section;
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0.f;
    }
    else if (section == 4){
        return 22.f;
    }
    return 43.f;
}


# pragma mark - 跳转
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
//    CommentTableViewController *controller = [segue destinationViewController];
//    controller.projectId = self.projectID;
    PickRoleViewController *controlller = [segue destinationViewController];
    controlller.projectId = self.projectID;
}

@end
