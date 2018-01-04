//
//  CommentTableViewController.m
//  MingYa
//
//  Created by 镓洲 王 on 10/19/17.
//  Copyright © 2017 镓洲 王. All rights reserved.
//

#import "CommentTableViewController.h"
#import "CommentTableViewCell.h"
#import "CommentStarsTableViewCell.h"
#import "BeeNet.h"
#import "MYUser.h"
#import "MYComment.h"


@interface CommentTableViewController ()
@property (weak, nonatomic) IBOutlet UIBarButtonItem *rePostBtn;

@property (nonatomic,strong) UIColor *barColor;

@property (nonatomic,strong) NSArray<MYComment *> *commentArr;
@property (nonatomic,assign) NSInteger starNum;

@end



@implementation CommentTableViewController
// set models
-(void)setProjectId:(NSString *)projectId{
    _projectId = projectId;
    // request
    // request
//    NSString *token = [[MYUser defaultUser] token];
//    NSString *userId = [[MYUser defaultUser] userId];
//    NSDictionary *paramDict = @{ @"token":token, @"method": @"getEvalForInline", @"page": @0, @"keyWord": userId, @"searchValue": projectId};
//    [[BeeNet sharedInstance] requestWithType:Request_GET andUrl:@"getList" andParam:paramDict andHeader:nil andSuccess:^(id data) {
//        // success
//        NSArray *tmpArr = data[@"data"];
//        if ([tmpArr count] != 0) {
//            NSDictionary *commentDict = tmpArr[0];
//            self.starNum = [commentDict[@"star"] intValue];
//            [self initCommentArrayWithDict:commentDict];
//            [self.tableView reloadData];
//        }else{
//            [SVProgressHUD showErrorWithStatus:@"未填写评价内容"];
//            [self fakeComment];
//        }
//    } andFailed:^(NSString *str) {
//        NSLog(@"%@",str);
//    }];
}

// set comments array
-(void)initCommentArrayWithDict:(NSDictionary *)dict{
    // NSNull 处理
    for (NSObject *obj in dict.allValues) {
        if ([obj isKindOfClass:[NSNull class]]) {
            [SVProgressHUD showErrorWithStatus:@"未填写评价内容"];
            [self fakeComment];
            return;
        }
    }
    // init elements
    NSMutableArray *tmpArr = [[NSMutableArray alloc] init];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    // add comments
    // 店主评价
    if (dict[@"timek"]) {
        MYComment *aComment = [[MYComment alloc] init];
        aComment.commentText = dict[@"evalk"];
        NSInteger timestamp = [dict[@"timek"] integerValue]/1000.f;
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:timestamp];
        aComment.time = [formatter stringFromDate:date];
        [tmpArr addObject:aComment];
    }
    // 客服评价
    if (dict[@"times"]) {
        MYComment *aComment = [[MYComment alloc] init];
        aComment.titleStr = @"客服评价回复";
        aComment.commentText = dict[@"evals"];
        NSInteger timestamp = [dict[@"evalb"] integerValue]/1000.f;
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:timestamp];
        aComment.time = [formatter stringFromDate:date];
        [tmpArr addObject:aComment];
    }
    // 品牌方评价
    if (dict[@"timeb"]) {
        
        // hide button
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] init];
        
        // show data
        MYComment *aComment = [[MYComment alloc] init];
        aComment.titleStr = @"品牌方评价回复";
        aComment.commentText = dict[@"evalb"];
        NSInteger timestamp = [dict[@"timeb"] integerValue]/1000.f;
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:timestamp];
        aComment.time = [formatter stringFromDate:date];
        [tmpArr addObject:aComment];
    }
    
    self.commentArr = [tmpArr copy];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *token = [[MYUser defaultUser] token];
    NSDictionary *paramDic = @{@"token":token , @"projectId":self.projectId, @"evaltype":[NSNumber numberWithInteger:self.role]};
    [[BeeNet sharedInstance] requestWithType:Request_GET andUrl:@"getEval" andParam:paramDic andHeader:nil andSuccess:^(id data) {
        // success
            NSArray *tmpArr = [data[@"data"] allObjects];
            if ([tmpArr count] != 0) {
                NSDictionary *commentDict = data[@"data"];
                self.starNum = [commentDict[@"star"] intValue];
                [self initCommentArrayWithDict:commentDict];
                [self.tableView reloadData];
            }else{
                [SVProgressHUD showErrorWithStatus:@"未填写评价内容"];
                [self fakeComment];
            }
    } andFailed:^(NSString *str) {
        NSLog(@"%@",str);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

// reset navi bar
-(void)viewWillDisappear:(BOOL)animated{
//    self.navigationController.navigationBar.barTintColor = self.barColor;
}

# pragma mark - cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    // identifier
    static NSString *starCell = @"star";
    static NSString *mainCommentCell = @"main";
    static NSString *subCommentCell = @"sub";
    
    NSInteger row = indexPath.row;
    if (row == 0) {
        // main
        CommentTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:mainCommentCell];
        cell.backgroundColor = [UIColor clearColor];
        cell.comment = self.commentArr[0];
        return cell;
    }else if (row == 1){
        // star
        CommentStarsTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:starCell];
        cell.star = self.starNum;
        cell.backgroundColor = [UIColor clearColor];
        return cell;
    }else{
        // sub
        CommentTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:subCommentCell];
        cell.backgroundColor = [UIColor clearColor];
        cell.comment = self.commentArr[indexPath.row-1];
        return cell;
    }
    
}

// height
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row = indexPath.row;
    switch (row) {
        case 0:
            return 159;
            break;
            
        case 1:
            return 60;
            
        default:
            return 147;
            break;
    }
}

// section number
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

// row number
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.commentArr.count + 1;
}


-(void)fakeComment{
    // A
    MYComment *aComment = [[MYComment alloc] init];
    aComment.commentText = @"未填写";
    aComment.time = @"未进行";
    aComment.titleStr = @"店主方评价回复";
    // B
    MYComment *bComment = [[MYComment alloc] init];
    bComment.commentText = @"未填写";
    bComment.time = @"未进行";
    bComment.titleStr = @"客服评价回复";
    // C
    MYComment *cComment = [[MYComment alloc] init];
    cComment.commentText = @"未填写";
    cComment.time = @"未进行";
    cComment.titleStr = @"品牌方评价回复";
    //
    self.commentArr = @[aComment, bComment, cComment];
    [self.tableView reloadData];
}

@end
