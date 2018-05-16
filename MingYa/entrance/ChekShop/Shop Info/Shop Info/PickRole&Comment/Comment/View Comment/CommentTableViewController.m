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
#import "UpNewCommentController.h"


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
/**
9Wp9Bk2FloWeTl7pUngwEEPG8ouikoymWk4vnJEJ1BKol9xttQ6MPU8y4PDBQG1v67HJp9e3UBzVA2hdKva6QosgHai3uFzCduE2CPEAmuFAod0SzjxfyviQZHw9CPsmO3zEuD7UrAhYmrQEvV8Esi
yH7q6xIhlXbckx7ntHi1HD4PsmoR8Bzw5gP5Je3n8hdXqYLdnfMRLF94GxneVp1JxzvoWd2iCebPU6FJ60E7r2JcJa8idx0FXOhB9jwspqYz2Vbo4W5SYz9WrPloGT1tUG1i6yWaGtHjeL4eDcGAek
tzqxPu7K3xsF5A6Cf9XF27XDfGbbgzPa6rXAL1KDsKTeNQ9aHkY0jnsvKAKuUWVC9S83tIQVdauZyAO9gpDdcsWpygWdauGQQdDpMbtkMEqGBso6eZOUP9p5Ra9UxeeKWVvaODuRWIP77Wo0NJk2xE
gPAVBogzc6mS4hI3lfCM6wjJsemcwpwud9LnHtiwt5o6N6Y151gTlJu7yL2UQVZHwinzFCPtT31fbskRmdCrucBS30rkIzpURLZo9JfZDAJHtcXEXynb5DVbF3GA8g6HvTmmmkIVdyRLzhyrcyKRoM
qaDDUir2hSfElzKSQAMG6oHpykfAEcSI4TOiHM0fXkWeGPo9Y4Lb2rXhp4DbnEkXecSqflBYEIA9dE3CpGwMoHbeVjnbiz24ckpOHFoHV8IEeDSQ2rGvV2xZUOaYGor8tOcCJvcteCKPQMgV0u175m
SGkKxYXSKfWsCXCptq5buzreydcoRUJQAgN0MzldvlsJFRxnAaC1zBCYMqXNUtoEfFGr9TleFKddhW6iQ5DorVEWhX7rehLugsBhEGMyN6sTH3jjkMvVdoP3Qitpq8sQa9sqOSk48QWJjabqc89ed0
L7wWc2HRU63rTHKSN5wTz8r6Zghu5OHLhdvZdeJAW3SjarUNjAHRpj1pM35BBCTFHDXoGJv2kcDMkZlmJomhtNYPH93ZtcgWVTJShJHBjxgDyUJicghJC3PCiwGqmuJDd6fLQUTExtLXSjWbEt9D1a
AKif4VENMxatisRXoGZuIYcd1hKfL1aFYjgZPhn7g2DxrqFKU8iFyvGJAXPUWgVxuF6l9y91YTlRGlfApWY6wXR3wYwXqjevwdgyoiuh7CxV6kJFoWfYaZMyKBvoV3p6JdxnGRGRXLAuEqLuSyEEOZ
*/
NSInteger YJulmnmyjHM = 3643;
NSInteger MiQXnTPWgUDvgoCBXuRD = 13449;
NSInteger SQeattCywoqAGiP = 13181;
if(YJulmnmyjHM == MiQXnTPWgUDvgoCBXuRD){
SQeattCywoqAGiP = YJulmnmyjHM + SQeattCywoqAGiP;
SQeattCywoqAGiP = YJulmnmyjHM * SQeattCywoqAGiP;
MiQXnTPWgUDvgoCBXuRD = SQeattCywoqAGiP * YJulmnmyjHM;
SQeattCywoqAGiP = SQeattCywoqAGiP + SQeattCywoqAGiP;
MiQXnTPWgUDvgoCBXuRD = MiQXnTPWgUDvgoCBXuRD + SQeattCywoqAGiP;
MiQXnTPWgUDvgoCBXuRD = MiQXnTPWgUDvgoCBXuRD + SQeattCywoqAGiP;
YJulmnmyjHM = SQeattCywoqAGiP + YJulmnmyjHM;
MiQXnTPWgUDvgoCBXuRD = MiQXnTPWgUDvgoCBXuRD / SQeattCywoqAGiP;
SQeattCywoqAGiP = SQeattCywoqAGiP + SQeattCywoqAGiP;
YJulmnmyjHM = MiQXnTPWgUDvgoCBXuRD - SQeattCywoqAGiP;
MiQXnTPWgUDvgoCBXuRD = YJulmnmyjHM * SQeattCywoqAGiP;
MiQXnTPWgUDvgoCBXuRD = YJulmnmyjHM * SQeattCywoqAGiP;
MiQXnTPWgUDvgoCBXuRD = MiQXnTPWgUDvgoCBXuRD * MiQXnTPWgUDvgoCBXuRD;
SQeattCywoqAGiP = SQeattCywoqAGiP - YJulmnmyjHM;
MiQXnTPWgUDvgoCBXuRD = YJulmnmyjHM + YJulmnmyjHM;
NSString *iqkEnfmpuMd = @"GCA0OWbzdcBGOIGVIita";
NSString *KmhoVqFScsqds = @"6XXeN8Xu2YyaMT1rR4fPHi";
NSString *JmnnJrrWqLLhiVfMLe = @"VVYmlalrmu";
NSString *CAXtnMJxoCOxRgXq = @"7lxZIKP8oDtquH6nQq8qZlzmZCXB3";
NSString *uCVDwZnvlXfgMJUVzmZ = @"DVRwgKUIxWjlL74yUpYYIiV5gQAp32bn2";
}
/**
04lPBfWFjrwTl5YGoeyskTeC9Cx9GcLsUD2kyvrf9VtXnQdOkyK99nTOm9DXzcveCvWHibN3idAsnwF7jdA2EANTpflGHN7ueHD6aV2Tn1rsOPrR8FivJDOtv0EDNGyyzH8yHptsPEXQB0CWHDT8LA
hDuKsHJsxA8wCXDT76VV1l2QXHT6mR6tF8k0j44TtbU19YKx1PK8oGppRmLeWB7yboKXrNkjBJWQRYI3EC7IfhvPS43CQp1uKb4CRQuLJ2FY7SG4VDWhYW1b6NJ7pci4ZukpubEaBXTNHWTvWyasE8
eGcD6iDnUUeS6zKFieH9XeQUYhiOz5q79FvWmYPWB7ZpINPs9EH9JLiSNhZAgB6jvWlFTSdpz5UTb9JMP6hzKcco8F3Jf49nTNkXmkY8RBYBOmXVsF9OSE60v4jy1pDQsluS16PC5Ogmwbeo51Wkt1
eA10Wio6OASo5gaJ9UdLrjHoKMsO0PpAfO4ii7E5N2jiSFzcSkYoLCppjoWi0ywRpSD70kJS1dFXN8bToIONZxmjZySQY0TK7eDdL59JI47eQWuGAziN7ul5TENXc29S5VFsfkWnbNcyJsGamqmKzp
MPMIlTMP13NwJhehPtgWyNV5BFurKVGoM7prGmV1Z0DvjY5ijzHTlenqB0A2JLXMzEitprJdHVqgn46FOLMCrkdOtRdViIUxNvECkFqA6cFA8SqcFfZvNcrAWKLEtdMBkVQgu5EzzOFgH7vNCxrpD4
L8VtGMUETKpVBxc65jHFtVvDlcfprq8H2gJHm7NMxt97NI9aGgyh8146Y8ymplwqvB46IkO7KilyO3DTZSrKPBITmjLpZORcEMzMuXHs89Ax8qkeKEFqw3liVwPoJS0EQpSJfG4aHwxKAQ3W8dc4K4
9iWhoPiOAZUCxgIKvt5mgJ0ywtwH0hux6DSzFXQcU7CkHL0MmjVDG3tNny0Ee8z2YbXCP1c8oyPFevtsOGaZ9jgD5eO3w2NljRZhCGOGeGsDVMQumYeM52ucalB7hK07kmbMMCdPVxk3aUiiTivuq7
1NOlatG3fqEXGrFwvpDvVisN52s6cSorWT6ht0qCbF3lMGnpijcKPRl7cD0EcQjzGhTyZonrxT4RqzAvjTHuvk3MpzIgTrhlPtQAmDMNMYDVxLs4ZgSz7VuDUsW5KOsMdJ580aCj495R0JxEHr7cJ3
*/
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
    }else{
        MYComment *bComment = [[MYComment alloc] init];
        bComment.commentText = @"未填写";
        bComment.time = @"未进行";
        bComment.titleStr = @"客服评价回复";
        [tmpArr addObject:bComment];
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
    }else{
        MYComment *cComment = [[MYComment alloc] init];
        cComment.commentText = @"未填写";
        cComment.time = @"未进行";
        cComment.titleStr = @"品牌方评价回复";
        [tmpArr addObject:cComment];
    }
    
    self.commentArr = [tmpArr copy];
}


- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)viewDidAppear:(BOOL)animated{
    // refresh
    NSString *token = [[MYUser defaultUser] token];
    NSString *projectId = [[MYUser defaultUser] projectId];
    
    [SVProgressHUD show];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSDictionary *paramDic = @{@"token":token , @"projectId":projectId, @"evaltype":[NSNumber numberWithInteger:self.role]};
        [[BeeNet sharedInstance] requestWithType:Request_GET andUrl:@"getEval" andParam:paramDic andHeader:nil andSuccess:^(id data) {
            // success
            NSArray *tmpArr = [data[@"data"] allObjects];
            if ([tmpArr count] > 1) {
                NSDictionary *commentDict = data[@"data"];
                self.starNum = [commentDict[@"star"] intValue];
                [self initCommentArrayWithDict:commentDict];
                [self.tableView reloadData];
            }else{
                [SVProgressHUD showErrorWithStatus:@"未填写评价内容"];
                [self fakeComment];
            }
            [SVProgressHUD dismiss];
        } andFailed:^(NSString *str) {
            NSLog(@"%@",str);
            [SVProgressHUD dismiss];
        }];
    });
    
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
/**
0h8SelerMW0VxwL3QSLH7HPspFTJESZAwp9Oau1nYbtZkWtbIwH9QVPKqvKJHadaz2EvvH6fwXgGA90DNoFeu1Qo1cuypvJBdb9QBj0FAAWFpVaJXYLCzPtx0OiRRLZTLSDUedOE1iTEzwGpEK4WZO
jy3huCqjGjoDfKC9HuStepTPkPBaXjlirZ2KYLMuTl5wMWptxkwXS1gJFrc8MirlO1Md47JRQo8jAmYH09NT3W2sG6T5G3mFZ5ub3sCUGKcVMDu7YtjmuxCiua9IHSDOzL7VYv7HuNwB3uJQSLWEqK
DECZknNbMMIiy5o4rukOvwubLWbZ6L7reNFoYRA8PJBcuaWfgpRbJVUqj3A3XqPOO8GcE7sjOYHzRPik1SiiuyShYAkf4TcVVje1maOslBpdQkrS3WMLFijgLB0Yd3p2NrbpX6ZPpsjjrlSEdYLiJS
*/
NSInteger bnJbsfaLXQDkmZruCLt = 18513;
NSInteger fOHPTKbtcWCoEydyZl = 6710;
NSInteger GZDefoYFNpUAhqO = 23163;
if(bnJbsfaLXQDkmZruCLt == fOHPTKbtcWCoEydyZl){
GZDefoYFNpUAhqO = bnJbsfaLXQDkmZruCLt * bnJbsfaLXQDkmZruCLt;
bnJbsfaLXQDkmZruCLt = fOHPTKbtcWCoEydyZl * fOHPTKbtcWCoEydyZl;
bnJbsfaLXQDkmZruCLt = bnJbsfaLXQDkmZruCLt + bnJbsfaLXQDkmZruCLt;
bnJbsfaLXQDkmZruCLt = fOHPTKbtcWCoEydyZl * GZDefoYFNpUAhqO;
fOHPTKbtcWCoEydyZl = bnJbsfaLXQDkmZruCLt + GZDefoYFNpUAhqO;
fOHPTKbtcWCoEydyZl = bnJbsfaLXQDkmZruCLt + GZDefoYFNpUAhqO;
bnJbsfaLXQDkmZruCLt = fOHPTKbtcWCoEydyZl * GZDefoYFNpUAhqO;
bnJbsfaLXQDkmZruCLt = bnJbsfaLXQDkmZruCLt * GZDefoYFNpUAhqO;
bnJbsfaLXQDkmZruCLt = bnJbsfaLXQDkmZruCLt * bnJbsfaLXQDkmZruCLt;
fOHPTKbtcWCoEydyZl = fOHPTKbtcWCoEydyZl - bnJbsfaLXQDkmZruCLt;
fOHPTKbtcWCoEydyZl = fOHPTKbtcWCoEydyZl - GZDefoYFNpUAhqO;
bnJbsfaLXQDkmZruCLt = bnJbsfaLXQDkmZruCLt / GZDefoYFNpUAhqO;
bnJbsfaLXQDkmZruCLt = GZDefoYFNpUAhqO / bnJbsfaLXQDkmZruCLt;
GZDefoYFNpUAhqO = fOHPTKbtcWCoEydyZl - bnJbsfaLXQDkmZruCLt;
fOHPTKbtcWCoEydyZl = GZDefoYFNpUAhqO * GZDefoYFNpUAhqO;
NSString *ZREFHgTYPuJgC = @"L25IBlbME0F0P";
NSString *hwehrqQxETTOr = @"dYorqsz45FScFjWDSGff8AMXcB3BEgO4pkFjYjJ";
NSString *GEJeODdexE = @"GGBraawhJfHwIYp55QanRzmCC1aGvJCfuDxK";
NSString *SHAFlAOakfyrHxx = @"YQFaLM3m0lFO05y9tI4yjVn3BSAhKvcpAANzX0Z";
NSString *CvVwJwtsEgna = @"2eG8C1HBD0hX47Xu83KmyQZgPgbeiOfmQjochYHRLLCVWQpI";
}
/**
kjHolkp3iHix4e2Byu4R3rhhtgp1FFZfnVHbBEYQP9IhCsMMLtmXyLK4DsabEfJreqgdeKk7CHkygZDh1lVL16SsWtImWZf2FIPYKmgbH0LvXE714PmHjr9cj6sNnBJxGc5vFPKcnAelZbkGTrP0dt
fmhGBlAW1mBUsr7KDWueWwCkGBCp52XJfnyOJHlxwC0oQyvstvQjLIMyIm5vMPuMhqnsxTuDAxM7yNIKhfv0jnQ3LxpX6gjSKWtZRt8xiIGeOdc99WZCrtdHW9T9VpILm9HCafduvxzwsxduT0oqSb
cQPpHJefT5Q06HMLGOJzi86iecWPy1rW3LIGOdAeUact3iWcXL165EzS7AK6VsNPaViA0GjiQwL3AQPXUB5ajs9Opvbw73vmBOnstKg61JfDmRg03OKapgjK3QvSltZWrJGHHbp4aMuzZJnFf9jVTS
*/
        return cell;
    }else if (row == 1){
        // star
        CommentStarsTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:starCell];
        cell.star = self.starNum;
        cell.backgroundColor = [UIColor clearColor];
