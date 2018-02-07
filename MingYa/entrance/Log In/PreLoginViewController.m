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
#import "ShopInfoTabVC.h"


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
    
    [NSThread sleepForTimeInterval:2];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *token = [defaults objectForKey:@"token"];
    NSString *brandId = [defaults objectForKey:@"brandId"];
    NSString *projectId = [defaults objectForKey:@"projectId"];
    NSString *projectName = [defaults objectForKey:@"projectName"];
    
    // nil token
    if (token == nil || projectId == nil) {
        [self performSegueWithIdentifier:LoginIden sender:self];
        [SVProgressHUD dismiss];
    }else{
        // request test
        NSDictionary *paramDict = @{@"token":token, @"method":@"getAllSpeedDetailById", @"page":@0, @"keyWord":@"",@"searchValue":projectId};
        [[BeeNet sharedInstance] requestWithType:Request_GET andUrl:@"/getList" andParam:paramDict andHeader:nil andSuccess:^(id data) {
            // success
            if ([data[@"ret"] boolValue]) {
                [[MYUser defaultUser] registToken:token andId:brandId andProjectId:projectId andProjectName:projectName];
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
        
    }
}


# pragma mark - prepare4Login
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([[segue destinationViewController] isKindOfClass:[UINavigationController class]]) {
        UINavigationController *naviVC = [segue destinationViewController];
        ShopInfoTabVC *vc = [[naviVC viewControllers]firstObject];
        vc.projectID = [[MYUser defaultUser] projectId];
    }
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



@end
