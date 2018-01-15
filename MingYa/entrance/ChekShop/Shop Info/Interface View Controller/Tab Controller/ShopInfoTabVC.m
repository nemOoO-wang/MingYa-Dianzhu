//
//  ShopInfoTabVC.m
//  MingYa
//
//  Created by 镓洲 王 on 10/16/17.
//  Copyright © 2017 镓洲 王. All rights reserved.
//

#import "ShopInfoTabVC.h"
#import "ShopInfoSuperTableViewController.h"

@interface ShopInfoTabVC ()

@end

@implementation ShopInfoTabVC

-(void)setProjectID:(NSString *)projectID{
    _projectID = projectID;
    NSArray *vcs = self.viewControllers;
    for (ShopInfoSuperTableViewController *tableVC in vcs) {
        tableVC.projectID = projectID;
    }
}

- (IBAction)clickQuitBtn:(id)sender {
    // user default
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:@"token"];
    [defaults removeObjectForKey:@"projectName"];
    [defaults removeObjectForKey:@"projectId"];
    [defaults removeObjectForKey:@"brandId"];
    [defaults synchronize];
    
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        //
    }];
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