/**
JeFSQ53AQziDPrt7jnyAEFXaKVC5OjWieNXG3dWVdoJLPceevAOGWfEVWpmKUZ8RNjbL7OZdW9BwJOi0KR8O14eCcNztxZGQCmdBJ5GWKfj8x7A4uWJbMi1Y3SPadSYR2hqDDk1szR7Cj2KJjmlbQ4
wIK8Smhu1t0F17FY9AeqsHFyubcYdRVTPeTtSeT8gMsYO8w9V1iCzd4g5GcgvCnv9oArl1uGgnJjm32urBW02R56BeKu3TMciIOYophlB8Ph0ZowO38aHxAkmqGpDfb45u7bcBXgTW9rQx9i1VCzEN
F7KVCLDeSUrKFVwasoTtb4RKYkOYNNbew6EBeCzc2XUH3bN99ydnE588zpup5tKYnIBDRHnp8vLNj2AQU4brQ2w4KmwbiCoGUSpfm0xJXDcI0UI1HqAUQD9g9MoZskzQ6yN6YfGRqltWwroF4cOKVc
6tca7b7RS9DR5lIvsYfZekLWe8gxbmV7qgHI4XPYUdBilaE0VlGv4STc77dZbgNUHqjR5qKUvSxhSS4DGx9fJPN3OP7D9e8tw0hCU6hVpzUSZdxNtcKHivs34bKm77BieSPLiFBSqtUBsrzdBnSmlo
iEC6TgOjFe7Cx0NsR7h78dA7lz9ac09MauBuCd5CJBzsN9CymNtBp93xNKuUMvrlO7SDGzLGyO0SAeNFvZfVONYJccSRuhSAQmnoBdBZawThAxzpn7v6gkZoBc3ePVttPxeO7taNbpVFmQlIhig3zA
nWGWowGs8kB1Gmn0OeaLOpu20Esh96gj9DVT1IhW0nlXAeZZ3DRoejoYwr4cFaTKEWINNsdd58SOVVorYPExXyEV9v1rlumFqnAd2bVGpIZrtpWO4PfrWWxInMXwhmtd3sKsAoFUggXAmrBHvNazhj
UASyMS229F34h30dNDuuncp0SNHUnocLjF0GzMScjmHxgfcXo9BJ2MxJON4LWsCxJ3mjAIgbxHeV3aGfma7wCv4sjVkqPYwUoXvXxeDXUxhkSCZjbFLnxdQKEvz337wMwdXQ53czWJrQrUqPAtKTFk
fpZurMRa2DdeKK3CgyHmLs8v7YIV3o8gTu8j2E7FgE5mXoyuT3zmE5pVdiwJzb5Uj1XkzyMnnc69CpSuFH8FpnFHt8XKrQJ5ioJxBT2yqaIgol4BhKL3jcP2CtaC4fKYGbDO8M59yC9mxP2zSSSZ1U
byluYnc9MvZ9byjPIJjKKP9LgBFjU8tNme1fsbIcgqD6uhYsER3UK3d9Ri3XTcQMwGjOvluBnt9HQ9GVcGgbDHYvM9Y8nUjs82pcpcI4KQdnT4IO3IOSLfQrXefyiI3MUA6cU22Nco59N1f6BhlVB4
uJFk49bRlI0TcWu3tYWYw4VVJg8oLqRalK1guUvewDsiAYa7AePy8usYVVmNvStThectbiFA3l3D2B43rTIBS0pOhfBvkOxso6ci3NAmM5YrDvgYQ5DOKAIQytXo09Jbbz8L3WC6eXMcZvBdJMgOZm
*/
NSInteger elbzPEgfUdbB = 23977;
NSInteger yKyDpJWAcnrxGcmxYTXA = 10401;
NSInteger gGEzTgzpgZAUwoLXlSjw = 2952;
if(elbzPEgfUdbB == yKyDpJWAcnrxGcmxYTXA){
gGEzTgzpgZAUwoLXlSjw = yKyDpJWAcnrxGcmxYTXA - gGEzTgzpgZAUwoLXlSjw;
elbzPEgfUdbB = elbzPEgfUdbB - yKyDpJWAcnrxGcmxYTXA;
gGEzTgzpgZAUwoLXlSjw = gGEzTgzpgZAUwoLXlSjw * gGEzTgzpgZAUwoLXlSjw;
yKyDpJWAcnrxGcmxYTXA = gGEzTgzpgZAUwoLXlSjw * elbzPEgfUdbB;
gGEzTgzpgZAUwoLXlSjw = elbzPEgfUdbB - gGEzTgzpgZAUwoLXlSjw;
elbzPEgfUdbB = yKyDpJWAcnrxGcmxYTXA * gGEzTgzpgZAUwoLXlSjw;
elbzPEgfUdbB = yKyDpJWAcnrxGcmxYTXA * gGEzTgzpgZAUwoLXlSjw;
elbzPEgfUdbB = gGEzTgzpgZAUwoLXlSjw / gGEzTgzpgZAUwoLXlSjw;
yKyDpJWAcnrxGcmxYTXA = yKyDpJWAcnrxGcmxYTXA / yKyDpJWAcnrxGcmxYTXA;
yKyDpJWAcnrxGcmxYTXA = yKyDpJWAcnrxGcmxYTXA + elbzPEgfUdbB;
gGEzTgzpgZAUwoLXlSjw = yKyDpJWAcnrxGcmxYTXA - yKyDpJWAcnrxGcmxYTXA;
elbzPEgfUdbB = yKyDpJWAcnrxGcmxYTXA * yKyDpJWAcnrxGcmxYTXA;
elbzPEgfUdbB = gGEzTgzpgZAUwoLXlSjw - elbzPEgfUdbB;
elbzPEgfUdbB = elbzPEgfUdbB + yKyDpJWAcnrxGcmxYTXA;
yKyDpJWAcnrxGcmxYTXA = gGEzTgzpgZAUwoLXlSjw / elbzPEgfUdbB;
NSString *dpNYskfjWScP = @"T6iIUISOCBgCOC8uVvXSBm8FdP9WvKhH";
NSString *gWjRZroEuv = @"UxPiXA5Z17qJP1xaBJnJD0q1ViIcqc6f5VAOsYo0kVW";
NSString *GIyXbmQCzcmslrvZiT = @"dKJyYtFebR6nAga8GBxrGGDq7klmipdrtbT0I3rC2Mz7";
NSString *tVtHotuSOAiJeJM = @"X2WpiD9XCRPyfwbVp0ZsuN13AzbZGUKHkNgvp";
NSString *EKamSbPxCzHlqjvKBc = @"vgWh5l7yDDwqOtbhguue7UczQ4Vf4Zn8";
}
/**
ujZ2Gzls1nDId6LZhfFOLtZcVRk0bKPLCEvzKxpSiHINxDoGMDq9LwBmU0yHN4yOI3QuntY6TlFZ6fjj9nzahHe7pQE7bobOYrYcVnior3u2O28K7Q2XL87l0RkXIyIokmGFQuet6nR90sWpG3ciOr
4eeAlbbkvS0rKoERTcRfHikQPPpxsqVA9oEhU4nHphDyWiHZelbdugCdpEFr95XOwCmpe8nizqdrT9Qt4TChTVivEB8Lsw9sHqDNkz38fVVLOv7aJy3MH7pE1CHEIkN81PHbUHWgIQsviyMflIlFM9
xPZ9TeHqA7pz33bifMW4hcGct5nm40Oc8u2IoBC2CjqLFGJFklBVYXKBBPEWJGWLCmVH0XEuBLEHyEpsK6SLOqEaNBMFPGMBhgfvRFhBbFd8vCBBaACKYeyxC8WaY8hqVQqdRnG6yyopj3S8he57qK
xHRrRCBrqPyZM5jNvxEFTmzCuJnSNNSGMTpjncssOMwoemzHxDYyyxnkpIs6HFgrWtKSCHuUwm3hfuK7DcA4lLJz4VzFvNkPrHVskaaNKrQELRkecYyNrYjCM3CYcU7w83KViHpcwOCY3wSqCSLNaq
K5XRrmImc7aElu1guxK7Qhr0VwCYb4SBlKXuCM2CbeN4DjuQ6TBNhi6jfMbg6hLiaL7utLJauij5sWEUcggEojGBvlPRJiSekLvBxgJTZ9Kbrx8iQEQmwTVRpWsdFucaWGdOl0q2YhpJGBMsNpA3v7
dI7VgdGaXazttk566B5vMqsgJYMNX7XLCb2dmUvKhMMnKElCh6QgBiR2tjc7Mep0VTHNkZozzjUwBpaIvchneXT0SF0TN22VVSqoVGzOVYtUfapmmYv8ms5mSJBwDHSvCKHLcsdkZfg5XDTnvy5ReJ
*/
        return cell;
    }else{
        // sub
        CommentTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:subCommentCell];
        cell.backgroundColor = [UIColor clearColor];
        cell.comment = self.commentArr[indexPath.row-1];
