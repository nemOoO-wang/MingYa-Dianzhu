//
//  PickRoleViewController.m
//  MingYa
//
//  Created by 镓洲 王 on 12/30/17.
//  Copyright © 2017 镓洲 王. All rights reserved.
//

#import "PickRoleViewController.h"
#import "UpNewCommentController.h"

@interface PickRoleViewController ()

@property (nonatomic,strong) NSArray *finishArr;

@end



@implementation PickRoleViewController
- (IBAction)clickXiangMu:(id)sender {
    if ([self.finishArr[0] integerValue] == 1) {
        [self performSegueWithIdentifier:@"view comment" sender:@{@"row":@1,@"title":@"项目经理"}];
    }else{
        [self performSegueWithIdentifier:@"reply" sender:@{@"row":@1,@"title":@"项目经理"}];
    }
}
- (IBAction)clickSheJi:(id)sender {
    if ([self.finishArr[1] integerValue] == 1) {
    [self performSegueWithIdentifier:@"view comment" sender:@{@"row":@2,@"title":@"设计师"}];
    }else{
        [self performSegueWithIdentifier:@"reply" sender:@{@"row":@2,@"title":@"设计师"}];
    }
}
- (IBAction)clickYuSuan:(id)sender {
    if ([self.finishArr[2] integerValue] == 1) {
    [self performSegueWithIdentifier:@"view comment" sender:@{@"row":@3,@"title":@"预算员"}];
    }else{
        [self performSegueWithIdentifier:@"reply" sender:@{@"row":@3,@"title":@"预算员"}];
    }
}
- (IBAction)clickCeLiang:(id)sender {
    if ([self.finishArr[3] integerValue] == 1) {
    [self performSegueWithIdentifier:@"view comment" sender:@{@"row":@4,@"title":@"测量人员"}];
    }else{
        [self performSegueWithIdentifier:@"reply" sender:@{@"row":@4,@"title":@"测量人员"}];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"view comment"]) {
        CommentTableViewController *controller = [segue destinationViewController];
        NSInteger row = [[sender objectForKey:@"row"] integerValue];
        controller.role = row;
        controller.title = [sender objectForKey:@"title"];
        controller.projectId = self.projectId;
    }else if ([segue.identifier isEqualToString:@"reply"]){
        UpNewCommentController *controller = segue.destinationViewController;
        controller.role = [[sender objectForKey:@"row"] integerValue];
        controller.title = [sender objectForKey:@"title"];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated{
    
    NSString *token = [[MYUser defaultUser] token];
    NSString *proId = [[MYUser defaultUser] projectId];
    NSDictionary *paramDic = @{@"token":token, @"method":@"getKEvalIsFinish", @"page":@0, @"searchValue":proId};
    [[BeeNet sharedInstance] requestWithType:Request_GET andUrl:@"getList" andParam:paramDic andHeader:nil andSuccess:^(id data) {
        //
        self.finishArr = data[@"data"];
        
    } andFailed:^(NSString *str) {
        NSLog(@"%@",str);
    }];
    
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
