//
//  ArrangePeopleViewController.m
//  MingYa
//
//  Created by 陈必锋 on 2017/10/25.
//  Copyright © 2017年 镓洲 王. All rights reserved.
//

#import "ArrangePeopleViewController.h"
#import "DatePickerViewController.h"
#import "PeoplePickerViewController.h"
#import "MYUser.h"
#import <SVProgressHUD.h>
//#import "PeopleItemModel.h"


@interface ArrangePeopleViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *nextImgView;

@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *gesturesEnabled;
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;

// changed in prepare4segue
@property (nonatomic,strong) PeopleItemModel *constructManModel;
@property (nonatomic,strong) PeopleItemModel *leaderModel;
@property (nonatomic,strong) NSDate *expectedToShopTimeDate;
@property (nonatomic,strong) NSDate *realTimeDate;

@end

@implementation ArrangePeopleViewController

// 提交「安排施工人员」界面
- (IBAction)clickSubmit:(id)sender {
    if (self.isFinishArrange) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        
        NSString *token = [[MYUser defaultUser]token];
        // 修改第一项预计到货时间
        NSString *manId = self.constructManModel.peopleId;
        NSString *leaderId = self.leaderModel.peopleId;
# warning 后台空数据
        if (!leaderId) {
            leaderId = @"测试数据";
        }
        NSString *realTimeStamp = [NSString stringWithFormat:@"%f",[self.realTimeDate timeIntervalSince1970]*1000];
        NSString *expectTimeStamp = [NSString stringWithFormat:@"%f",[self.expectedToShopTimeDate timeIntervalSince1970]*1000];
        NSDictionary *paramDic = @{@"token": token,
                                   @"constructionTime":expectTimeStamp,
                                   @"constructionArr":realTimeStamp,
                                   @"constructionStart":expectTimeStamp,
                                   @"projectManId":manId,
                                   @"mpersonalId": leaderId,
                                   @"projectId":self.projectId
                                   };
        [[BeeNet sharedInstance] requestWithType:Request_POST andUrl:@"logist/con" andParam:paramDic andHeader:nil andSuccess:^(id data) {
            // success
            
        } andFailed:^(NSString *str) {
            //
            NSLog(@"插入失败");
        }];
        
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    self.isFinishArrange = YES;
    
    for (NSLayoutConstraint* constraint in self.rightToBorder) {
        [constraint setPriority:self.isFinishArrange ? 751 : 749];
    }
    
    // 初始化界面元素
    [self.realTimeL.superview.gestureRecognizers[0] setEnabled:!self.isFinishArrange];
    [self.expectedToShopTimeL.superview.gestureRecognizers[0] setEnabled:!self.isFinishArrange];
    [self.constructionPeopleL.superview.gestureRecognizers[0] setEnabled:!self.isFinishArrange];
    [self.leaderPeopleL.superview.gestureRecognizers[0] setEnabled:!self.isFinishArrange];
    
    if (self.isFinishArrange) {
        self.title = @"安排施工人员完毕";
        self.nextImgView.hidden = YES;
        self.gesturesEnabled.enabled = NO;
        [self.submitBtn setTitle:@"确认" forState:UIControlStateNormal];
    }else{
        self.title = @"货到待施工";
        // 初始化灰色 button
        self.submitBtn.enabled = NO;
        self.submitBtn.backgroundColor = [UIColor lightGrayColor];
    }
    
    // 显示 「安排完毕」 界面
    if (self.isFinishArrange) {
        // request
        NSString *token = [[MYUser defaultUser] token];
        NSDictionary *paramDic = @{@"token":token, @"method":@"getDetailConstruction", @"page":@0, @"searchValue":self.projectId, @"keyWord":@""};
        [[BeeNet sharedInstance]requestWithType:Request_GET andUrl:@"getList" andParam:paramDic andHeader:nil andSuccess:^(id data) {
            // success
            NSArray *tmpArr = data[@"data"];
            if ([tmpArr count]==0) {
                // 提示
                [SVProgressHUD showErrorWithStatus:@"后台空数据"];
                
            }else{
                // 存在数据
                NSDictionary *tmpDict = tmpArr[0];
                self.expectedTimeL.text = tmpDict[@"constructionTime"];
                self.realTimeL.text = tmpDict[@"constructionArr"];
                self.expectedToShopTimeL.text = tmpDict[@"constructionStart"];
                self.constructionPeopleL.text = tmpDict[@"nickName"];
                self.leaderPeopleL.text = tmpDict[@"monitorName"];
            }
        } andFailed:^(NSString *str) {
            // fail
            NSLog(@"%@",str);
        }];
    }
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)becomeFirstResponder{
    if (!self.isFinishArrange) {
        if ([self finishInput]) {
            // 填表完毕
            self.submitBtn.enabled = YES;
            self.submitBtn.backgroundColor = [UIColor colorWithHexString:@"429BFF"];
        }else{
            // 未完成填表
            self.submitBtn.enabled = NO;
            self.submitBtn.backgroundColor = [UIColor lightGrayColor];
        }
    }
    return YES;
}


