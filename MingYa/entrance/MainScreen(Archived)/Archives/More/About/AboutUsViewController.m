//
//  AboutUsViewController.m
//  MingYa
//
//  Created by 镓洲 王 on 12/4/17.
//  Copyright © 2017 镓洲 王. All rights reserved.
//

#import "AboutUsViewController.h"
#import "BeeNet.h"
#import "MYUser.h"


@interface AboutUsViewController ()
@property (weak, nonatomic) IBOutlet UITextView *usTextField;

@end

@implementation AboutUsViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // request
    NSString *token = [[MYUser defaultUser] token];
    NSDictionary *paramDict = @{ @"token":token, @"method": @"getAboutUs", @"page": @0};
    [[BeeNet sharedInstance] requestWithType:Request_GET andUrl:@"getList" andParam:paramDict andHeader:nil andSuccess:^(id data) {
        // success
        self.usTextField.text = data[@"data"][@"aboutContent"];
    } andFailed:nil];
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
