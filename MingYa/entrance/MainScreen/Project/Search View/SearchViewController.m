//
//  SearchViewController.m
//  MingYa
//
//  Created by 镓洲 王 on 10/16/17.
//  Copyright © 2017 镓洲 王. All rights reserved.
//

#import "SearchViewController.h"
/// views
#import "SearchTextField.h"
#import "QuitKeyboardView.h"
#import "SearchTableCell.h"
#import "ShopInfoTabVC.h"
/// models
#import "MYUser.h"
#import "BeeNet.h"


typedef NS_ENUM(NSInteger, SearchTableType) {
    SearchTableTypeHistory,
    SearchTableTypeResult,
};

@interface SearchViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
// views
@property (strong, nonatomic) IBOutlet QuitKeyboardView *quitKeyboardView;
@property (weak, nonatomic) IBOutlet SearchTextField *textField;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NMButton *clearHittoryBtn;
// data
@property (nonatomic,assign) SearchTableType type;
@property (nonatomic,strong) NSArray *recordsArr;
@property (nonatomic,strong) NSArray *resultArr;
@property (nonatomic,strong) NSString *selectedProjectId;
@property (nonatomic,strong) NSString *plistPath;
@end


// identifers
static NSString *historyCellIdentifier = @"history cell";
static NSString *resultCellIdentifier = @"result cell";
// segue identifier
static NSString *segueIdentifier = @"check project";

@implementation SearchViewController

# pragma mark - get data models
// plist path
-(NSString *)plistPath{
    if (!_plistPath) {
        //获取路径对象
        NSArray *paths =NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
        //获取完整路径
        NSString *documentsDirectory = [paths objectAtIndex:0];
        _plistPath = [documentsDirectory stringByAppendingPathComponent:@"SearchRecords.plist"];
    }
    return _plistPath;
}

// records
-(NSArray *)recordsArr{
    if (!_recordsArr) {
        _recordsArr = [NSArray arrayWithContentsOfFile:self.plistPath];
    }
    return _recordsArr;
}

-(void)setType:(SearchTableType)type{
    _type = type;
    if (type == SearchTableTypeHistory) {
        self.clearHittoryBtn.hidden = NO;
    }else{
        self.clearHittoryBtn.hidden = YES;
    }
}


# pragma mark - <UITextFieldDelegate>
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    NSString *text = [NSString stringWithFormat:@"%@,null,null,null,null,null,null",self.textField.text];
    NSString *token = [[MYUser defaultUser] token];
    NSString *uId = [[MYUser defaultUser] userId];
    NSDictionary *paramDic = @{@"token":token, @"method":@"getProjectList", @"page":@1, @"keyWord":uId, @"searchValue":text};
    [[BeeNet sharedInstance] requestWithType:Request_GET andUrl:@"getList" andParam:paramDic andHeader:nil andSuccess:^(id data) {
        // succ
        self.resultArr = data[@"data"];
        self.type = SearchTableTypeResult;
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0.f] withRowAnimation:UITableViewRowAnimationAutomatic];
    } andFailed:nil];
    return YES;
}


# pragma mark - <UITableViewDataSource>
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SearchTableCell *cell;
    if (self.type == SearchTableTypeHistory) {
        // history cell
        cell = [self.tableView dequeueReusableCellWithIdentifier:historyCellIdentifier];
        cell.text = self.recordsArr[indexPath.row];
    }else{
        cell = [tableView dequeueReusableCellWithIdentifier:resultCellIdentifier];
        cell.text = self.resultArr[indexPath.row][@"projectName"];
    }
    return cell;
}

// table cell number
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.type == SearchTableTypeHistory) {
        return self.recordsArr.count;
    }else{
        return self.resultArr.count;
    }
}

// section number
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


# pragma mark - <UITableViewDelegate>
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.type == SearchTableTypeHistory) {
        // history
        self.textField.text = self.recordsArr[indexPath.row];
        [self.textField becomeFirstResponder];
    }else{
        // results
        self.selectedProjectId = self.resultArr[indexPath.row][@"projectId"];
        [self performSegueWithIdentifier:segueIdentifier sender:self];
    }
}

// prepare 4 segue
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([[segue destinationViewController] isKindOfClass:[UINavigationController class]]){
        UINavigationController *naviVC = [segue destinationViewController];
        if ([[[naviVC viewControllers]firstObject] isKindOfClass:[ShopInfoTabVC class]]) {
            ShopInfoTabVC *vc = [[naviVC viewControllers]firstObject];
            vc.projectID = self.selectedProjectId;
            
        }
    }
}


# pragma mark - click button
// cancel btn
- (IBAction)clickCancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        //
    }];
}

// delete records btn
- (IBAction)clickDeleteRecordsBtn:(id)sender {
    self.recordsArr = nil;
    NSArray *arr = @[@"d"];
    [arr writeToFile:self.plistPath atomically:YES];
    [self.tableView reloadData];
}

// clear btn
-(BOOL)textFieldShouldClear:(UITextField *)textField{
    self.type = SearchTableTypeHistory;
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0.f] withRowAnimation:UITableViewRowAnimationAutomatic];
    return YES;
}



// default setting
- (void)viewDidLoad {
    [super viewDidLoad];
    // set table delegate
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    // set textfield delegate
    self.textField.delegate = self;
    // start editing
    [self.textField becomeFirstResponder];
    // hit test quit keyboard
    self.quitKeyboardView.textField = self.textField;
    // set default table type
    self.type = SearchTableTypeHistory;
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