# pragma mark - prepare 4 segue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showDatePicker"]) {
        
        // date picker
        DatePickerViewController* vc = [segue destinationViewController];
        vc.dateChanged = ^(NSDate *date) {
            // auto set label
            NSDateFormatter* df = [[NSDateFormatter alloc]init];
            [df setDateFormat:@"yyyy-MM-dd"];
            [((UILabel *)sender[@"target"]) setText:[df stringFromDate:date]];
            // set my properties
            if ([sender[@"title"] isEqualToString:@"realTime"]) {
                // realtime
                self.realTimeDate = date;
            }else{
                // expect time
                self.expectedToShopTimeDate = date;
                self.expectedTimeL.text = [df stringFromDate:date];
            }
        };
    }else if ([segue.identifier isEqualToString:@"showSelectPeople"]){
        
        // people picker
        PeoplePickerViewController* vc = [segue destinationViewController];
        vc.title = sender[@"title"];
        if ([sender[@"title"] isEqualToString:@"班长"]) {
            // 传施工人员的 id
            NSString *conId =self.constructManModel.peopleId;
            vc.constructionManId = conId;
        }
        vc.peopleSelected = ^(PeopleItemModel *userModel) {
            [sender[@"target"] setText:userModel.name];
            if ([sender[@"title"] isEqualToString:@"施工人员"]) {
                // 施工人员
                self.constructManModel = userModel;
            }else{
                // 班长
                self.leaderModel = userModel;
            }
        };
    }
}


- (IBAction)realTimeClick:(id)sender {
//    [self performSegueWithIdentifier:@"showDatePicker" sender:self.realTimeL];
    [self performSegueWithIdentifier:@"showDatePicker" sender:@{@"title":@"realTime", @"target":self.realTimeL}];
}

- (IBAction)expectedToShopTimeClick:(id)sender {
//    [self performSegueWithIdentifier:@"showDatePicker" sender:self.expectedToShopTimeL];
    [self performSegueWithIdentifier:@"showDatePicker" sender:@{@"title":@"expect2ShopTime", @"target":self.expectedToShopTimeL}];
}

- (IBAction)constructionPeopleClick:(id)sender {
    [self performSegueWithIdentifier:@"showSelectPeople" sender:@{@"title":@"施工人员",@"target":self.constructionPeopleL}];
}

- (IBAction)leaderPeopleClick:(id)sender {
    [self performSegueWithIdentifier:@"showSelectPeople" sender:@{@"title":@"班长",@"target":self.leaderPeopleL}];
}

-(BOOL)finishInput{
//    ![self.expectedTimeL.text isEqualToString:@""]&&
    if(![self.realTimeL.text isEqualToString:@""]&&
       ![self.expectedToShopTimeL.text isEqualToString:@""]&&
       ![self.constructionPeopleL.text isEqualToString:@""]&&
       ![self.leaderPeopleL.text isEqualToString:@""]){
        return YES;
    }else{
        return NO;
    }
}

@end
