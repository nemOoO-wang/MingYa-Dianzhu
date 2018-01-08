//
//  UpNewCommentController.m
//  MingYa
//
//  Created by 镓洲 王 on 12/30/17.
//  Copyright © 2017 镓洲 王. All rights reserved.
//

#import "UpNewCommentController.h"
#import "CommentTableViewController.h"
#import "PickRoleViewController.h"
#import "MYUser.h"
#import "NMTextView.h"
#import "NMStarBtn.h"

@interface UpNewCommentController ()
@property (weak, nonatomic) IBOutlet NMTextView *commentTextVie;

@property (weak, nonatomic) IBOutlet NMStarBtn *starBtn;
@property (weak, nonatomic) IBOutlet NMStarBtn *starBtn2;
@property (weak, nonatomic) IBOutlet NMStarBtn *starBtn3;
@property (weak, nonatomic) IBOutlet NMStarBtn *starBtn4;
@property (weak, nonatomic) IBOutlet NMStarBtn *starBtn5;

@property (nonatomic,strong) NSArray *btnArr;
@property (nonatomic,assign) NSInteger starRaking;

@end

@implementation UpNewCommentController
- (IBAction)upLoadComment:(id)sender {
    NSString *token = [[MYUser defaultUser] token];
    NSString *projectId = [[MYUser defaultUser] projectId];
    NSDictionary *paramDic = @{@"token":token, @"projectId":projectId, @"evaltype":[NSNumber numberWithInteger:self.role], @"eval":self.commentTextVie.text, @"star":[NSNumber numberWithInteger:self.starRaking]};
    
    [[BeeNet sharedInstance] requestWithType:Request_POST andUrl:@"eval/keep" andParam:paramDic andHeader:nil andSuccess:^(id data) {
        // succes
        [SVProgressHUD showSuccessWithStatus:@"上传成功"];
        
        // 返回到看的界面
        NSMutableArray *conArr = [self.navigationController.viewControllers mutableCopy];
        // new con
        CommentTableViewController *newCon = [self.storyboard instantiateViewControllerWithIdentifier:@"CommentTable"];
        newCon.title = self.title;
        PickRoleViewController *pickCon = conArr[conArr.count-2];
        pickCon.tmpCommentTableVC = newCon;
        [conArr insertObject:newCon atIndex:conArr.count-1];
        [self.navigationController setViewControllers:[conArr copy]];
        [self.navigationController popViewControllerAnimated:YES];
        
    } andFailed:^(NSString *str) {
        NSLog(@"%@",str);
    }];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // init btn arr
    self.btnArr = @[self.starBtn, self.starBtn2, self.starBtn3, self.starBtn4, self.starBtn5];
    
    // init stars
    self.starRaking = 0;
    [self updateStars];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)clickStar:(id)sender {
    NSInteger raking = [(NMStarBtn *)sender tag];
    self.starRaking = raking;
    [self updateStars];
}

-(void)updateStars{
    for (NMStarBtn *aBtn in self.btnArr) {
        aBtn.raking = self.starRaking;
    }
    
}




@end
