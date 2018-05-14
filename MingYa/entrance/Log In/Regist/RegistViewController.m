//
//  RegistViewController.m
//  MingYa
//
//  Created by 镓洲 王 on 4/23/18.
//  Copyright © 2018 镓洲 王. All rights reserved.
//

#import "RegistViewController.h"
#import "MD5Utils.h"

@interface RegistViewController ()
@property (weak, nonatomic) IBOutlet UITextField *usrNameTxtView;
@property (weak, nonatomic) IBOutlet UITextField *pswTxtView;

@end

@implementation RegistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)clickRegBtn:(id)sender {
    // via net
    NSString *usrName = self.usrNameTxtView.text;
    NSString *pwdStr = [MD5Utils md5WithString:self.pswTxtView.text];
    NSDictionary *paramDic = @{@"userTel":usrName, @"pwd":pwdStr, @"type":@3};
    [[BeeNet sharedInstance] requestWithType:Request_POST andUrl:@"login/fake" andParam:paramDic andHeader:nil andSuccess:^(id data) {
        NSLog(@"success");
        
    } andFailed:^(NSString *str) {
        NSLog(@"%@", str);
    }];
    [SVProgressHUD showSuccessWithStatus:@"注册成功"];
    // qui VC
    [self.parentViewController dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (IBAction)clickQuitBtn:(id)sender {
    [self.parentViewController dismissViewControllerAnimated:YES completion:^{
        
    }];
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
