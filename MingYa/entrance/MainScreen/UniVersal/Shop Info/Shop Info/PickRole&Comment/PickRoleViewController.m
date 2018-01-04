//
//  PickRoleViewController.m
//  MingYa
//
//  Created by 镓洲 王 on 12/30/17.
//  Copyright © 2017 镓洲 王. All rights reserved.
//

#import "PickRoleViewController.h"
#import "CommentTableViewController.h"

@interface PickRoleViewController ()

@end

@implementation PickRoleViewController
- (IBAction)clickXiangMu:(id)sender {
    [self performSegueWithIdentifier:@"view comment" sender:@{@"row":@1,@"title":@"项目经理"}];
}
- (IBAction)clickSheJi:(id)sender {
    [self performSegueWithIdentifier:@"view comment" sender:@{@"row":@2,@"title":@"设计师"}];
}
- (IBAction)clickYuSuan:(id)sender {
    [self performSegueWithIdentifier:@"view comment" sender:@{@"row":@3,@"title":@"预算员"}];
}
- (IBAction)clickCeLiang:(id)sender {
    [self performSegueWithIdentifier:@"view comment" sender:@{@"row":@4,@"title":@"测量人员"}];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    CommentTableViewController *controller = [segue destinationViewController];
    controller.role = [[sender objectForKey:@"row"] integerValue];
    controller.title = [sender objectForKey:@"title"];
    controller.projectId = self.projectId;
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
