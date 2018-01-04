//
//  NotShippedViewController.m
//  MingYa
//
//  Created by 陈必锋 on 2017/10/24.
//  Copyright © 2017年 镓洲 王. All rights reserved.
//

#import "NotShippedViewController.h"
#import "DatePickerViewController.h"
#import "GoodsListItemCell.h"
#import "MYUser.h"
#import <AFNetworking.h>
#import <SVProgressHUD.h>

@interface NotShippedViewController () <UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIButton *submitBtn;
@property (strong,nonatomic) NSMutableArray* goodsItemModelDatas;
@property (nonatomic) NSInteger nowPickIndex;
@property (nonatomic) BOOL nowIsPickSendDate;

@end

@implementation NotShippedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.estimatedRowHeight = 100;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    //假数据
//    self.isShipped = YES;
//
//    GoodsListItemModel* m1 = [[GoodsListItemModel alloc]init];
//    m1.goodsNames = @"钢架、手脚架、三轮车";
//    m1.logisticsCompanyName = @"逆风快递";
//    m1.logisticsPhone = @"13570938184";
//    m1.logisticsNum = @"12223564872123";
//    m1.sendDate = @"2017-10-24";
//    m1.expectedDate = @"2017-10-25";
//
//    self.goodsItemModelDatas = [NSMutableArray arrayWithArray:@[m1]];
    
    
    //是否已发货
    if (self.isShipped) {
        // 「已发货」界面
        self.title = @"已发货";
        self.tableView.tableFooterView = nil;
        self.submitBtn.hidden = YES;
        // retuest
        NSString *token = [[MYUser defaultUser] token];
        NSDictionary *paramDic = @{@"token":token, @"method":@"getAllLogPage", @"page":@0, @"searchValue":self.projectId};
        [[BeeNet sharedInstance] requestWithType:Request_GET andUrl:@"getList" andParam:paramDic andHeader:nil andSuccess:^(id data) {
            // success
# warning 貌似没数据
            NSArray *tmpArr = data[@"data"];
            if ([tmpArr count]==0) {
                // 提示
                [SVProgressHUD showErrorWithStatus:@"后台空数据"];
                
            }else{
                NSMutableArray *tmpDataArr = [[NSMutableArray alloc] init];
                for (NSDictionary *tmpDic in tmpArr) {
                    GoodsListItemModel *newModel = [[GoodsListItemModel alloc] init];
                    newModel.logisticsId = tmpDic[@"logisticsId"];
                    newModel.goodsNames = tmpDic[@"logisticsName"];
                    newModel.logisticsCompanyName = tmpDic[@"logisticsCompany"];
                    newModel.logisticsPhone = tmpDic[@"logisticsTel"];
                    newModel.logisticsNum = tmpDic[@"logisticsNo"];
                    // string
                    NSDateFormatter *df = [[NSDateFormatter alloc] init];
                    [df setDateFormat:@"yyyy-MM-dd HH:mm:ss.0"];
                    NSString *sendDateStr = tmpDic[@"logisticsTime"];
                    newModel.sendDate = [df dateFromString:sendDateStr];
                    NSString *expDateStr = tmpDic[@"arriveTime"];
                    newModel.expectedDate = [df dateFromString:expDateStr];
                    [tmpDataArr addObject:newModel];
                }
                self.goodsItemModelDatas = tmpDataArr;
                [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
                
            }
        } andFailed:nil];
    }else{
        //
        self.title = @"未发货";
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSMutableArray *)goodsItemModelDatas{
    if (_goodsItemModelDatas == nil) {
        _goodsItemModelDatas = [NSMutableArray array];
    }
    return _goodsItemModelDatas;
}

#pragma mark - UITableViewDelegate


#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.goodsItemModelDatas.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    GoodsListItemCell* cell = [tableView dequeueReusableCellWithIdentifier:@"GoodsListItemCell" forIndexPath:indexPath];
    [cell setupWithModel:self.goodsItemModelDatas[indexPath.row] andIndex:indexPath.row andDeleteBlock:^{
        [self.goodsItemModelDatas removeObjectAtIndex:indexPath.row];
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
    } andDatePickerBlock:^(BOOL isSendDate) {
        self.nowIsPickSendDate = isSendDate;
        self.nowPickIndex = indexPath.row;
        [self performSegueWithIdentifier:@"showDatePicker" sender:nil];
    } andIsOnlyShow:self.isShipped];
    return cell;
}



- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showDatePicker"]) {
        DatePickerViewController* vc = [segue destinationViewController];
        
        if (self.nowIsPickSendDate) {
            vc.nowSelectDate = [self.goodsItemModelDatas[self.nowPickIndex] sendDate];
        }else{
            vc.nowSelectDate = [self.goodsItemModelDatas[self.nowPickIndex] expectedDate];
        }
        
        vc.dateChanged = ^(NSDate *date) {
            NSDateFormatter* df = [[NSDateFormatter alloc]init];
            [df setDateFormat:@"yyyy-MM-dd"];
            if (self.nowIsPickSendDate) {
//                [self.goodsItemModelDatas[self.nowPickIndex] setSendDate:[df stringFromDate:date]];
                [self.goodsItemModelDatas[self.nowPickIndex] setSendDate:date];
            }else{
//                [self.goodsItemModelDatas[self.nowPickIndex] setExpectedDate:[df stringFromDate:date]];
                [self.goodsItemModelDatas[self.nowPickIndex] setExpectedDate:date];
            }
            [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:self.nowPickIndex inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
        };
    }
}


- (IBAction)addItemBtnClick:(id)sender {
    [self.goodsItemModelDatas addObject:[[GoodsListItemModel alloc]init]];
    [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:self.goodsItemModelDatas.count - 1 inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
}

- (IBAction)submitBtnClick:(id)sender {
    // 确认发货信息 BTN
    NSMutableArray *tmpDataArr = [[NSMutableArray alloc] init];
    NSDateFormatter *fm = [[NSDateFormatter alloc] init];
    [fm setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    for (GoodsListItemModel *model in self.goodsItemModelDatas) {
        // new dic 4 logistic
        model.logisticsId = @"";
        NSDictionary *tmpDic = @{@"arriveTime":[fm stringFromDate:model.expectedDate],
                                 @"logisticsTime":[fm stringFromDate:model.sendDate],
                                 @"logisticsNo":model.logisticsNum,
                                 @"logisticsTel":model.logisticsPhone,
                                 @"logisticsCompany":model.logisticsId,
                                 @"logisticsName":model.logisticsCompanyName
                                 };
        [tmpDataArr addObject:tmpDic];
    }
//    NSData *data = [NSJSONSerialization dataWithJSONObject:tmpDataArr options:0 error:nil];
//    NSString *logListJsonStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    // request
    NSString *token = [[MYUser defaultUser] token];
    NSString *url = [NSString stringWithFormat:@"logist/ioeApp?token=%@",token];
    NSDictionary *paramDic = @{@"projectId":self.projectId, @"logList":tmpDataArr};
    
    [[BeeNet sharedInstance] requestWithType:Request_POST
                                      andUrl:url andParam:paramDic andHeader:nil andRequestSerializer:[AFJSONRequestSerializer serializer] andResponseSerializer:[AFJSONResponseSerializer serializer] andSuccess:^(id data) {
                                          // s
                                          [SVProgressHUD showSuccessWithStatus:@"发送成功"];
                                          [SVProgressHUD dismissWithDelay:0.2];
                                          [self.navigationController popViewControllerAnimated:YES];
                                      } andFailed:^(NSString *str) {
                                          // f
                                          [SVProgressHUD showErrorWithStatus:@"上传失败"];
                                      }];
    /*
     
     [[BeeNet sharedInstance] requestWithType:Request_POST
     andUrl:@"http://192.168.3.74:8080/mingya/logist/ioeApp?token=3341cf27efd67335af746f7fcf949275"
     andParam:@{@"logList":@[@{
     @"logisticsName":@"这",
     @"logisticsTime":@"2017-12-19 19:02:33",
     @"arriveTime":@"2017-12-19 19:02:35",
     @"logisticsNo":@"56",
     @"logisticsTel":@"556",
     @"logisticsCompany":@""
     
     }],
     @"projectId":@"8c3ccd47-d311-11e7-9489-00ffaa44f255"}
     andHeader:nil
     andSuccess:^(id data) {
     NSLog(@"success:%@",data);
     } andFailed:^(NSString *str) {
     NSLog(@"data : %@",str);
     }];
     
     */
    
    
//    [[BeeNet sharedInstance] requestWithType:Request_POST andUrl:url andParam:paramDic andHeader:nil andSuccess:^(id data) {
//        // success
//        [SVProgressHUD showSuccessWithStatus:@"发送成功"];
//        [SVProgressHUD dismissWithDelay:0.2];
//        [self.navigationController popViewControllerAnimated:YES];
//    } andFailed:^(NSString *str) {
//        // fail
//
//    }];
}
@end
