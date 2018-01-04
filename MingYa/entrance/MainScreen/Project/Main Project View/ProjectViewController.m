//
//  ProjectViewController.m
//  MingYa
//
//  Created by 镓洲 王 on 10/19/17.
//  Copyright © 2017 镓洲 王. All rights reserved.
//

#import "ProjectViewController.h"
#import "ProjectTableCell.h"
#import "ShopInfoTabVC.h"
#import "MYUser.h"
#import "BeeNet.h"
#import "MYInfoProject.h"
#import <MJRefresh.h>


#define NMPickerShowConstant    100

@interface ProjectViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *showRightOnlyC;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *showRLTogether;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *showROnly;

// IBoutlet
@property (weak, nonatomic) IBOutlet ProjectPickerView *projectPickerView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *picker2BottomConstraint;
@property (weak, nonatomic) IBOutlet NMRoundView *roundView;
@property (weak, nonatomic) IBOutlet UIButton *cityBtn;
@property (weak, nonatomic) IBOutlet UIButton *brandBtn;
@property (weak, nonatomic) IBOutlet UIButton *progressBtn;

// datas
@property (nonatomic,strong) NSMutableArray<NSDictionary *> *projectArr;
@property (nonatomic,assign) NSInteger lastPage;
@property (nonatomic,strong) NSString *selectedProjectId;
@property (nonatomic,strong) NSMutableDictionary *paramDict;

@end


// picker iden
static NSString *cityIden = @"city";
static NSString *brandIden = @"brand";
static NSString *progressIden = @"progress";
// cell iden
static NSString *cellIdentifier = @"project";


@implementation ProjectViewController


# pragma mark - picker
- (IBAction)clickPickerBtn:(id)sender {
    UIButton *btn = (UIButton *)sender;
    [self setAllBtnDefault];
    switch (btn.tag) {
        case 1:
            self.cityBtn.selected = [self.projectPickerView.identifier isEqualToString:cityIden]? NO: YES;
            [self.projectPickerView animateWithViewController:self TargetIdentifier:cityIden];
            self.showRLTogether.priority = 900;
            self.showROnly.priority = 800;
            self.showRightOnlyC.priority = 800;
            break;
            
        case 2:
            self.brandBtn.selected = [self.projectPickerView.identifier isEqualToString:brandIden]? NO: YES;
            self.showRightOnlyC.priority = 900;
            self.showRLTogether.priority = 800;
            self.showROnly.priority = 800;
            [self.projectPickerView animateWithViewController:self TargetIdentifier:brandIden];
            break;
            
        case 3:
            self.progressBtn.selected = [self.projectPickerView.identifier isEqualToString:progressIden]? NO: YES;
            [self.projectPickerView animateWithViewController:self TargetIdentifier:progressIden];
            self.showROnly.priority = 900;
            self.showRightOnlyC.priority = 800;
            self.showRLTogether.priority = 800;
            break;
            
        default:
            NSLog(@"错误选项");
            break;
    }
    
}

-(void)setAllBtnDefault{
    self.cityBtn.selected = NO;
    self.brandBtn.selected = NO;
    self.progressBtn.selected = NO;
}

# pragma mark - set project array & reload
-(void)setProjectArr:(NSMutableArray<NSDictionary *> *)projectArr{
    _projectArr = projectArr;
    [self.tableView reloadData];
}


# pragma mark - select cell
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *sesgueIdentifier = @"check project";
    NSDictionary *project = self.projectArr[indexPath.row];
    self.selectedProjectId = project[@"projectId"];
    [self performSegueWithIdentifier:sesgueIdentifier sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([[segue destinationViewController] isKindOfClass:[UINavigationController class]]){
        UINavigationController *naviVC = [segue destinationViewController];
        if ([[[naviVC viewControllers]firstObject] isKindOfClass:[ShopInfoTabVC class]]) {
            ShopInfoTabVC *vc = [[naviVC viewControllers]firstObject];
            vc.projectID = self.selectedProjectId;
            
        }
    }
}

# pragma mark - tableview delegate
// cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ProjectTableCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    cell.infoProject = self.projectArr[indexPath.row];
    return cell;
}
// row number
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.projectArr.count;
}
// section number
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
// height
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}


# pragma mark - View Will Show
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // init pickerview
    [self.projectPickerView initFrameInSuperViewWithConstraint:self.picker2BottomConstraint showConstant:NMPickerShowConstant];
    self.projectPickerView.delegate = self;
    
    // MJRefresh footer
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        // 更新页数
//        self.lastPage += 1;
        [self requestMoreDataFromNet];
    }];
    
}

