//
//  MeViewController.m
//  MingYa
//
//  Created by 镓洲 王 on 10/19/17.
//  Copyright © 2017 镓洲 王. All rights reserved.
//

#import "MeViewController.h"
#import "MeTableViewCell.h"
#import "MYUser.h"
#import <JPUSHService.h>


@interface MeViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSDictionary *dataDict;



@end

@implementation MeViewController
# pragma mark - log out button
- (IBAction)clickLogOutBtn:(id)sender {
    // user default
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:@"token"];
    [defaults removeObjectForKey:@"userId"];
    [defaults synchronize];
    
    // JPush
    [JPUSHService deleteAlias:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
        NSLog(@"irescode:%ld\nialias:%@\nseq:%ld",iResCode,iAlias,seq);
    } seq:0];
    
    // pop
    [self dismissViewControllerAnimated:YES completion:^{
        //
    }];
}

# pragma mark - table delegate
// cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *meCelIdentifier = @"me cell";
    MeTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:meCelIdentifier];
    switch (indexPath.row) {
        case 0:
            cell.left = @"姓名";
            cell.right = self.dataDict[@"nickName"];
            break;
        
        case 1:
            cell.left = @"联系方式";
            cell.right = self.dataDict[@"tel"];
            break;
            
        case 2:
            cell.left = @"部门";
            cell.right = self.dataDict[@"departmentName"];
            break;
        
        case 3:
            cell.left = @"岗位";
            cell.right = self.dataDict[@"stationName"];
            break;
            
        default:
            break;
    }
    return cell;
}

// row number
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}
// section number
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

# pragma mark - height
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // request
    NSString *token = [[MYUser defaultUser] token];
    NSString *uId = [[MYUser defaultUser] userId];
    NSDictionary *paramDict = @{ @"token": token, @"method": @"getUserDetail", @"page": @0, @"keyWord":@"", @"searchValue": uId};
    [[BeeNet sharedInstance] requestWithType:Request_GET andUrl:@"getList" andParam:paramDict andHeader:nil andSuccess:^(id data) {
        // success
        if ([data[@"data"] count] != 0) {
            self.dataDict = data[@"data"][0];
            [self.tableView reloadData];
        }
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
