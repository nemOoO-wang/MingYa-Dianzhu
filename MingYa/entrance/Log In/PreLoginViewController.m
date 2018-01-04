//
//  PreLoginViewController.m
//  MingYa
//
//  Created by 镓洲 王 on 12/24/17.
//  Copyright © 2017 镓洲 王. All rights reserved.
//

#import "PreLoginViewController.h"
#import "MYUser.h"
#import <SVProgressHUD.h>


#define LoginIden @"login"
#define LoggedIden @"logged"
#define NotiIden @"notification"


@interface PreLoginViewController ()

@end

@implementation PreLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)viewDidAppear:(BOOL)animated{
    [SVProgressHUD showWithStatus:@"尝试自动登录..."];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *token = [defaults objectForKey:@"token"];
    NSString *userId = [defaults objectForKey:@"userId"];
#warning 先不搞自动登录
    [self performSegueWithIdentifier:LoginIden sender:self];
    
    [SVProgressHUD dismiss];
    /*
    // nil token
    if (token == nil) {
        [self performSegueWithIdentifier:LoginIden sender:self];
        [SVProgressHUD dismiss];
    }else{
        // request test
        NSDictionary *paramDic = @{@"token":token, @"method":@"getKEvalIsFinish", @"page":@0};
        [[BeeNet sharedInstance] requestWithType:Request_GET andUrl:@"getList" andParam:paramDic andHeader:nil andSuccess:^(id data) {
            // success
            if ([data[@"ret"] boolValue]) {
                [[MYUser defaultUser] registToken:token andId:userId];
                [self performSegueWithIdentifier:LoggedIden sender:self];
            }else{
                [self performSegueWithIdentifier:LoginIden sender:self];
            }
            
            [SVProgressHUD dismiss];
        } andFailed:^(NSString *str) {
            // fail
            [self performSegueWithIdentifier:LoginIden sender:self];
            
            [SVProgressHUD dismiss];
            [SVProgressHUD showErrorWithStatus:@"通信失败,请登录"];
        }];
        
    }*/
}

//# pragma mark - show noti VC
//-(void)shouldShowNotificationViewController{
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    NSString *token = [defaults objectForKey:@"token"];
//    NSString *userId = [defaults objectForKey:@"userId"];
//    // nil token
//    if (!token) {
//        [SVProgressHUD showErrorWithStatus:@"登录无效请重新登录！"];
//        [self performSegueWithIdentifier:LoginIden sender:self];
//    }else{
//        // request test
//        NSDictionary *paramDic = @{@"token":token, @"method":@"getAboutUs", @"page":@0};
//        [[BeeNet sharedInstance] requestWithType:Request_GET andUrl:@"getList" andParam:paramDic andHeader:nil andSuccess:^(id data) {
//            // success
//            if ([data[@"ret"] boolValue]) {
//                [[MYUser defaultUser] registToken:token andId:userId];
//                [self performSegueWithIdentifier:NotiIden sender:self];
//            }else{
//                [SVProgressHUD showErrorWithStatus:@"登录无效请重新登录！"];
//                [self performSegueWithIdentifier:LoginIden sender:self];
//            }
//        } andFailed:^(NSString *str) {
//            // fail
//            [SVProgressHUD showErrorWithStatus:@"登录无效请重新登录！"];
//            [self performSegueWithIdentifier:LoginIden sender:self];
//        }];
//        
//    }
//}


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
