//
//  ConstructionDatePickerVC.m
//  MingYa
//
//  Created by 镓洲 王 on 12/21/17.
//  Copyright © 2017 镓洲 王. All rights reserved.
//

#import "ConstructionDatePickerVC.h"
#import "DatePickerViewController.h"
#import "MYUser.h"


@interface ConstructionDatePickerVC ()
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (nonatomic,strong) NSString *dateStr;


@end

@implementation ConstructionDatePickerVC
- (IBAction)click2PickeDateBtn:(id)sender {
    [self performSegueWithIdentifier:@"showDatePicker" sender:nil];
}

- (IBAction)clickSubmitBtn:(id)sender {
    if ([self.timeLabel.text isEqualToString:@"请选择"]) {
        // 未输入
    }else{
        NSString *token = [[MYUser defaultUser] token];
        NSDictionary *paramDic = @{@"token":token, @"projectId":self.projectId, @"finishDate":self.dateStr};
        [[BeeNet sharedInstance] requestWithType:Request_POST andUrl:@"constructioni/setFinishTime" andParam:paramDic andHeader:nil andSuccess:^(id data) {
            // success
            if ([self.delegate respondsToSelector:@selector(finishUpdateDate)]) {
                [self.delegate performSelector:@selector(finishUpdateDate)];
            }
            
        } andFailed:^(NSString *str) {
            // fail
        }];
    }
}

# pragma mark - prepare 4 segue
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    // date picker
    DatePickerViewController* vc = [segue destinationViewController];
    vc.dateChanged = ^(NSDate *date) {
        NSDateFormatter *fm = [[NSDateFormatter alloc] init];
        [fm setDateFormat:@"yyyy-MM-dd"];
        self.timeLabel.text = [fm stringFromDate:date];
        [fm setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        self.dateStr = [fm stringFromDate:date];
    };
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
