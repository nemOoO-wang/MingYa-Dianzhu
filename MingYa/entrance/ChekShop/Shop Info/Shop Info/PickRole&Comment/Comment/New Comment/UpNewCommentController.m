//
//  UpNewCommentController.m
//  MingYa
//
//  Created by 镓洲 王 on 12/30/17.
//  Copyright © 2017 镓洲 王. All rights reserved.
//

#import "UpNewCommentController.h"
#import "MYUser.h"
#import "NMTextView.h"

@interface UpNewCommentController ()
@property (weak, nonatomic) IBOutlet NMTextView *commentTextVie;

@end

@implementation UpNewCommentController
- (IBAction)upLoadComment:(id)sender {
    NSString *token = [[MYUser defaultUser] token];
    NSDictionary *paramDic = @{@"token":token, @"projectId":self.projectId, @"evaltype":[NSNumber numberWithInteger:self.role], @"eval":self.commentTextVie.text};
    
    [[BeeNet sharedInstance] requestWithType:Request_POST andUrl:@"eval/brand" andParam:paramDic andHeader:nil andSuccess:^(id data) {
        // succes
        [SVProgressHUD showSuccessWithStatus:@"上传成功"];
        [self dismissViewControllerAnimated:YES completion:^{}];
        
    } andFailed:^(NSString *str) {
        NSLog(@"%@",str);
    }];
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
