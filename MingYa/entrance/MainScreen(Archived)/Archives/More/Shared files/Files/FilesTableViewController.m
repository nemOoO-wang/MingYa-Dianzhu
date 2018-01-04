//
//  FilesTableViewController.m
//  MingYa
//
//  Created by 镓洲 王 on 10/25/17.
//  Copyright © 2017 镓洲 王. All rights reserved.
//

#import "FilesTableViewController.h"
#import "FileTableViewCell.h"
#import "BeeNet.h"
#import "MYUser.h"
#import "FileDownloadOrOpenViewController.h"

@interface FilesTableViewController ()

@property (nonatomic,strong) NSArray *dataArr;


@end

@implementation FilesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 60.f;
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    // request
    NSString *token = [[MYUser defaultUser] token];
    NSDictionary *paramDict = @{@"token":token, @"method":@"getShareNotImageApp", @"page":@0, @"keyWord":@"", @"searchValue":@""};
    [[BeeNet sharedInstance] requestWithType:Request_GET andUrl:@"/getList" andParam:paramDict andHeader:nil andSuccess:^(id data) {
        // success
        self.dataArr = data[@"data"];
        [self.tableView reloadData];
    } andFailed:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FileTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"file" forIndexPath:indexPath];
    
    cell.dict = self.dataArr[indexPath.row];
    
    return cell;
}

# pragma mark - <UITableViewDelegate>
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dict = self.dataArr[indexPath.row];
    // file name
    NSString *fileType = dict[@"shareSuffix"];
    NSString *fileName = dict[@"shareName"];
    NSString *completeName = [NSString stringWithFormat:@"%@.%@",fileName,fileType];
    // url
    NSString *url = dict[@"shareUrl"];
    float fileSize = [dict[@"shareSize"] floatValue];
    FileItemModel *fileModel = [FileItemModel modelWithFileName:completeName andFileUrl:url andFileSize:fileSize];
    [self performSegueWithIdentifier:@"showFileDownload" sender:fileModel];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"showFileDownload"]) {
        FileDownloadOrOpenViewController* vc = [segue destinationViewController];
        vc.itemModel = sender;
    }
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