// will appear
-(void)viewWillAppear:(BOOL)animated{
    
    self.lastPage = 0;
    self.projectArr = [[NSMutableArray alloc] init];
    [self requestMoreDataFromNet];
    
    // background request picker datas
    [self loadBrandsAtBackGround];
    [self loadStatesAtBackGround];
}


// param dict
-(NSDictionary *)paramDict{
    if (!_paramDict) {
        // token
        NSString *token = [[MYUser defaultUser] token];
        NSString *userId = [[MYUser defaultUser] userId];
        // search value
        NSString *searchV = [NSString stringWithFormat:@"null,null,null,null,%@,null,null",userId];
        // page obj
        NSNumber *pageObj = [NSNumber numberWithInteger: ++self.lastPage];
        //param
        NSDictionary *tmpDict = @{@"token":token, @"method":@"getProjectList", @"page":pageObj,
                                  @"keyWord":@"", @"searchValue": searchV};
        _paramDict = [tmpDict mutableCopy];
    }else{
        _paramDict[@"page"] = [NSNumber numberWithInteger: ++self.lastPage];
    }
    return _paramDict;
}


// request more data from net
-(void)requestMoreDataFromNet{
    
    // request
    NSDictionary *paramDic = self.paramDict;
    [[BeeNet sharedInstance] requestWithType:Request_GET andUrl:@"/getList" andParam:paramDic andHeader:nil andSuccess:^(id data) {
        NSArray *tmpArr = data[@"data"];
        if ([tmpArr count] != 0) {
            
            NSArray<NSDictionary *> *tmpArr = data[@"data"];
            NSMutableArray *tmpMArr = [self.projectArr mutableCopy];
            [tmpMArr addObjectsFromArray:tmpArr];
            self.projectArr = [tmpMArr copy];
            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
            // end refresh
            [self.tableView.mj_footer endRefreshing];
        } else{
            // 没有更多数据了
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
    } andFailed:^(NSString *str) {
        NSLog(@"%@",str);
    }];
}


-(void)viewDidAppear:(BOOL)animated{
    // shadow
    [self.roundView loadSubLayerWithController:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



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
                                          self.projectPickerView.proArr = data[@"data"];
                                          
                                      } andFailed:^(NSString *str) {
                                          //
                                          NSLog(@"%@",str);
                                      }];
        
    }];
    [queue1 addOperation:operation1];
    
}

// 请求品牌
-(void)loadBrandsAtBackGround{
    
    // token
    NSString *token = [[MYUser defaultUser] token];
    
    // init operation queue2
    NSOperationQueue *queue2 = [[NSOperationQueue alloc] init];
    
    NSBlockOperation *operation2 = [NSBlockOperation blockOperationWithBlock:^{
        
        // param
        NSDictionary *paramDict = @{ @"token": token,
                                     @"method": @"getBrandListForSelect", @"page": @0,
                                     @"keyWord": @"", @"searchValue": @""};
        // request provinces
        [[BeeNet sharedInstance] requestWithType:Request_GET andUrl:@"getList"
                                        andParam:paramDict andHeader:nil
                                      andSuccess:^(id data) {
                                          
                                          // province success
                                          self.projectPickerView.brandArr = data[@"data"];
                                          
                                      } andFailed:^(NSString *str) {
                                          NSLog(@"%@",str);
                                      }];
    }];
    [queue2 addOperation:operation2];
}

# pragma mark - <ProjectPickerz>
-(void)projectPicker:(ProjectPickerView *)pickerView andParam:(NSDictionary *)paramDict{
    
    // pull back picker
    if (self.cityBtn.selected) {
        [self.projectPickerView animateWithViewController:self TargetIdentifier:cityIden];
    }else if(self.brandBtn.selected){
        [self.projectPickerView animateWithViewController:self TargetIdentifier:brandIden];
    }else{
        [self.projectPickerView animateWithViewController:self TargetIdentifier:progressIden];
    }
    [self setAllBtnDefault];
    
    // request
    [[BeeNet sharedInstance] requestWithType:Request_GET andUrl:@"/getList" andParam:paramDict andHeader:nil andSuccess:^(id data) {
        // success
        self.projectArr = data[@"data"];
        self.paramDict = [paramDict mutableCopy];
        self.lastPage = 1;
        [self.tableView.mj_footer resetNoMoreData];
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0.f] withRowAnimation:UITableViewRowAnimationAutomatic];
    } andFailed:^(NSString *str) {
        NSLog(@"%@",str);
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
