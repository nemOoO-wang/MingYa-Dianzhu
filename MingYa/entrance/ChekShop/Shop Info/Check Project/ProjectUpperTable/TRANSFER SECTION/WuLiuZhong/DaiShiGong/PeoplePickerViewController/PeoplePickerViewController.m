//
//  PeoplePickerViewController.m
//  MingYa
//
//  Created by 陈必锋 on 2017/10/25.
//  Copyright © 2017年 镓洲 王. All rights reserved.
//

#import "PeoplePickerViewController.h"
#import "MYUser.h"
#import <Masonry.h>

@interface PeoplePickerViewController () <UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@property (strong,nonatomic) NSArray* peopleModels;

@end

@implementation PeoplePickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *token = [[MYUser defaultUser] token];
    
    if ([self.title isEqualToString:@"施工人员"]) {
        
        // 施工人员
        NSDictionary *paramDic = @{@"token":token, @"method":@"getAllProManage", @"page":@0};
        [[BeeNet sharedInstance] requestWithType:Request_GET andUrl:@"getList" andParam:paramDic andHeader:nil andSuccess:^(id data) {
            // success
            NSArray *tmpArr = data[@"data"];
            NSMutableArray *tmpDataArr = [[NSMutableArray alloc] init];
            for (NSDictionary *tmpDic in tmpArr) {
                PeopleItemModel *newModel = [[PeopleItemModel alloc] initWithPeopleId:tmpDic[@"userId"] andName:tmpDic[@"nickName"]];
                [tmpDataArr addObject:newModel];
            }
            self.peopleModels = [tmpDataArr copy];
            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
        } andFailed:nil];
    }else{
        
        // 班长
        NSDictionary *paramDic = @{@"token":token, @"method":@"getProDown", @"page":@0, @"searchValue":self.constructionManId};
        [[BeeNet sharedInstance] requestWithType:Request_GET andUrl:@"getList" andParam:paramDic andHeader:nil andSuccess:^(id data) {
            // success
            NSArray *tmpArr = data[@"data"];
            NSMutableArray *tmpDataArr = [[NSMutableArray alloc] init];
            for (NSDictionary *tmpDic in tmpArr) {
                PeopleItemModel *newModel = [[PeopleItemModel alloc] initWithPeopleId:tmpDic[@"userId"] andName:tmpDic[@"nickName"]];
                [tmpDataArr addObject:newModel];
            }
            self.peopleModels = [tmpDataArr copy];
            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
        } andFailed:nil];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITextFieldDelegate
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    if (textField.text.length == 0) {
        [textField.superview layoutIfNeeded];
        [UIView animateWithDuration:0.25 animations:^{
            [self.searchIcon mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.searchIcon.superview).offset(10);
            }];
            [textField.superview layoutIfNeeded];
        }];
    }
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField.text.length == 0) {
        [textField.superview layoutIfNeeded];
        [UIView animateWithDuration:0.25 animations:^{
            [self.searchIcon mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(self.searchTF.mas_left).offset(-5);
            }];
            [textField.superview layoutIfNeeded];
        }];
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return NO;
}

#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.navigationController popViewControllerAnimated:YES];
    self.peopleSelected(self.peopleModels[indexPath.row]);
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.peopleModels.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PeopleItemCell* cell = [tableView dequeueReusableCellWithIdentifier:@"PeopleItemCell" forIndexPath:indexPath];
    [cell setupWithModel:self.peopleModels[indexPath.row]];
    return cell;
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
