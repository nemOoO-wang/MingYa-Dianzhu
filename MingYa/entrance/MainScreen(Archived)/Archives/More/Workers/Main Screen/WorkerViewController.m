//
//  WorkerViewController.m
//  MingYa
//
//  Created by 镓洲 王 on 10/23/17.
//  Copyright © 2017 镓洲 王. All rights reserved.
//

#import "WorkerViewController.h"
/// frameworks
#import "MJRefresh.h"
/// models
#import "MYProject.h"
#import "MYUser.h"
#import "BeeNet.h"
/// views
#import "NMPikerView.h"
#import "WorkersTableCell.h"

/// definitions
#define NMCityPickerPriority    989
#define NMWorkerPickerPriority  991


@interface WorkerViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet NMRoundView *roundView;
@property (weak, nonatomic) IBOutlet WorkerPickerView *pickerView;
@property (weak, nonatomic) IBOutlet UITableView *tableVIew;
@property (weak, nonatomic) IBOutlet UIButton *cityBtn;
@property (weak, nonatomic) IBOutlet UIButton *workerTypeBtn;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftTableEqualConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *picker2BottomConstraint;

/// param
@property (nonatomic,strong) NSArray<MYProject *> *projectArr;
@property (nonatomic,strong) NSArray *workersArr;

@property (nonatomic,strong) NSString *selectedProjectId;
@property (nonatomic,strong) NSString *token;

@end


@implementation WorkerViewController
/// identifiers
static NSString *cityIden = @"city";
static NSString *workerIden = @"workerType";
static NSString *cellIden = @"cell";

# pragma mark - init projectArr
//-(void)setProjectArr:(NSArray *)projectArr{
//    NSMutableArray *tmpDataArr = [[NSMutableArray alloc] init];
//    for (NSDictionary *tmpDict in projectArr) {
//        MYProject *aProject = [MYProject projectWithDict:tmpDict];
//        [tmpDataArr addObject:aProject];
//    }
//    _projectArr = [tmpDataArr copy];
//}
# pragma mark - load data at background

// 请求省
-(void)loadStatesAtBackGround{
    
    // token
    NSString *token = [[MYUser defaultUser] token];
    
    // init operation queue1
    NSOperationQueue *queue1 = [[NSOperationQueue alloc] init];
    
    // Thread 1
    NSBlockOperation *operation1 = [NSBlockOperation blockOperationWithBlock:^{
        
        // param
        NSDictionary *paramDict = @{ @"token": token,
                                     @"method": @"getAllProvice", @"page": @0,
                                     @"keyWord": @"", @"searchValue": @""};
        // request provinces
        [[BeeNet sharedInstance] requestWithType:Request_GET andUrl:@"getList"
                                        andParam:paramDict andHeader:nil
                                      andSuccess:^(id data) {
                                          
                                          // province success
                                          self.pickerView.proArr = data[@"data"];
                                          
                                      } andFailed:nil];
        
    }];
    [queue1 addOperation:operation1];
    
}

// 请求工种
-(void)loadWorkerTypesAtBackGround{
    
    // token
    NSString *token = [[MYUser defaultUser] token];
    
    // init operation queue1
    NSOperationQueue *queue1 = [[NSOperationQueue alloc] init];
    
    // Thread 1
    NSBlockOperation *operation1 = [NSBlockOperation blockOperationWithBlock:^{
        
        // param
        NSDictionary *paramDict = @{ @"token": token,
                                     @"method": @"getAllWorkType", @"page": @0,
                                     @"keyWord": @"", @"searchValue": @""};
        // request provinces
        [[BeeNet sharedInstance] requestWithType:Request_GET andUrl:@"getList"
                                        andParam:paramDict andHeader:nil
                                      andSuccess:^(id data) {
                                          
                                          // province success
                                          self.pickerView.workerTypeArr = data[@"data"];
                                          
                                      } andFailed:nil];
        
    }];
    [queue1 addOperation:operation1];
    
}


# pragma mark - click picker btn
- (IBAction)clickPickBtn:(id)sender {
    UIButton *btn = (UIButton *)sender;
    
    switch (btn.tag) {
        case 1:
            self.cityBtn.selected = [self.pickerView.identifier isEqualToString:cityIden]? NO: YES;
            self.pickerView.tag = 1;
            [self.pickerView animateWithViewController:self TargetIdentifier:cityIden];
            self.workerTypeBtn.selected = NO;
            break;
            
        case 2:
            self.workerTypeBtn.selected = [self.pickerView.identifier isEqualToString:workerIden]? NO: YES;
            self.pickerView.tag = 2;
            [self.pickerView animateWithViewController:self TargetIdentifier:workerIden];
            self.cityBtn.selected = NO;
            break;
            
        default:
            break;
    }
    [self.pickerView layoutSubviews];
}

# pragma mark - table delegate
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WorkersTableCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIden];
    cell.dataDict = self.workersArr[indexPath.row];
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.workersArr.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

# pragma mark - picker delegate
-(void)changePickerLayoutAs:(NMWorkerPickerType)type{
    if (type == NMWorkerPickerTypeCity) {
        self.leftTableEqualConstraint.priority = NMCityPickerPriority;
    }else{
        self.leftTableEqualConstraint.priority = NMWorkerPickerPriority;
    }
}

# pragma mark - <MapPickerViewDelegate>
-(void)pickerView:(NMPikerView *)pickerView requestDict:(NSDictionary *)paramDict{
    if (self.cityBtn.selected) {
        [self.pickerView animateWithViewController:self TargetIdentifier:cityIden];
        self.cityBtn.selected = NO;
    }else{
        [self.pickerView animateWithViewController:self TargetIdentifier:workerIden];
        self.workerTypeBtn.selected = NO;
    }
    [[BeeNet sharedInstance] requestWithType:Request_GET andUrl:@"/getList" andParam:paramDict andHeader:nil andSuccess:^(id data) {
        // success
        self.workersArr = data[@"data"];
        [self.tableVIew reloadSections:[NSIndexSet indexSetWithIndex:0.f] withRowAnimation:UITableViewRowAnimationAutomatic];
    } andFailed:nil];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // set footer
    self.tableVIew.tableFooterView = [[UIView alloc] init];
    // set picker delegate
    self.pickerView.delegateController = self;
    // load provinces
    [self loadStatesAtBackGround];
    [self loadWorkerTypesAtBackGround];
}

-(void)viewDidAppear:(BOOL)animated{
    [self.roundView loadSubLayerWithController:self];
    [self.pickerView initFrameInSuperViewWithConstraint:self.picker2BottomConstraint showConstant:293];
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
