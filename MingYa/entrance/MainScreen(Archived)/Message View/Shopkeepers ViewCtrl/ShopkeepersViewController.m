//
//  ShopkeepersViewController.m
//  MingYa
//
//  Created by 镓洲 王 on 10/19/17.
//  Copyright © 2017 镓洲 王. All rights reserved.
//

#import "ShopkeepersViewController.h"
#import "ShopkeepersTableViewCell.h"
#import "MYUser.h"
#import <SVProgressHUD.h>


#define NMProgressImgStr @"incon_blue2"
#define NMNotificationImgStr @"incon_yellow2"
#define NMCommentImgStr @"incon_blue2"


@interface ShopkeepersViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIImageView *imgView;

@property (nonatomic,strong) NSArray *dataArr;


@end



@implementation ShopkeepersViewController
# pragma mark - <UITableViewDataSource>
// cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *timeCellIdentifier = @"time";
    static NSString *shopCellIdentifier = @"shop";
    ShopkeepersTableViewCell *cell;
    
    if (indexPath.row % 2 == 0) {
        // time cell
        cell = [self.tableView dequeueReusableCellWithIdentifier:timeCellIdentifier];
        [cell setBackgroundColor:[UIColor clearColor]];
        
        // set data
        NSDateFormatter *fm = [[NSDateFormatter alloc] init];
        [fm setDateFormat:@"yyyy 年MM月dd日 HH:mm"];
        NSDate *date;
        switch (self.showType) {
            case ShopkeepersVCTypeProject:
                date = [NSDate dateWithTimeIntervalSince1970:[self.dataArr[indexPath.row/2][@"updateDate"] integerValue]/1000];
                break;
             
            case ShopkeepersVCTypeWork:
                date = [NSDate dateWithTimeIntervalSince1970:[self.dataArr[indexPath.row/2][@"asishiba"] integerValue]/1000];
                break;
                
            case ShopkeepersVCTypeComment:
                // 四个时间？？
                date = [NSDate dateWithTimeIntervalSince1970:[self.dataArr[indexPath.row/2][@"ktoptime"] integerValue]/1000];
                break;
                
            default:
                break;
        }
        cell.timeLabel.text = [fm stringFromDate:date];
        
    }else{
        // shop
        cell = [self.tableView dequeueReusableCellWithIdentifier:shopCellIdentifier];
        [cell setBackgroundColor:[UIColor whiteColor]];
        // set data
        NSString *titleName;
        if (self.showType == ShopkeepersVCTypeProject){
            cell.shopNameLabel.text = self.dataArr[indexPath.row/2][@"projectName"];
            titleName = self.dataArr[indexPath.row/2][@"speedName"];
            cell.messageDetailLabel.text = [NSString stringWithFormat:@"该项目进入%@阶段，点击查看详情",titleName];
        }else if (self.showType == ShopkeepersVCTypeWork){
            cell.shopNameLabel.text = self.dataArr[indexPath.row/2][@"bliu"];
            NSDate *now = [NSDate dateWithTimeIntervalSince1970:[self.dataArr[indexPath.row/2][@"asishiba"] integerValue]/1000];
            NSDate *deadLine = [NSDate dateWithTimeIntervalSince1970:[self.dataArr[indexPath.row/2][@"bshiba"] integerValue]/1000];
            // 2.创建日历
            NSCalendar *calendar = [NSCalendar currentCalendar];
            NSCalendarUnit type = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour;
            // 3.利用日历对象比较两个时间的差值
            NSDateComponents *cmps = [calendar components:type fromDate:now toDate:deadLine options:0];
            NSString *nextSectionName = self.dataArr[indexPath.row/2][@"tabletimeName"];
            // 4.输出结果
            NSInteger interval = (long)cmps.hour;
            NSString *intervalStr;
            if (interval>0) {
                intervalStr = [NSString stringWithFormat:@"距离%@剩下%ld小时，请尽快完工",nextSectionName,interval];
            }else{
                intervalStr = [NSString stringWithFormat:@"%@阶段已超过%ld小时，请尽快完工",nextSectionName,interval];
            }
            cell.messageDetailLabel.text = intervalStr;
        }else if (self.showType == ShopkeepersVCTypeComment){
            cell.shopNameLabel.text = self.dataArr[indexPath.row/2][@"projectName"];
            cell.messageDetailLabel.text = @"已评价";
        }
    }
    return cell;
}

// row number
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count*2;
}

// sectiong number
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


# pragma mark - view did load
// view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    // set table
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.estimatedRowHeight = 70.f;
    // other settings
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [self.navigationController.navigationBar setTintColor:[UIColor blackColor]];
    [self setTitle:self.selection];
    
    // request
    NSString *token = [[MYUser defaultUser] token];
    NSDictionary *paramDic;
    switch (self.showType) {
        case ShopkeepersVCTypeProject:
            paramDic = @{@"token":token, @"page":@0, @"method":@"getProjectSpeedMsg", @"searchValue":@2};
            break;
          
        case ShopkeepersVCTypeWork:
            paramDic = @{@"token":token, @"page":@0, @"method":@"getworktip"};
            break;
            
        case ShopkeepersVCTypeComment:
            paramDic = @{@"token":token, @"page":@0, @"method":@"getKeeperEvalList"};
            break;
            
        default:
            break;
    }
    [[BeeNet sharedInstance]requestWithType:Request_GET andUrl:@"getList" andParam:paramDic andHeader:nil andSuccess:^(id data) {
        // success
        NSArray *tmpArr = data[@"data"];
        if ([tmpArr count]>0) {
            if ([tmpArr[0] isKindOfClass:[NSNull class]]) {
                [SVProgressHUD showErrorWithStatus:@"没有新消息"];
            }else{
                self.dataArr = tmpArr;
                [self.tableView reloadData];
            }
        }else{
            [SVProgressHUD showErrorWithStatus:@"没有新消息"];
        }
    } andFailed:^(NSString *str) {
        // fail
        NSLog(@"%@",str);
    }];
}

// will disappear
-(void)viewWillDisappear:(BOOL)animated{
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
