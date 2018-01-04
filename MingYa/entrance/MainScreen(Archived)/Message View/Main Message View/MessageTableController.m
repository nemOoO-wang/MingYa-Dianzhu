//
//  MessageTableController.m
//  MingYa
//
//  Created by 镓洲 王 on 10/18/17.
//  Copyright © 2017 镓洲 王. All rights reserved.
//

#import "MessageTableController.h"
#import "MessageTableCell.h"
#import "ShopkeepersViewController.h"
#import "MYUser.h"


typedef NS_ENUM(NSInteger, NMSelection){
    NMSelectionProgress = 0,
    NMSelectionNotification,
    NMSelectionComment,
};

@interface MessageTableController ()
@property (weak, nonatomic) IBOutlet UILabel *projectMess;
@property (weak, nonatomic) IBOutlet UILabel *projectDate;
@property (weak, nonatomic) IBOutlet UILabel *projectTimeL;
@property (weak, nonatomic) IBOutlet UILabel *workMessL;
@property (weak, nonatomic) IBOutlet UILabel *workDateL;
@property (weak, nonatomic) IBOutlet UILabel *workTimeL;
@property (weak, nonatomic) IBOutlet UILabel *commentMessL;
@property (weak, nonatomic) IBOutlet UILabel *commentDateL;
@property (weak, nonatomic) IBOutlet UILabel *commentTimeL;


@end

@implementation MessageTableController
// back 2 superView

# pragma mark - select cell
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *segueIdentifier = @"message detail";
    [self performSegueWithIdentifier:segueIdentifier sender:self];
}

# pragma mark - will perform segue
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    ShopkeepersViewController *controller = [segue destinationViewController];
    NSIndexPath *indxPath = self.tableView.indexPathForSelectedRow;
    NSString *titleStr;
    switch (indxPath.row) {
        case NMSelectionProgress:
            controller.showType = ShopkeepersVCTypeProject;
            titleStr = @"项目进度";
            break;
        
        case NMSelectionNotification:
            controller.showType = ShopkeepersVCTypeWork;
            titleStr = @"工作提示";
            break;
            
        case NMSelectionComment:
            controller.showType = ShopkeepersVCTypeComment;
            titleStr = @"店主评价";
            break;
            
        default:
            titleStr = @"未选中";
            break;
    }
    
    controller.selection = titleStr;
//    [controller setTitle:titleStr];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // clear separator
    if (!self.tableView.tableFooterView) {
        self.tableView.tableFooterView = [[UIView alloc] init];
    }
    
    //request
//    NSString *token = [[MYUser defaultUser] token];
//    if (!token) {
//        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//# warning token 有可能已经过期
//        token = [defaults objectForKey:@"token"];
//        NSString *userId = [defaults objectForKey:@"userId"];
//        [[MYUser defaultUser] registToken:token andId:userId];
//    }
//    NSDictionary *proParamDic = @{@"token":token, @"method":@"getPorjectSpeedMsgLast", @"page":@0, @"searchValue":@2};
//
//    NSDateFormatter *timeFm = [[NSDateFormatter alloc] init];
//    [timeFm setDateFormat:@"HH:mm"];
//    NSDateFormatter *dateFm = [[NSDateFormatter alloc] init];
//    [dateFm setDateFormat:@"MM月dd日"];
//
//    // project
//    [[BeeNet sharedInstance] requestWithType:Request_GET andUrl:@"getList" andParam:proParamDic andHeader:nil andSuccess:^(id data) {
//        // success
//        NSDictionary *tmpDic = data[@"data"];
//        if ([tmpDic isKindOfClass:[NSDictionary class]]) {
//
//            NSDate *date = [NSDate dateWithTimeIntervalSince1970:[tmpDic[@"updateDate"] integerValue]/1000.f];
//            NSString *dateStr = [dateFm stringFromDate:date];
//            NSString *timeStr = [timeFm stringFromDate:date];
//            NSString *message = tmpDic[@"projectName"];
//            self.projectMess.text = message;
//            self.projectDate.text = dateStr;
//            self.projectTimeL.text = timeStr;
//        }
//
//    } andFailed:^(NSString *str) {
//        // fail
//    }];
//
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