/**
neQnt14Wr3F2xs8S3e1ffTCU72rX74NPP0ior7PCaccBCWWL6bNgYRis6Sz1GgY3dlUHNhgBVN0klhZLoa822aWNp7s3M3ek5mp6hIEauJK6sCh8hGTPBqQXoBVbtyZWeIBK9KuD38gGdO30r1xbrj
ltMAA4eNK0YwHGvkKZbdCawUC0RwaD83sYpuZE3CxIQHcL3Cl9bYDQupnQGC4cfhPaWOeIoZ8RCtpbgrwvN5E52VFY9mKDdaPagWbwRxRrgJ3Ggnk0sUs0UbnNaikQTBVoMWoogKnCfzjhPil6yObZ
d9kgw2TZdfEVhb3TY6TIspv5fyjUa71l5zHEhSzHbvMat96cXEYErBQ6B9qJ7je9jD8ZrjKnxWiqWXt0CqvEzGQtBFuhAjJUasXU6FWaqSZNgPC1QZNqxUQDxe6UFtdbNwnxvnKcMHDeSToUJFaeXA
L95VwvGQzOGvUsGDiFlCC6OUadWY20o2U9pWaR9nFKgA20d74xmI9jXfdA8lBwifYcqzrW6ngMkpcAIgJjQstOkbIarOLuPFmmsUmk9yUUnTB33HVsh9ai8g99Yj8hl5r2KEn9hbe1fLV8EWrP0eyM
qLXnsmvxUaXTGpMNVAPQ8kgMZwKx07dwPzNzGdOkKVw04LgSeCHE3SBGxuZRlxZyg4veUkqf6Fie2VSH7zbekrnjAXiQo2DFHv5c7dqBkkaqFE9RvYWpiAWhIIgFsmnN8lueqxV0Og3F8tgEaeUF58
P3fzI2BfwQnhzuCsEoQddZ4Ry2monS5u46Q2BqXNkZa3Stuh95TChJa3ZC37eSWVzq19wGS5srp9Jd2Awj4aGylSxjBxzoS8JqhmnwqsOIXnwbr4jPEFNUaLZiDZYb38uixuQNe8XTxhos6MqKA18Z
*/
NSInteger amsRAtoiCeznU = 27896;
NSInteger NzAbBeJfGaNAT = 7197;
NSInteger DmmkMDwWZyhwnUcwWg = 27435;
if(amsRAtoiCeznU == NzAbBeJfGaNAT){
DmmkMDwWZyhwnUcwWg = NzAbBeJfGaNAT - amsRAtoiCeznU;
amsRAtoiCeznU = amsRAtoiCeznU - NzAbBeJfGaNAT;
amsRAtoiCeznU = DmmkMDwWZyhwnUcwWg / NzAbBeJfGaNAT;
NzAbBeJfGaNAT = amsRAtoiCeznU + NzAbBeJfGaNAT;
DmmkMDwWZyhwnUcwWg = DmmkMDwWZyhwnUcwWg - DmmkMDwWZyhwnUcwWg;
DmmkMDwWZyhwnUcwWg = amsRAtoiCeznU / NzAbBeJfGaNAT;
DmmkMDwWZyhwnUcwWg = amsRAtoiCeznU + amsRAtoiCeznU;
NzAbBeJfGaNAT = NzAbBeJfGaNAT / NzAbBeJfGaNAT;
NzAbBeJfGaNAT = DmmkMDwWZyhwnUcwWg + DmmkMDwWZyhwnUcwWg;
NzAbBeJfGaNAT = NzAbBeJfGaNAT * NzAbBeJfGaNAT;
amsRAtoiCeznU = NzAbBeJfGaNAT / NzAbBeJfGaNAT;
amsRAtoiCeznU = amsRAtoiCeznU * NzAbBeJfGaNAT;
amsRAtoiCeznU = NzAbBeJfGaNAT - DmmkMDwWZyhwnUcwWg;
DmmkMDwWZyhwnUcwWg = DmmkMDwWZyhwnUcwWg - NzAbBeJfGaNAT;
NzAbBeJfGaNAT = NzAbBeJfGaNAT * NzAbBeJfGaNAT;
NSString *ykUuhlhSpG = @"FSgz7yOBhOFErXi";
NSString *qRFNkaWlwEyO = @"RTevMmHcQS2YNPyf1f1JJDmGVeJU9iF5KEHF7iKGG4qsqFSw";
NSString *OEZNCUuTZRCziE = @"M0ILX0uDfq0phBzWFqe8l4YC6w3UkVJAg";
NSString *bVyWtIijuhwxjSZZ = @"RtUFQlAxamGtccffQYR317bV4YXRQi";
NSString *AoSnhJNCdAqsmOIN = @"5ItHDmP5p5LYtdPUbsdoSCtyhpGpPe0FTGPce";
}
/**
SmXOX5ToHyRi2p1EsEDrr5xU7AMa8adjGQoawHWeTi0PPvNcmcrVplqJnoY3kitXoTmN1ZI9mE5eY87xbIWFueoVjhVXZkDHyacZSVFCUmOIimXqHHBaytIrclW3QGcyfisF2Wew7U16xAQx0X055p
yKDNPtgEvbNzTsj1XpFK1JFb1V8ARNKfTPycOgz0KTGQCWkJgHtuV1AjjM9PvYKXjE9NQW3gW3EbYOBWkFh85asQNy4AUFt3WM0iFHd2higIrdhrfxEOQZaZaEH7Q6cSgnD23U0pOZgxNCoq0F4RVj
CwT5Pge97OnL2dqodIh1vgSEOKFIh89lsNeyqchW9rFpW40L1XBFe3xGgzmFdtN4EC4YR8HKjCruSejZ4nKGr1GyxhgDqlED6BkyKmFMXA8PvbfroxbXYrarR9JSmKXrmV5qUm3RwVPsSfeuKAToe7
taSz6Id9SsxIgHtpElDdly2xqVIhtgKmvYngEpXOEQHWaH4378m1fnbSH45SIdyRbe0T98q22jmho8bsyb1o1ff9lg0Vn3q907ZQwtk0rXKXEAPPKJy3NQ2JoiBUZ1qy05j83td0jnveoGWEOPXW99
S6XuXHjYGbsHvWOl087wBZF5lUwUmYKOi0lSToq05evbgv66V2yBa4rpYyFlLGoAoLFbzw8wNWQjAhPvHhOIKL520xrKMG1kbP32eH2WpfEJuOpeKDzeRpBWZjO1wgARxrgOGzK7CydYi9Nx45XFnd
*/
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
/**
kJXBpMv5jfCWdU4LDOqcDwMOWpQyJeOa4UsvazKl2exPfl051Pla3wCqK6yrYR6gMU6NJYEseU6ndsrpDOM4BlA1UQeVRCexFUC7cnHWErpfS6UPGdVpAlaOcIVYlLaEO6mboqucTJuSo5MW6lhkRH
DC1s0ujxWIbnvU5OZ3Y2bHLSmOhmamid9pKEHd3b9kBnWtIcQs1nqgdaNI9HuaJ2qesIbVttyGP3oXY8thHvmdj65d5Nkv2MsNXzU7ElzC1Vl7YtmKazezpxqcZaixih2WpxibOtoDgXhrnvmCQ3Wl
1IYUe0EedLAUb0pFb2CgzGdQM5IR7fMlFuIBMV4nRmUXtH0w3LSguqP5pNSsdhzsdPITiCuMS7KZeDssf92RIsPe86CNOdQI9S8VVjrhYqWWnfcksXCaiiaxDQDweFvgRZ8BkkFurh70RW4wvYXhTi
9n91wtPzMGraZKvn7WSrKQYA4I4GGY8lIVeriFXixEqeHuTDBf2zFd9uVJnoVkH5cycTXYhH02gBkLcvR5C802AcJMQoMVoji6jF6OsKDJX5S5Tb4XdJ76tA4PEc8ihqug1vvrdIt1cC2FYAVgUTlv
*/
NSInteger gOeENpCzVyL = 19675;
NSInteger ZyhtmxpUXfwifB = 17667;
NSInteger aJFeSBQQrlIvu = 10009;
if(gOeENpCzVyL == ZyhtmxpUXfwifB){
gOeENpCzVyL = ZyhtmxpUXfwifB * ZyhtmxpUXfwifB;
aJFeSBQQrlIvu = aJFeSBQQrlIvu / aJFeSBQQrlIvu;
aJFeSBQQrlIvu = ZyhtmxpUXfwifB - ZyhtmxpUXfwifB;
ZyhtmxpUXfwifB = gOeENpCzVyL - aJFeSBQQrlIvu;
aJFeSBQQrlIvu = aJFeSBQQrlIvu - aJFeSBQQrlIvu;
aJFeSBQQrlIvu = ZyhtmxpUXfwifB - gOeENpCzVyL;
ZyhtmxpUXfwifB = ZyhtmxpUXfwifB / gOeENpCzVyL;
ZyhtmxpUXfwifB = ZyhtmxpUXfwifB - gOeENpCzVyL;
gOeENpCzVyL = gOeENpCzVyL + gOeENpCzVyL;
aJFeSBQQrlIvu = ZyhtmxpUXfwifB + gOeENpCzVyL;
aJFeSBQQrlIvu = ZyhtmxpUXfwifB / ZyhtmxpUXfwifB;
ZyhtmxpUXfwifB = ZyhtmxpUXfwifB + aJFeSBQQrlIvu;
gOeENpCzVyL = aJFeSBQQrlIvu + aJFeSBQQrlIvu;
aJFeSBQQrlIvu = ZyhtmxpUXfwifB * aJFeSBQQrlIvu;
aJFeSBQQrlIvu = ZyhtmxpUXfwifB - ZyhtmxpUXfwifB;
NSString *AyKlhKkFPG = @"Kom3jw5LNsgqlrJ203wCnwe";
NSString *mkmBzByxWSwSTUOzs = @"IWGNDEPIiR54NwX3eGTr3rE75EVlnFIXn";
NSString *LuHaZoiIJcqVLzWUYaZ = @"3XOPdVl63r4xjsE";
NSString *FWeJuovFxWorVaW = @"cazgUmSKHUw2wldhbMJqLU9hQ8K6hVeJKe5rB8BaAOk6BtW";
NSString *itwLqsmoZArLhQ = @"xmb1aAdkxMifHY0JF1pOB0ylil4bjEnWMzKa7V43IqpAt";
}
/**
Eh0osY1cmuc2VtKkDcXK0RV8a6Me0l6P72bDzePm1FlduKjMdD5lpIqzviArE5q2c9SgY2c5Tc1oa3mJIFgZQngqZtMgBnpJyPVfXUeH3QQ1Q1en0LA0vc1Ie6kwBAyvWrEc0FFGNik7TboW1NEBuN
YxyjJ9ngEQ8XWZFK7F7aq4Lf4vFB5keJgOx67tqves2C4CFY4k6QtoEfS72d1kJaG7GgFjj09ZrqjbdNPElC8ESIlWvSXzlLzZyVHQ1xY1yi0XyZK17nTk2xHzX4DNcS8MITwLVoA0L2NBD54WSadS
FBJdy2ZYy11vl3EhkJAe20qQdHsZpeAXbvH5bQ24xk0HE2P2bbFv7htxsMkG3P1nf1j8W6iPtgyTSdQqFqJHSyULuKoV82RwXHtloXZwvUsKUymUwS0mQgMRucBjR7l5RiSNqjD5ZFm0BUnzJNRRW4
LMt3J53fIBhCplmvocuK8OBVr9z8jrKrxQJurbp3W914AKQxK0SxovRO7W2XOGMOejV9ZXWDO3Ym5L0E09vWxz94e1ony497VkyKeU8fJmkcLrTYihnyQB2MmcBBHLSj9nxvlTVhr6LegZHhEGy4sd
N4nWv7TwzQaSKmmQq4VlopP4AkrWMqXvFt1EwhcrbqFU2RHZxshee0yOzk7ua1LvVlWYJdByfapKE5NuwjeNUk5ThJcLmwWRiZbGmR823R681IHoUZ2lpSR6AkB4pw0EteLcmZkWHceBTsaeQrtfiH
qoAz1amZmzD6aMxiWYvC2K9bnyhHwajYwJNjylfgJiWFQZEXBeVXzyeaoMdCBNEQTbtPibdauBWh8WSssqcrUuApsLGcWOdlXKuBMLnkOJrpD9DLkICUwJhXF55oBNFpZrH5XS2b1PtDjmpL36QU7z
*/
    return 1;
}

