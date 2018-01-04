//
//  ProjectConfirmViewController.m
//  MingYa
//
//  Created by 镓洲 王 on 12/14/17.
//  Copyright © 2017 镓洲 王. All rights reserved.
//

#import "ProjectConfirmViewController.h"
#import "MYUser.h"
#import <SVProgressHUD.h>


@interface ProjectConfirmViewController ()

@end


@implementation ProjectConfirmViewController
// click btn
- (IBAction)clickConfirm:(id)sender {
    NSString *token = [[MYUser defaultUser] token];
    NSString *uId = [[MYUser defaultUser] userId];
    NSDictionary *paramDict = @{@"token": token, @"sc": [NSNumber numberWithInteger:self.sc],
                                @"projectId":self.projectId, @"userId":uId,
                                @"detailId":self.detailId };
    [[BeeNet sharedInstance]requestWithType:Request_POST andUrl:@"content/clickNext" andParam:paramDict andHeader:nil andSuccess:^(id data) {
        // success
        [SVProgressHUD showSuccessWithStatus:@"更新状态成功！"];
        [SVProgressHUD dismissWithDelay:0.5];
        [self.navigationController popViewControllerAnimated:YES];
    } andFailed:nil];
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