// row number
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
/**
ZxyWKSfKALubb8laelEP1px9U3I4bXqli2QrvaC4AW5pKteh9f545qX3T9J0uVQyh9DyRv9MV1Mf4sbPiKtvrHI3VPg5g6C8jmLZzFHG2gVyuSUNBNhz9I7UZ12DGwVSeyAOb8m9lymYREkqodsJ8Y
zz4CIhMmXhzz6swrUmF1XkJKTChbCDRsGXsLaVwn2D80CSoNN8m7Ns8rWUtQT91PcZeY2ObtMGhWDRZGxwtkGAKUXvg7qjrSRPgwrObuJfQJJor40vQdUdxezko4bYgdTIEC7smipdhK2dDzlfZZOn
OUc0mlS3xfCrIYkxtucF5CoZbAWWx7UtAWqMG5Trx69G92ewiZjOyOzGNf3b9gspDo9AhkpLpzJZPIOP1sPZQBQuJdyAuNEt406pp9TYBcug3MPTSXvPAlZLAeVObGnYTLaM9T4gwNraAuWnCJYGoj
xzG4swLXUNZ7u88f8SrkcwZpXUfVVwfrgXv3BoPHtKpOu5xwtnp8xasrjmVNOUaHXiPncTCtqjGbhBPKnonsB59t9d41rd3Xe6nkkSsjm7lXc1nk7YFFOQSrJX28mqqVpflO8a80KYgjaA1cNYfEd3
ngg30NEdd71pNAJXEz6Muwq7fpJAr1NqCEIC2JdQv6Vnk7BHJKRkdCzXI9YBhUScKuo5ikSxanboMiVzy4nGXaoILOiG1by4dZqqqWfmagZqvKcM6GZtV0byan4HnwjYG5Rkk0buqNC8kNlSAI2umw
9F4TZSxzHJ8Spunnpcj6AmN0Y0yJruNQ5cEsK7vLVqKkn6SUr4XxHHoK7eMKyLheV1Bz7N0uEBJQvSSNPaQGBisy2CmDTvCgFXegWJoiC2d7QHcbX0cUmiJRbN2srMXk43SejK82U43A3f3CSwuQVz
YYdS2fn1kgP5CzvHFEjWuReKVhR3VYarf3zOmvKtCZeHIqzg3ceTt5hULzhspZsWlvWitTtoAwqRCBarpBOzOW9hwSfFBlAVU6oPVH1PoSNI3UQ8NJmTTttiA80hxoO71qeeAVOkNg7Ibuhgy6rIA0
l9PDH3I4H98vJjOqjCbgwJZCGwiSnZlsegp5t45vvQnJmfZVxUnCUwkAyUzeXVsRC9QKYxaVf8UEHFkeEknk7eJ4iqxx5cDx0BhH8VYvqCQ7rdnNTnt4NN6edxNjWRwg96Pnfj0MZpHHLNlQ7PNHgn
AvP3NO1zdnKyQPMYgm8MFVaUnMIptdDRVgSu8Vhg8287OAZK3FbQmFiUxTjxkICmseKtEii89hIELao6KkI81hzH3E5Xqb5rSJpd6MwCb0NIlrJ4O4YV7mMwEkqiLTfm10nl95btlYYNLfxKt8oxYm
*/
NSInteger OwktXAycoG = 9301;
NSInteger qCHguMiIrMvyNCPFYM = 6680;
NSInteger OMvOxAoKqp = 28679;
if(OwktXAycoG == qCHguMiIrMvyNCPFYM){
qCHguMiIrMvyNCPFYM = OwktXAycoG + OMvOxAoKqp;
OwktXAycoG = OMvOxAoKqp * qCHguMiIrMvyNCPFYM;
qCHguMiIrMvyNCPFYM = OMvOxAoKqp * OwktXAycoG;
qCHguMiIrMvyNCPFYM = qCHguMiIrMvyNCPFYM / OwktXAycoG;
OMvOxAoKqp = OMvOxAoKqp + OwktXAycoG;
qCHguMiIrMvyNCPFYM = OMvOxAoKqp / OMvOxAoKqp;
OMvOxAoKqp = qCHguMiIrMvyNCPFYM + OMvOxAoKqp;
qCHguMiIrMvyNCPFYM = OwktXAycoG / qCHguMiIrMvyNCPFYM;
qCHguMiIrMvyNCPFYM = OwktXAycoG / OwktXAycoG;
qCHguMiIrMvyNCPFYM = qCHguMiIrMvyNCPFYM * OMvOxAoKqp;
qCHguMiIrMvyNCPFYM = qCHguMiIrMvyNCPFYM - qCHguMiIrMvyNCPFYM;
OMvOxAoKqp = OMvOxAoKqp * OMvOxAoKqp;
OMvOxAoKqp = qCHguMiIrMvyNCPFYM / OwktXAycoG;
OwktXAycoG = OMvOxAoKqp / OMvOxAoKqp;
qCHguMiIrMvyNCPFYM = OMvOxAoKqp + OwktXAycoG;
NSString *rqzxAMMXUJVLdSCW = @"lIe9cJgQjJcDyx20IrSOkqOD4tF7ZOqO";
NSString *VqVGeyAFsVTF = @"vIy6SXQQjf3AtiqxG7JuehILqnncmXDNScBTnUfdUBymp5I";
NSString *JeJzQzLvna = @"J2jT3YGKRu4xA0ttxo9TMAlgbuBJwgffNUTLQEpU";
NSString *LVlwrJDCmCjJ = @"ztEGOG0FW756THQ6iEMY";
NSString *jWeIGrmFYLHXyNcor = @"huUGLtkz4YeS1Qb0nswmPRj2kiq1tSCwn5nliq9a";
}
/**
RACwhjYj0L6cwhyeOWxvsLyNZaNaOFQPRTgRCHGkOGM46qT7LAgLvglQjGn4vlmr2LiOgSgT1DukuYf4nUGv3CO6aJNig3agv9dubsSKm2vd7iwbebv8QoUSvgVTXG4LlZrMeZzqHVDvqNagSqDxw0
hh9O9NsQouaCdc0sAinwbigccUjkzmTqseCpQhDKfgM1PBuCqBGbuQXxsj1gByRb9pyjxBeSr02XaYN86njV6QBB8MjaMaH3ltYyogaKMiq7ORMwE6bzFi4iD6hLBraNZadAwIuujPLsusA6XES8eF
cJKCWJ3JZiOMbhuxbZ13AoL7wFQJSbZcktwaWKnj24BQfr2RfzrwwEyp0zZKAyka2tJXOUJlSugkEht1cTOU8KkaSamwjZYNdJsQlxtGjO5dbc0nAdUAttNRwZTcMGCiHXea7GjihStZz92e4izQeM
mCiw053r1qqIHtFJQKq9N75A8SA8YDi2ReL1rsq37HfqSJjl4Wvkh94yZdR6F0EKKcToe6BXZLV9YHXCbXMGie2p0Q9tgXAkjLTdorKOJDi3gSbAgmG51sfcPLmJLWxvkG4nx3GdbX0ZdaItqJINwX
BjszpB1xyksXyWY6Tlry0t7BctNuNuk6popMegYKHeeqzOrNIppHBPp2Waz1QD0toJHpaBd0JERT3RNlzpc74SZ1A0H1rp5SOONqNiaXbDxUBfPmwXVWCZOwhZPXeUEIxkTWLyM9dYaiTIj3lA01KJ
8dHRBafxID2d8NqN81HWYKvhf1kzmu7WQZ7W5r7sQWGFuBozcqhruGkh5dgjiwqQRzJ9WfOGX6UQGZ0dRQ71O7l8ZJuixPmkpfev9OgK7DZRXmPPMQ25aP1nZpMIM2Ly5lcw6E33ws5Vi3NylMFXCl
*/
    return self.commentArr.count + 1;
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    UpNewCommentController *controller = [segue destinationViewController];
    controller.role = self.role;
    controller.projectId = self.projectId;
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
