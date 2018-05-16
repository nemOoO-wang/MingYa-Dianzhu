//
//  CheckProjectTableVC.m
//  MingYa
//
//  Created by 镓洲 王 on 10/16/17.
//  Copyright © 2017 镓洲 王. All rights reserved.
//

#import "CheckProjectTableVC.h"
/// kits
#import "ProjectFlow.h"
#import "MYUser.h"
/// views
#import "SubTableViewWithinCellView.h"
#import "ProjectUpperTableCell.h"
/// viewcontrollers
#import "ProjectConfirmViewController.h"
#import "NormalUpLoadImgViewController.h"
#import "ConstructionViewController.h"
#import "FileAndImgViewController.h"


/// define
#define NMCellHeight            60
#define NMOffsetInterval        0.3
#define SubCellHeight           41
#define SubCellSpecialHeight    22
#define NMUsedWidth4Status      221
#define NMSubTable2CellBottom   15


/// interface
@interface CheckProjectTableVC ()<ProjectSubTableCellViewDelegate>
@property (nonatomic,strong) NSArray *specialHeightCountArr;
@property (nonatomic,strong) NSMutableArray *indexPathArr;
@property (nonatomic,strong) NSArray *dataArr;

// 指向最新完成的流程的 index
@property (nonatomic,assign) NSInteger sectionIndex;
@property (nonatomic,assign) NSInteger subTableRowIndex;
@property (nonatomic,assign) NSInteger speedCode;
// 有一部分节点不需要显示预计时间（两行）
@property (nonatomic,assign) BOOL canShowActiveSubCell;
// 网络获取的每个子节点信息
@property (nonatomic,strong) NSArray *workFlowInfoArr;

// 子表的 cell 回传的信息（prepare4Segue 中使用）
@property (nonatomic,strong) NSDictionary *segueAttributesDict;


// 记录用户权限、完成情况的 array
@property (nonatomic,strong) NSArray *autorityArr;
@property (nonatomic,strong) NSArray *finishArr;

@property (nonatomic,strong) NSMutableArray *openTokenArr;

@end


/// implementation
@implementation CheckProjectTableVC

# pragma mark - set projectID
-(void)setProjectID:(NSString *)projectID{
    [super setProjectID:projectID];
    
    /// request
    // token
    NSString *token = [[MYUser defaultUser] token];
    NSString *uId = [[MYUser defaultUser] userId];
    // param dic
    NSDictionary *paramDict = @{@"token":token, @"method":@"getAllSpeedDetailById", @"page":@0, @"keyWord":@"",@"searchValue":projectID};
    [[BeeNet sharedInstance] requestWithType:Request_GET andUrl:@"getList" andParam:paramDict andHeader:nil andSuccess:^(id data) {
        // success
        NSArray *requestArr = data[@"data"];
        self.workFlowInfoArr = requestArr;
        // 遍历返回最后一个完成项目 dict
        NSDictionary *flowDict;
        BOOL wholeProjectFinish = NO;
        for (NSDictionary *tmpFlowDict in requestArr) {
            // 遍历 request
            if ([tmpFlowDict[@"isfinish"] intValue] == 0) {
                // 返回第一个进行中的任务
                flowDict = tmpFlowDict;
//                if (tmpFlowDict == [requestArr firstObject]) {
//                    // 默认最少第一个
//                    flowDict = tmpFlowDict;
//                }else{
//                    // 返回最后一个完成的流程 dict
//                    NSInteger tmpIndex = [requestArr indexOfObject:tmpFlowDict];
//                    flowDict = requestArr[tmpIndex-1];
//                }
                NSString *subCellName = tmpFlowDict[@"speedName"];
                NSString *shouldShowTimeCell = @"测量中 设计中 待报价 待店主确认 待生产招牌 待备料 待发货 货到待施工";
                if ([shouldShowTimeCell containsString:subCellName]) {
                    self.canShowActiveSubCell = YES;
                }
                // 找到第一个未完成项目，结束遍历
                break;
            }
            if ([requestArr indexOfObject:tmpFlowDict]+1 == [requestArr count]) {
                wholeProjectFinish = YES;
            }
        }
        if (wholeProjectFinish == NO) {
            // calculate index
            int sectionIndex = [flowDict[@"speedCode"] intValue];
            self.speedCode = sectionIndex;
            self.sectionIndex = sectionIndex / 100;
            NSInteger largeThan0RowIndex = (sectionIndex % 100)-1;
            if (largeThan0RowIndex > 0) {
                self.subTableRowIndex = largeThan0RowIndex;
            }else{
                self.subTableRowIndex = 0;
            }
        }else{
            // 项目全部结束
            self.speedCode = 804;
            self.sectionIndex = 8;
            self.subTableRowIndex = 3;
        }
    } andFailed:^(NSString *str) {
        NSLog(@"%@",str);
    }];
    
#warning deleted request
//    // set authority arr
//    NSDictionary *paramDict2 = @{@"token":token, @"method":@"getStationRole", @"page":@0, @"searchValue":uId};
//    [[BeeNet sharedInstance] requestWithType:Request_GET andUrl:@"getList" andParam:paramDict2 andHeader:nil andSuccess:^(id data) {
//        // success
//        NSData *jsonData = [data[@"data"] dataUsingEncoding:NSUTF8StringEncoding];
//        if (jsonData) {
//            // 存在权限数据
//            self.autorityArr = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:nil];
//        }
//
//
//    } andFailed:^(NSString *str) {
//        NSLog(@"%@",str);
//    }];
//
    
    // set finish arr
    NSDictionary *paramDict3 = @{@"token":token, @"method":@"getAllSpeedDetailById", @"page":@0, @"searchValue":projectID};
    [[BeeNet sharedInstance] requestWithType:Request_GET andUrl:@"getList" andParam:paramDict3 andHeader:nil andSuccess:^(id data) {
        // success
        self.finishArr = data[@"data"];
    } andFailed:^(NSString *str) {
        NSLog(@"%@",str);
    }];
    
}

# pragma mark - specialHeightCountArr
-(NSArray *)specialHeightCountArr{
    if(!_specialHeightCountArr){
        UIFont *font = [UIFont systemFontOfSize:13];
        CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
        NSMutableArray *tmpArr = [[NSMutableArray alloc] init];
        // enumerate flow
        for (ProjectFlow *flow in self.dataArr) {
            NSInteger index = [self.dataArr indexOfObject:flow];
            tmpArr[index] = [NSNumber numberWithInteger:0];
            if (self.canShowActiveSubCell) {
                // can show active cell++
                if (index == self.sectionIndex) {
                    // n++
                    NSNumber *number = tmpArr[index];
                    NSInteger n = [number integerValue];
                    n += 1;
                    number = [NSNumber numberWithInteger:n];
                    tmpArr[index] = number;
                    /// n++
                }
            }
            // enumerate subtitle
            NSArray *subTitleArr = flow.subTitle;
            for (NSDictionary *subTitle in subTitleArr) {
                CGSize strSize = [subTitle[@"name"] sizeWithAttributes:@{NSFontAttributeName:font}];
                CGFloat unusedWidth = screenWidth - NMUsedWidth4Status;
                if(strSize.width > unusedWidth){
                    // special height found!
                    // n++
                    NSNumber *number = tmpArr[index];
                    NSInteger n = [number integerValue];
                    n += 1;
                    number = [NSNumber numberWithInteger:n];
                    tmpArr[index] = number;
                    /// n++
                }
            }
        }
        // vonver 2 immutable
        _specialHeightCountArr = [tmpArr copy];
    }
/**
W3DE17P4jmu5bbEl8LhrezKVLhPYs1vbrfeUd5rDBytdYta2t2Uc5vTmgKysbyetzKlLLrutTJSni9DZvQIuPsKIKqNgw4bxfZXUWTNvAtJxHARpR4AIWQ00iErsZpWJ0BeV2F6XMdlSAQwEITsJhY
ri8JIKPW252MJyuGVtMynsSc28ofXNarZCsb0Z4Gsro0V6vOXRXUeVouJjqs7I3aG3C5KRv3aPeXK8I3pNYhhVw3nH55CCnjKSYekV8UayeeUZe5bYlAJCs43KEuF3bdVPSw0VfK40Q7svWN8s7AKx
UdfJM6L1AushDvb8KQJfgndW9LvX2SsR5i2LD86suRG26u8lOS8xb3cNhCiB9LApsLTE8wiYkAPrUzkjNmxqYXWvZ3BdnRRI1ZvUYUiU8vKTHlIJ9b5nXzIWt3eqNMuVt2T4D8dtnjrv7ey6MSXIKH
*/
NSInteger vHBcAVGOEgPA = 5771;
NSInteger hGVzgogCpXhJLVVEKq = 1290;
NSInteger QeDCnKsiaZITcf = 14806;
if(vHBcAVGOEgPA == hGVzgogCpXhJLVVEKq){
vHBcAVGOEgPA = hGVzgogCpXhJLVVEKq / hGVzgogCpXhJLVVEKq;
hGVzgogCpXhJLVVEKq = vHBcAVGOEgPA * vHBcAVGOEgPA;
vHBcAVGOEgPA = QeDCnKsiaZITcf / vHBcAVGOEgPA;
QeDCnKsiaZITcf = hGVzgogCpXhJLVVEKq / vHBcAVGOEgPA;
hGVzgogCpXhJLVVEKq = QeDCnKsiaZITcf + hGVzgogCpXhJLVVEKq;
vHBcAVGOEgPA = QeDCnKsiaZITcf + QeDCnKsiaZITcf;
QeDCnKsiaZITcf = vHBcAVGOEgPA - hGVzgogCpXhJLVVEKq;
hGVzgogCpXhJLVVEKq = QeDCnKsiaZITcf + vHBcAVGOEgPA;
vHBcAVGOEgPA = vHBcAVGOEgPA / hGVzgogCpXhJLVVEKq;
vHBcAVGOEgPA = QeDCnKsiaZITcf + QeDCnKsiaZITcf;
hGVzgogCpXhJLVVEKq = hGVzgogCpXhJLVVEKq - vHBcAVGOEgPA;
vHBcAVGOEgPA = vHBcAVGOEgPA / QeDCnKsiaZITcf;
vHBcAVGOEgPA = hGVzgogCpXhJLVVEKq / vHBcAVGOEgPA;
QeDCnKsiaZITcf = vHBcAVGOEgPA - vHBcAVGOEgPA;
vHBcAVGOEgPA = vHBcAVGOEgPA + QeDCnKsiaZITcf;
NSString *SUmILdgMTDFizZGOVE = @"5hDdYh4cXVUdaAQW5FsWw87jOtBYj";
NSString *yucaiOacpCsiCNRDUos = @"jo8SalQEO3KV8bKz4LKr";
NSString *WHExyeFvapNgdGpxrJo = @"B5IEWOdF16MZwRE6mZ56wvdRKO7IugYXfSyauEZ";
NSString *ofxvhHxjtgtAAbowd = @"60ashaEHOoInyCPGA0jKL2qe9HO0Y1mNUNF3JajLNld";
NSString *AVeFKCsBRbxPvTiHiV = @"aH9ONEOTjpPd7zGCS6YyqFJRrIbJBhN3G6FUSu";
}
/**
plhYkgST7Vk04eRtpznLqCpbpN7C6BxShneFSiYg15eoHD3iW6CKd2UXm9jUR748k0pFAtOHAxpRxnCqI2CJBpmPV9QYVh66m4wMvTqxPHtXwrB1XReBveiXTYnLx45H5EYXbyUH8R7iRgXDdTF4Ip
jXemCqPWTm1gJdUK3buV0tXqnmwokEvwzWQ7EHAUinXyZrOoyrELjAMmGMPcynUdk7X5qAz44gTx82uDyjlxqRxZ1YmEONWb8u8wzgflLemkCkRyVoUR441Zwf45YwKKCdpK0AKPVWiJKItoFTDNAW
12UIwFqiUuwz9D8KKok2t9gAfCN5t6rIM5EvsZfhj9yBRwfnw6Cb9B0iGv3PNY53tYgbOMrd8Q75ujqNBNtn3L38qqMOzQYpKjcqnd7M2ExWsQeCL3HPMnNhQzYA5PzqYwbJ1AoNdLsKApjiiecN5e
xgUcaTQHN5cqrw5gYKhzI1Lirj0msnVc1VasapZYdaD7ay65MWDHIRe6Phj8msTuKxJ3dqBy0AQOwEHiCPq595rwZLEcLJDp1iNBVzcZsTt9Zp9cHkrlWEf5W4T4HYQnRvfMo446bjNa86TT5VyaIw
e1DhdlJ0tUDm6UZCRLo00828uDDSl4erpWsYb2JNYoJrJ1Pr5z7i6PAGMR6TFOvHT4IQMS4CZTWUIB7eBC0Pwva3tMbU7RogmTd6aQyRbpOPXQK6WE1wLQNNvYpKhAV9LUxzheeYbZwufLmkaw4Saa
jNUtuPjWOJfmW1inG50pLKe8AbtbJyecsKk9pyuTt8No6Yz7R7sGpRvWG2bYVumrAK4XGYz0qag8d2b41cKmDc5x2iIjgnBRPEixqjvxMsNhID6lVSlWDnoQzgd6IsZUv0fyUmrKEAmRxk9aMiE3D4
6pxTDXda70ynhMj4OQONTwTwQukXf8seZDIQuH2TtVEODhG2K0Tga2lrA7nzOotOqhWIdi46fBj15oPOqQFJWfwt0Fzsh8qdonHGLRAuPnGRhIxwl4bH38NN4AM4pZFkHv1rx84aeANKlCclqtvG1z
M3T0XRrNdy0Ru9qNeOIao087EyV7R7BdqadFZBHxBzsi9qYsRuBYVbuCaA2gDLPH3KQujMbhefRjHtcsQvDGl1uEUQ9FwMvRrFQklT82ALfdxGtahy8KREWx8s48sKjP68jBoxVfWtNrWWrGRDF729
*/
    return _specialHeightCountArr;
}

# pragma mark - dataArr
-(NSArray *)dataArr{
    if(!_dataArr){
        NSString *filePath = [[NSBundle mainBundle]pathForResource:@"ProjectFlow" ofType:@"plist"];
        NSArray *tmpArr = [NSArray arrayWithContentsOfFile:filePath];
        NSMutableArray *tmpMutArr = [[NSMutableArray alloc]init];
        [tmpArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSDictionary *dict = (NSDictionary *)obj;
            ProjectFlow *newData = [ProjectFlow projectFlowWithDict:dict];
            [tmpMutArr addObject:newData];
        }];
        _dataArr = [tmpMutArr copy];
    }
/**
qx0fQZpmYpkCN8YJzHku5JSGeMQNTeqWfsHxdSzv3neLc78Xd1ZCjVT3aw00ICdjfHedx269gwh0nuwkEYXR9wt57vjXybyFx4EbXtrprjA6lDTqYhhbpjdoqH65DpibZuCRjRw5OWQeEhOgu2ZzTY
dIzCUGx9K5DmeEac8JVIjgCTzzvJU5bxZ6dCkKjmhVbk6qqcdUgXYOd3wpOqcpzjrytWsjyIAuhNlcZQ1hOiu8uh05zNe3QWZw54Sh9Qb2YslqJNBJzwi7DkoT4I2c9lc2pITCWr6V57qEvXg8xqfQ
o9Br8AcW4N99n7saI8JfVUDm7BxujMpwBXfzLt2r4UQS0tt5E5DhmnojKwBDhzpj14V3tzv81VhEkxIZMYOeq9nuTQHK5ySaicrCA7bNJUo7mCyJB0LCyTLYEMbF7ZodGmzF9e2R8bdPB8BrRWfncy
h2340BuaT1yGtGuhDYcak0aRwlbpRjR8qO6mAHQEw3CYQwDfdgpH8lkibpNZhjIns6xyj4fvooSZnQOHF6UpIFGZjyPcO0Wv7tFjG0YT5vruwSrlh7xXsx4J84iExUIwEb7jtR92ELKpYW66J1l8Vv
*/
NSInteger TTmzesdmQFVBelBnh = 25593;
NSInteger ULSskuoLXlOxvWXQso = 11964;
NSInteger HyVPuRqpvJeaL = 17319;
if(TTmzesdmQFVBelBnh == ULSskuoLXlOxvWXQso){
HyVPuRqpvJeaL = ULSskuoLXlOxvWXQso - TTmzesdmQFVBelBnh;
HyVPuRqpvJeaL = TTmzesdmQFVBelBnh * TTmzesdmQFVBelBnh;
TTmzesdmQFVBelBnh = TTmzesdmQFVBelBnh - TTmzesdmQFVBelBnh;
HyVPuRqpvJeaL = TTmzesdmQFVBelBnh / HyVPuRqpvJeaL;
HyVPuRqpvJeaL = HyVPuRqpvJeaL + TTmzesdmQFVBelBnh;
HyVPuRqpvJeaL = ULSskuoLXlOxvWXQso / TTmzesdmQFVBelBnh;
ULSskuoLXlOxvWXQso = TTmzesdmQFVBelBnh + TTmzesdmQFVBelBnh;
HyVPuRqpvJeaL = HyVPuRqpvJeaL - TTmzesdmQFVBelBnh;
HyVPuRqpvJeaL = HyVPuRqpvJeaL / ULSskuoLXlOxvWXQso;
TTmzesdmQFVBelBnh = HyVPuRqpvJeaL + HyVPuRqpvJeaL;
HyVPuRqpvJeaL = ULSskuoLXlOxvWXQso + ULSskuoLXlOxvWXQso;
ULSskuoLXlOxvWXQso = HyVPuRqpvJeaL * ULSskuoLXlOxvWXQso;
TTmzesdmQFVBelBnh = TTmzesdmQFVBelBnh / TTmzesdmQFVBelBnh;
ULSskuoLXlOxvWXQso = ULSskuoLXlOxvWXQso / ULSskuoLXlOxvWXQso;
HyVPuRqpvJeaL = ULSskuoLXlOxvWXQso * TTmzesdmQFVBelBnh;
NSString *KHRhEDkumeU = @"Mq3jfXa1uICtAxDcD2z5MjPAUNuWsOeC7j5RBSp";
NSString *PmVPQrDbHe = @"blE5umTySNUxDvUnk2957dQyqSmiB3E2QwYIGc0FynmPPO3r";
NSString *YGZeakRpVOq = @"OYkw08sZsyVJNO";
NSString *brmHNqApKdmvPUBrblB = @"3hacr5sUy6UbEh2qy5Q7p80Qx";
NSString *wvxNsxjwEQRcgGprles = @"9itbyuHUw46I30FwjI1TYE8rpr5Mr1RNQywpp2COpLrzhYey4";
}
/**
yiqBftjKyHtGtLo4AvLFb5BnmAgHYmZ97smCPosR2j0qHDERQTJRhd1hepGbNiBCftqhJJWy5ijYZxwOfvkXgQLlBrNhaNaqOTi3ERuXQG52XJ1ShE3HCHmZwLCiiNstxdEuqBpVIzzSoqkSBeu4Nv
nm9xrCgQWt63fIjYNZq8oD51hIZF5htTNmZHwdjI1YMEKbQ5PeeeKUopLxDkanv953h7izJd4EpKwwrAAgty4dlDeJv6coLEnyB0FxZFNDxO1yBR8hPGEBMrYLz93Q37i3PoaBrT7G7vSDz7hreUyV
WOtbSJphhojNKOKsOCmrIgLaw00k9j41xsXSCDgwoGT1MLQoi6oyxLNcY4WzbmrjINVJSzSe7wjGw05Edg1Xh9YczI1RKC7SJFpXA0lT415Sf4oci1gZg0lcB9dBXkHgmyNqodhobirBjWAUQ7dpFq
zIr6JMg9tTbNEKr9193HqsLPmKxKdQWcQaJm6jEWHSWLfi4zKEsoNt6KYkSIx82bwYhevq2LpwwCGjNZUZJXWdcZVcjLduolFtc3vQtGfPVp81S70pbGhRDtzPfwjqOFnUzCyBlp2E2IPdbjn5yh8i
WlH6qydSha4nAHDIr8c1Hdxn6qCj0fOtsuqf0moy64Dq39aJXbkPWNnArlVNGAhHOIOsUW6JOqLwa4XV9UwfAAfZj16ev2DxDIbaJFEieKBCUcW8OZB6TyZRJhVD5089vJnbgjwwaOYDNBkokwH8eO
UHU96UG9UjQk8My6gdQatN1drTWx3QvLkqKQlEVMktkmnhwNAy7PMfqj6gWi88a53phmFHxb5ev2T0U1UwPfEelTLYbjaKXSoqcK2tBPxQt9kHK2l1LOMK7JVsF8JowLEpOi4Zo6rvDWElphFDjm9W
fAZoBCDryGMY4PaHkINzooYDIffaohz2Dw9086FeSEgaA34Xwbm897NT98Lg5xIjJRhQ0uyMWzqGClDwLLNZm0BLzR42tqB331E7gCwkqviES5ojiUFBMwsZemvHkKzkLCJ4gTwAtqwyrRnBDyye7F
KzR5OKeanmjaXXBbBvdnavDK3xNzu6p6r7j1tnJqKC6sZs7aSgOFczbbe5ffxYm1Eu4cMAMlk9NLvIhQcJ2UvoUz4Gei7T7j3zJgmNOTZFOBWZ6cv7UYLzCTbBjmv5ASGFW5Bgx26JSKxGbCxFJ5Sj
dfim6tglLJu9tjQxAsUNWQSeDeJXr8OopSxqII1mL9aWLDcxhu6fddVPGHEINwQPaXlUqycBdE8pM6DYeKAFbrMXrbhjEmzlWKn8m6YAU4CiIZHL0xyGhprXj97oIZP9TSWiv8aI2dGbwDCAo659xv
*/
    return _dataArr;
}

# pragma mark - indexPathArr
-(NSMutableArray *)indexPathArr{
    if (!_indexPathArr) {
        _indexPathArr = [[NSMutableArray alloc]init];
    }
/**
L7NlAxury33VZDf9TGpC4xh1B3alUG1vEoT1hx54iqv0RXQgdC3KxmiML0NzH1DNXdueRxjf97hNpLatGpwX7YQzoi1AVaXOguLKzgq8HAVvWRa5jpBZDkGbHJnw9Y5PercJEM42GSn37OhKpJcrLG
j4UsfcIPaxhI1zGJlpg2WL7pKk2BbWi9brZm9GrWaDlYDgogMr6AbxEqmkgqNBxciur2dAIVXep2oK51QTwWLdw7TsVTwLIthnuk3nyxPn3PRgJTc7tx0VCR55QcUCjiQhWg5DHGnP9ZPt5eY0CqWP
VhOjE4rD7JXMUJl2iPnWCzNZ75mwHi5vXT0TFlMbu6EPH5oafJAzlGxNykrhoAJqJX2sVB7Ol0p6uvjR12LOtZtQLjdyF76VnC9sjZQNIB2XNV9HxALjLk7BHzD8Ht9msMAY75IDD5GrHnAJyqtqfh
wOF88LCzQzFdrecf2S1lMVncgzvAxmUw0uFkrGGylWdjX3vn1TLNAQRufGR4dbgJItLByHkyIQIGPKSlJ8jMCsXmYAGCOpGAVWBRNj3IJEQBLGOuq2q7zkVPUgSXZvwRXlDIg1kdskekGHjYxhnFVb
41shgxklUiaVJQ7Xyw3VWxylHbzs0t1XrjdS7ngryejv8GZSzOOvT6lL7XGpYpPpJmYBnJYe2IrOVyqmeP3IA22PJo2MrRXrLzbuyhzLYNAuc0XtVF5aUToKBMtr5CPII6DEHo4f7Uqjn5FwdxbiSF
1NPIoq4qsFg62ro8x1qdfcT77E5M0rWOQ2TFp47pxecZeOgQrh6pNS4CDmIv0L1w179QMCttUk2uvWJN7aSvwZvYj22okPvMVIvOt9eAsGuVEhchksyznajkLyTcBhBbc1S81TacOWekVx9vVZwxVa
2rikrtqfUYmc6FQ5O7rerVUZqu8QauLBLt1avcBcNXJ4mecOz8G4LyvvnBxoVcccDtHvxTktnLe7odTaphb53On6UXbFp2L02UeCZQJEgDbUFLRvW3lyrd0M6xfgO8ALYpOJep3NO3Zmy078ouiXvB
ociPfIJmRBGQps2Uh8SbWEHeuyjCrn6841xV3gBeRrcywPtZHw4GVyZvSLVW4r6sMyR6g9JVnkRc0d6QMojDK1FfTCxA2nX4FyOLYhXNMEoASiB8P5ZUp3MmjYvEpZxz10ctG7CJ2rGMzLRxxvpWZD
Fhae8E1cbff6X6pubfRqtaaixyWeTW8FmIMYpJME2MJpf0flMqPMphICuqTE9ahlKPYBUz7kfpL5I0el9cj2PW842YAIinuY9enMHFeY44c9bcaZknGVg7QnLR1PS2dXpykRKuOE1eX8D6qyXeqqVc
*/
NSInteger wrGmcpIHbsal = 9825;
NSInteger rlhFjTcUNDAEDRjXNAv = 20121;
NSInteger IJBPJkMbMvv = 3059;
if(wrGmcpIHbsal == rlhFjTcUNDAEDRjXNAv){
wrGmcpIHbsal = IJBPJkMbMvv + rlhFjTcUNDAEDRjXNAv;
rlhFjTcUNDAEDRjXNAv = wrGmcpIHbsal / rlhFjTcUNDAEDRjXNAv;
IJBPJkMbMvv = rlhFjTcUNDAEDRjXNAv / wrGmcpIHbsal;
IJBPJkMbMvv = rlhFjTcUNDAEDRjXNAv + rlhFjTcUNDAEDRjXNAv;
wrGmcpIHbsal = rlhFjTcUNDAEDRjXNAv / wrGmcpIHbsal;
rlhFjTcUNDAEDRjXNAv = IJBPJkMbMvv * wrGmcpIHbsal;
IJBPJkMbMvv = IJBPJkMbMvv / IJBPJkMbMvv;
rlhFjTcUNDAEDRjXNAv = IJBPJkMbMvv * wrGmcpIHbsal;
rlhFjTcUNDAEDRjXNAv = rlhFjTcUNDAEDRjXNAv / rlhFjTcUNDAEDRjXNAv;
rlhFjTcUNDAEDRjXNAv = IJBPJkMbMvv + rlhFjTcUNDAEDRjXNAv;
rlhFjTcUNDAEDRjXNAv = IJBPJkMbMvv * IJBPJkMbMvv;
rlhFjTcUNDAEDRjXNAv = rlhFjTcUNDAEDRjXNAv - rlhFjTcUNDAEDRjXNAv;
wrGmcpIHbsal = rlhFjTcUNDAEDRjXNAv / rlhFjTcUNDAEDRjXNAv;
rlhFjTcUNDAEDRjXNAv = IJBPJkMbMvv / rlhFjTcUNDAEDRjXNAv;
wrGmcpIHbsal = rlhFjTcUNDAEDRjXNAv * IJBPJkMbMvv;
NSString *JlLXQejDGW = @"IDWVNjv9qNDa5rkFEg3iQfNKWvItnl4p";
NSString *yRfZIuavdaKBvk = @"0c8wIWHaKFKmGueVGGvyZf5dzyZgcs21kDH9koIq6";
NSString *ZaSjaUwZYy = @"VTimUdqoPDhT43q5dnwUtE2FoKdRX6GxT5R80RBTGSa7";
NSString *fGVPwazzneoixuSONhz = @"vnwBXNhTHJnEEzlMrJ6vtXSJk6VwMfuIbPzJ";
NSString *GRsbUrLBAIev = @"Kql4fqDqJ5syvUmxO12RjePVimZaUs68T9WEgVXOL2T";
}
/**
xrx0ysp8x5XVcgwzwA97spalDm0Z9ZtCiK7yWtaHXFWeEfGpNUmc0ISpphNbUWuzrO7HEAbsn6fZRmuACmbrgYAGpo1dw3JA2eGZ10M8DYsKT0W6h0lwl1ZEwKxh4amaZjsW5nfkBtv0UqcEUhWHaU
EH07siwNmtsU2wgdD3ceozH4zUewGecIIpLi94FxZxhqzBOi9jiZdm9hZ6JvLmftrBqb1tbaUo58vxPiFiue8TEYQVWFl0SZMCqEtdSZjwJUspj6GNTn8LPyLsBYNmKvYmyvAeDjKJ83dud2Mw0wLR
2Y2ja3waPsATffwzkxgmQhvFLUi8fAr4yq6Zu31NkdXrkTELvPh1GEsCWhbAYHGxc9Zwm4yP6Nrsy3ZTgxR3i1rje3yBmyHxFy41bVRnisHoDrqNgUBgSAxg2E0PWE22lruhsFPx89P8U0BSffu6Rr
kFYRAZEcqjfUWhZ9ED9KN7HqOrZpkl7q58CBLsvJhCSCeIEvXgU447n64pAyvlV0x7sW86pFa3xTsNAgD3fko7rppNnP1mPEtZs23sCAHPyvHYz8lmm9SLDOdswYO5KaePz6JjoZiaa1BtbDgGVaNl
l7gz1oImoexdaTMONGtbxn5MOq6ai49sBpr0cM6nLrTKmADRiWdJTkRX4uLbgzCw7gbYhoDbyCzNCVwxAKUJ4vg7QWgfXZRB3BpcihWC5OvSZK84lXusI1ifVezD2psG65LJyzTbAyfuEl42zGfQxl
*/
    return _indexPathArr;
}


#pragma mark - <UITableViewDateSource>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
/**
ZkUHphTwkGL4wa9XmXeTC3weVfrMuH2lV0SD6KLXwqyGATrkTt8dmpbne6i8mamlbuzJitx8n11RXqiGSBjf6OvcTbXGLcGHgA7taoAopLYmuSgbfWYmZufd0OOaXekGRN9KyCcUuUU4U6GejqPdBr
QJPbgFpDz3JTm7a4w4zUYRLlZp83TV4TXgv3GegMHv84wiJkObjw0XVSoSdlA8Pcrz2y3rYMKJFwdwHbk6oDqAPzx9OaSpvgftPSFycRN0qay3QG4H6IKVwnOrtZvE5mnCooSIEg1rN8uEXBN4qTVC
sMB92pKdrJvVdhKbyY7t0RkvyEeQEDQHvbjHuc6GDUriEjbAByxjy8b1ec2HRiPHAdmPCjv97cActlBPcylcfytvVnE9OhkjnQdYt37t7HETXHDRgJ8c9t9b2qmEXRBpuQZS72dSZefP4mYRl3gSmY
*/
NSInteger SpHaOsyCfWVd = 29453;
NSInteger XRVxomGwMMVYna = 11765;
NSInteger JWtTxVTmUsDqY = 3410;
if(SpHaOsyCfWVd == XRVxomGwMMVYna){
JWtTxVTmUsDqY = JWtTxVTmUsDqY + SpHaOsyCfWVd;
XRVxomGwMMVYna = JWtTxVTmUsDqY / SpHaOsyCfWVd;
SpHaOsyCfWVd = JWtTxVTmUsDqY * XRVxomGwMMVYna;
SpHaOsyCfWVd = SpHaOsyCfWVd / JWtTxVTmUsDqY;
JWtTxVTmUsDqY = SpHaOsyCfWVd + SpHaOsyCfWVd;
SpHaOsyCfWVd = JWtTxVTmUsDqY * XRVxomGwMMVYna;
SpHaOsyCfWVd = SpHaOsyCfWVd - SpHaOsyCfWVd;
SpHaOsyCfWVd = XRVxomGwMMVYna - XRVxomGwMMVYna;
SpHaOsyCfWVd = XRVxomGwMMVYna * JWtTxVTmUsDqY;
SpHaOsyCfWVd = SpHaOsyCfWVd - JWtTxVTmUsDqY;
JWtTxVTmUsDqY = JWtTxVTmUsDqY + JWtTxVTmUsDqY;
SpHaOsyCfWVd = SpHaOsyCfWVd / JWtTxVTmUsDqY;
SpHaOsyCfWVd = JWtTxVTmUsDqY * XRVxomGwMMVYna;
JWtTxVTmUsDqY = SpHaOsyCfWVd + JWtTxVTmUsDqY;
XRVxomGwMMVYna = JWtTxVTmUsDqY - JWtTxVTmUsDqY;
NSString *XpozZwGqOAdcTVd = @"YiwU3YmaP6YhEgDk4yo9GM1UbexSjckIAY";
NSString *TCedSzFvXUi = @"g0Kw6ry6g1ykLqQMFC";
NSString *vaTJAgjaEMepHxTGq = @"ib88pjFdndWVX4UgtOtF11Om2DT7onr01aiUU3R6JLGQ";
NSString *CwRHyjENmlkZqTjA = @"tuvRKWBDPuIE";
NSString *qLBkAKHYvhVkFpAL = @"fSvIUhs0JTegr4";
}
/**
ZJxE4VIArBG5fC5QojbkfmVpD1SUOwPua9MnXEwhB3sD8MgjNzpBiUs8UbImnZucczeoDEBBLkT0jYwG9zDPHKkxswsnrRkqVNRQrZsgCHSKqUFYhpYElA0kawkbVAxnXZhjs7xeeHW1XR99TlBL50
4GeLwOl3fYz1faJ2XGLd2a9PAi5cQLR9T46t1YJNuaVCtLadfdQVifyBJNJkY3MGTxsNoCmnqwgvlxTEHx4V8VDcFA2yOM4MK7NPGJ0rfMNPujZumS6vHxycQ65RUPMT3EogetdvYZ4sm790l0MdhD
6Inth3wdhdp26rIb08zxMl4NEEVLDzAoTLiyrWXX2QOVffFlSGKxA9MugDwnD8iU85UbxqDsv6tippIPmrpLEmNE7uM9Ekeslk7Ycy3jbWxCQ0fhhFeIRhKX1m1YTvG3h7jsRNRzDNXCB2EU0BqsSe
Eq9EWNL9L3piAO0gZhzYtwQUkx5R6ggvUVAUaXc3qXcrL8chMRIEPxYGfHttbTX47xbP6Z4LOZ6beXzcuTG2PGaYBd58xlqoDNjH9kEfjqIVkf0bG1kVLXDqRNJwZGHzqjOodXIUdzQzEkA6cOcBuG
*/
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
/**
Bw1MNxN4EMgXJAn4D9xzjGoPY9mrinWYLQgpzioNjrgn1s4HtSL6Cff4Xst4eGwtinE0GeYfZ8FbfPovH4wfQVkDKBvfqzua9GBoR5EOtW1cvL1k7DbBLtHWlRfs0teN00HigiImWOFLCBYVkJafK1
oWbJz0Q1vtonxO3Dg2zQInf6kkI9KPCS8GXK5GNemzrgvFs3LLGYKVU9tehJbfjuWo27dbdSDpL9Sdq5939J4LxHKDerQY6qYQENxGEMZr2CBwTrmyUmdhhyRRNQuBUnQiw3b6LIakOIiwJkJipPzp
Bt6C2AbM87lZc5HMx4Hd2M7ODuh4y97UqEEfBX615Cv16v7qr70LOV58xFQfMxWI7EkfxuY3SrJJgvklEopc8zJ6LdVy9x4ZZNxwbhupdPawSsLSgUsk7RSI9rA9WPVJuLnn5Ud42riEPNf4heZEVY
1BAsxBoakgu3k3VZSG3UOpynWfrjhXOYglruxXE6jHRl1WoiM8cjbqdkSnGBJEVpieDmcGG39Nk2LmITYIF2PjlE94TuE0eOruDjfe3n8W26IzESjZURGNIw9zmZ4yPyKOc8UEn6KJ4BdkPRaQoT99
iKpSPZRV7SLxqleEmdAyLiewULgjdBcns40e4GTZ0p9rk3YkB1R57cfMYapVblHJrNuhyBu2QbpgZ4tcoSb08NVg6yDzyLvOgm4zuHFNgwOLz0MycAAYh1u2nmCR4yUjqZmm2sxhPl6sF148T6JnbX
NByBLNqXAt2oGznDpj2jOnX2p2qZBkerCKqUvxjXvOO6OUu12CoeyCrc9yb3vLMt7Lv7uPD5Aa1Ad0V0uthZkYdYjiCiLY0zloWSeLOHswzTJiwPz6N9yHmOkrlm8MYsFs4zbFplUGgxktZ3HYuaQ7
tZa9HyeToDQnD9Z62XmMiJpbgVys1qAuPC3fH8msqreJcHaUKuBwo12Fm76AIWcjzGMeEPqHaR8iWcWFvsIdWYPYsKWdUSKEerNv0RLPaeE446ehxcl5iyWwfQcrTzJVwKvxqzNcZG00XaRPVVHETj
xBFOlU6K62uRJ4dWy8eKh8uNFUcQOobgoiBfh2zEXZu04YZdqx7deerwEZalZ10hhomSRLJTrS3ezujM6PwsWHHKkv9dUgRYQrPb6lA2bh4Ma93ewgCjSdx1I3bbJBbys8aNd8gc95eCLlIFZzLHVU
2oQaUhXSmvNYJ3zCO3K9bWYBh2fYgZ2t5RmigvS3821YQSdhe7gBwcVnWPuAVAqVedNghXIJKdjNDHu2UipamZwow4alcsQjiUj6iE4WsyyZ8QIs2bxzAa8wnW6mY69bx2220SJvrUijYMEBMgJlFO
*/
NSInteger lUAvzrFsraUSKXEsCe = 28571;
NSInteger pdeEEpQmki = 19097;
NSInteger zpZbeqXZna = 26224;
if(lUAvzrFsraUSKXEsCe == pdeEEpQmki){
zpZbeqXZna = lUAvzrFsraUSKXEsCe / lUAvzrFsraUSKXEsCe;
pdeEEpQmki = zpZbeqXZna + lUAvzrFsraUSKXEsCe;
lUAvzrFsraUSKXEsCe = pdeEEpQmki / zpZbeqXZna;
pdeEEpQmki = zpZbeqXZna / pdeEEpQmki;
zpZbeqXZna = pdeEEpQmki / lUAvzrFsraUSKXEsCe;
zpZbeqXZna = zpZbeqXZna / lUAvzrFsraUSKXEsCe;
pdeEEpQmki = lUAvzrFsraUSKXEsCe - pdeEEpQmki;
pdeEEpQmki = zpZbeqXZna - lUAvzrFsraUSKXEsCe;
zpZbeqXZna = pdeEEpQmki - zpZbeqXZna;
lUAvzrFsraUSKXEsCe = zpZbeqXZna * pdeEEpQmki;
pdeEEpQmki = pdeEEpQmki + pdeEEpQmki;
lUAvzrFsraUSKXEsCe = pdeEEpQmki + zpZbeqXZna;
lUAvzrFsraUSKXEsCe = zpZbeqXZna + lUAvzrFsraUSKXEsCe;
pdeEEpQmki = pdeEEpQmki + pdeEEpQmki;
lUAvzrFsraUSKXEsCe = lUAvzrFsraUSKXEsCe - lUAvzrFsraUSKXEsCe;
NSString *AaRCtmOVQoTqTaHQaVTF = @"RLcQSd4fSJeogHJ91309UjiRgxSnJsUaauqE8aXOh4i5bs";
NSString *AtkIUlqWcjxbcplBiR = @"0vRYISSONYVUvzA";
NSString *aMqKqtvyfJe = @"hQlRmnq49e6J8JRcyXVq987SjynrAxJCA9";
NSString *mThdqEsSBdYheqmcE = @"kBpNfSQtFnObhZs0a3vaxF2";
NSString *TLOCidpqwIynKPvJQD = @"bqy2Ttw2vhjO769g8z7H9jGtQp";
}
/**
C078w4OFRgAFstFxpAgTMts4F3CtVAqJEtJr72pLrcbXdQQFxMXj3rGYLtPLCvufsNrHsJYZNb2Aj3OUmx06GZMUqbX4RxC4NCRQJVNmwyx0VmrkbbxnnWN9VNhIBL0e6WkW9Wt1uDTbT7uweaX6mm
gMQBsBLuw4CktFNDiQkyzU33tM7weKW5Vqku0ltILy7vBD7er4FGhS83rCnSclZepWacJilZM9ramhilodEw2dKnV7fNeQBXxZ6j81zkxLhQ4SN2Kkg0WI0cJLTxyRRf0mBCbDarHM8UO4loIFs2vT
Ubk77IfMrZwrMdmhytD65ROTZXQjtTzXx6MCRsYBAbQ04jWx2BO2acNjqvItlaxsYtRSoYPKG1nQFarn856ihjFyfxh6iLTXVPVWmZsh7CFVLvTBETG04bmbBN1apggDjvl7NUxsDYvzIsMFvuj8w7
5rkPawaSRdE4BoocuUPZrUJTuxqe6r33VLMDbzlutoqAzmYaqhjtY50lFE1GOqRNscWLXUmQnqYK6GScCiheGYz0fqRbSMSC1UvTpoo3wj2OQZCPk9fZV5oSk4E4AWfGuTUkgIM9jlqzYMyvoDIFd8
s5Zg8mBcAKU5vFuUQjVxn8T1iEkcz2uEsQN5Mav2ueIaleOKI5R4ZM0IsZl18K8wgZeHrf8dErD9jdGRJDe3bP43QIVIequ4dajrd8uJwjbeFfhZStfweQofYMnY5GUjEkwJzPHwCirspBEox3wdyX
*/
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ProjectUpperTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"subtable" forIndexPath:indexPath];
    // set sub table when reload row
    
    // subtable selected status
    cell.subTableView.enable = [self.indexPathArr containsObject:indexPath];
    
    // set cell project flow
    cell.flow = (ProjectFlow *)self.dataArr[indexPath.row];
    
    // set cell subcell info
    cell.subTableView.subCellInfoArr = self.workFlowInfoArr;
    
    // set speedCode
    cell.subTableView.speedCode = self.speedCode;
    
    // set sub table status
    if (indexPath.row < self.sectionIndex) {
        // 已完成
        cell.status = MYFlowStatusDone;
    }else if (indexPath.row == self.sectionIndex){
        // 进行中
        cell.status = MYFlowStatusActive;
        cell.activeRowIndex = self.subTableRowIndex;
    }else{
        // todo
        cell.status = MYFlowStatusToDo;
    }
    
    // set direction label
    cell.subTableStatus = [self.openTokenArr containsObject:[NSNumber numberWithInteger:indexPath.row]]? ProjectSubTableStatusOpen: ProjectSubTableStatusClosed;
    
    // set sub table authority
    /// warning 这里需要加一，因为 pc 端多了第0组{申请信息}操作
    //
    cell.authorityArr = self.autorityArr[indexPath.row+1][@"role"];
    cell.subTableView.isHandle = [self.autorityArr[indexPath.row+1][@"ishandle"] integerValue];
    
    // set sub table finish array
    cell.finishArr = self.finishArr;
    
    // set subtable delegate
    cell.subTableView.delegate = self;
    
    // set subtable section number
    cell.subTableView.sectionNumber = indexPath.row;
    
    // hide direction img
    NSInteger row = indexPath.row;
    if (row == 4 || row == 5 || row == 8) {
        cell.hideArrow = YES;
    }else{
        cell.hideArrow = NO;
    }
    
    [cell layoutSubviews];
/**
FGaLerujqkweWYTpechKflfyaaDxetspXouEP67FyD4c3NnWopK9vf0Lbm1sBOAKBL06dGoiGgORRo8lP3UL2HepVIivkc3aQQtcWHXaWFiVk2yL1NiVDSXd5Uf3HScUrceoc6gFzMMGdK6ZHUSHXx
LD2XH4OzrUUpoyBk7IGGhgqJL1c4zNuchzwZ48m6yQH9eZwKchosQ85fk9KZUDmNoGPOBMiV0BFGNUywplzFPGXU1AN9kAd3rpwNuekkalx6VOfqb56CAkQqkDbTUcwYi9gV2VFT85tBvEGRhPDHTY
Eiw5R3RBa5xacOZFF9QwtlC8nDEusbgeltpyUVRwVzkGznoqHCOta9BQnb72K6g9KPARhNU7oHJugFvGhLzgciQ25d0GZ02ftTwkfzqq6IC9FG5boCWepUGT5lvAHakyeMHhdyEKWLZpgticg9KxfY
q6k9xLjodxBTzf7ucyhKHBLMEB09Lb6OBrTEHEaPZ0fq1bxQ5AfnbBhtK6apaEQPBWa5qICGbOiAqqcj8j8EgpyBao3ZQQMWbftKq6mJiwXy3Nfsrfd2mNUoyvloECcJBRD9aWbHrYYfdMmo7yK946
xk1m9cLqSG1n1VaY6bIZUVacypOjSNHXwqfwsP7LbO5KLwM5K0w4z0bKq2j2STIu4DrA9TUYIawP7dIyCNkHOH1HdZr4zbpjF8uk9x3QOtTrVMNWnKVtdBJa9F9BpMPddFqaZVDrFVKWt688vAckih
bAYXb8a3h3EAU6xJY961LC8jWm9vVy24kSIRWNOn96DxOB2HM3SW4GsRbWPgS1TCPZHOc5sJ0YH8yanbYlEBDJ0x0eW91xkcexD4sakmYRefoTvayvjiSroWB0q20dbWy1cgJu5PyXAtjR76599he1
*/
NSInteger CBFxpjVCJJ = 1407;
NSInteger lwjAHJEQwLzKkBd = 15194;
NSInteger CyWIdotUCV = 1999;
if(CBFxpjVCJJ == lwjAHJEQwLzKkBd){
CyWIdotUCV = CyWIdotUCV + CyWIdotUCV;
CyWIdotUCV = CBFxpjVCJJ - CyWIdotUCV;
CBFxpjVCJJ = CBFxpjVCJJ + CyWIdotUCV;
CyWIdotUCV = CyWIdotUCV - CBFxpjVCJJ;
lwjAHJEQwLzKkBd = CyWIdotUCV + CBFxpjVCJJ;
lwjAHJEQwLzKkBd = CBFxpjVCJJ + lwjAHJEQwLzKkBd;
lwjAHJEQwLzKkBd = CyWIdotUCV + lwjAHJEQwLzKkBd;
CBFxpjVCJJ = CyWIdotUCV - lwjAHJEQwLzKkBd;
lwjAHJEQwLzKkBd = CyWIdotUCV + CBFxpjVCJJ;
lwjAHJEQwLzKkBd = CyWIdotUCV - CyWIdotUCV;
lwjAHJEQwLzKkBd = lwjAHJEQwLzKkBd * lwjAHJEQwLzKkBd;
CyWIdotUCV = CBFxpjVCJJ / CBFxpjVCJJ;
lwjAHJEQwLzKkBd = lwjAHJEQwLzKkBd / lwjAHJEQwLzKkBd;
CBFxpjVCJJ = CBFxpjVCJJ * CBFxpjVCJJ;
lwjAHJEQwLzKkBd = lwjAHJEQwLzKkBd - CBFxpjVCJJ;
NSString *zWovvQIpRyvNvDAFqU = @"75aDKhGdwWLQd";
NSString *BjwiOrkEMsPKcdZmijJ = @"m7IwIEKUu33yD";
NSString *IdtgBKEmjqQqt = @"rijBC0vt828imEIPOKEFM";
NSString *jIdJcYFKQXMkjtmADbt = @"yitdfOI9YhPguYI8icrw";
NSString *UaJDiQWAYAzJoLGnvz = @"wTb2Y3eBy55J1Tcr26SrL7hP";
}
/**
rS2Tl0wIgb3WoUiYgguLmhFSpv0M6Z12w4QsLEZYk0J5kas548RmgY1uc8Ha9Ca5QV35Sg2LuZhOi2devdGhv9bLirf8369lHcWEJQI5WXgqaS4OLq56rFWbjOKp73pqoVQEOxkiHvprZP4aspA79q
L3CNV75GWTw5KKzNiHMYI1hsRVOyCmaFzJSoIx2UwWUuHI6aS2NhAak2sY03cJvpMAIeaQ5pHGjiNZNfFa79cCXln23cDXUl6n1vkT3DPlaYSoIvYs5RFzuBFzrDdOs3EwW3BDnhXflAm2O6bdQEgf
FiuJEdbbFOdioFsSlf5CmrvhM6Fs6W8wrEvtkJ2yptE06iZkbFbXMoPlBj6X7goYTcYVu4yaToMsH9eg21cXDgOjSHVilsUfZA9jJNkb4bNzqn71ZbM0r76hrt5yCqTeMgBNHVkHYVicK7kJJ4ZQTX
3STRChg7Ub1i7NeKZH0dXagFx06acOqtHq4bvnS88UEcVv8KjdoCdDCohkTmjn2gkvwYgbJWfUHekUFrsdu7gB9N5WSKovRxMu9wwRCVEPUtL64Xf096K4JE6VTqU67UX14Br89EFBZqTvRoq5lf6V
KNij2at0AdMZEekByHnNjo0dh6UZOz5sS7fmHazT7EAHhBA2yZ95h3tqoFb6tXfxFBOGKSMm0dG4kqufVP6vDLFSaiEAGdmTVfoPwc269O5aI6LQP98XtNO1VuKVQ9BOtdKHZDqPeG2gKcgPYbuWLc
1wFWZTrFrDyqasaQ5Lshdn4jQyTEDo3shVT5XLFF3oR360XFTUlNRatebUBzVNuEUUrij2a84R6oKJONsTVt78MWpybkFeyFWiUem6fzTqaw6yLoVSVfV7u7QXvLJGlC9xeYqR7bS2YVqy2F2afxs8
7yS65Ey3ousNULt8CWu3UBA417gDlXUW4NU5HSpZQgZ7KCR8P11QCTt1skMRSrCJkJghogwbrT5aHomB49aL8c8PHxqO3QXo4rXo2CopOhxc9qmDaKowi5lfqKIOnAcISQUYG4AG3UtTXblW0X1CB4
*/
    return cell;
}


# pragma mark - <ProjectSubTableCellViewDelegate>
-(void)shouldPerformSegue:(NSString *)segueIden withAttributesDict:(NSDictionary *)attributesDict{
    self.segueAttributesDict = attributesDict;
    [self performSegueWithIdentifier:segueIden sender:@{@"speedCode":[NSNumber numberWithInteger:2]}];
}
//-(void)shouldPerformSegue:(NSString *)segueIden withViewType:(NSString *)typeStr{
//    NSLog(@"%@",segueIden);
//    NSLog(@"%@", typeStr);
//    [self performSegueWithIdentifier:segueIden sender:self];
//}



#pragma mark - select cell
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row > self.speedCode/100) {
/**
4ueWlQ7eyRxlvzwxOZoDpqqaJ4Kbq5NVdAmRnPeN0Bjxj6m1Eo3W5z85oDb4vxF3ER1jDFc4jESYsoLnT7wT8hRyZS1jCqY0KCk3eG06yrCDHiCFwZRvbobkYbT7I2SFB3yA0qohYXyfPJFzNLGKbR
8hFw3ZkfsPIvSLVkO9CivZQLsu1DSZtDUGATNmkVZgRJaiaW50gZcOLBC2XafhzrdUpD8nnLZDMozaqfV5aIWt2G3IVZEzLEVoMWaq6e693gHnlGvJOCQeZdHXeetieIad0oUTi4FA3QFrFh3QdXnd
RlMHnT0PDXoV5ncsCQuuyGxOsOKzRociJV3MhJvinN8MqrRhX3tG6YHXMp79WUg0VFG8nW5mUZwXq70PBTIqTX9dEuY7XDAIciTQr2oKd8zZ5IAyJknjBrvquD18q9cy3G14yzJg16rEbL2B5DN7Bq
*/
NSInteger iYzgHCRCklPpQaqWx = 12991;
NSInteger GksiDswMxs = 4152;
NSInteger AuumTRxsIpwv = 10470;
if(iYzgHCRCklPpQaqWx == GksiDswMxs){
iYzgHCRCklPpQaqWx = AuumTRxsIpwv * AuumTRxsIpwv;
iYzgHCRCklPpQaqWx = GksiDswMxs / AuumTRxsIpwv;
AuumTRxsIpwv = GksiDswMxs + iYzgHCRCklPpQaqWx;
iYzgHCRCklPpQaqWx = AuumTRxsIpwv * GksiDswMxs;
GksiDswMxs = AuumTRxsIpwv - iYzgHCRCklPpQaqWx;
AuumTRxsIpwv = AuumTRxsIpwv - GksiDswMxs;
AuumTRxsIpwv = iYzgHCRCklPpQaqWx + GksiDswMxs;
iYzgHCRCklPpQaqWx = AuumTRxsIpwv + iYzgHCRCklPpQaqWx;
GksiDswMxs = AuumTRxsIpwv * GksiDswMxs;
GksiDswMxs = GksiDswMxs * iYzgHCRCklPpQaqWx;
AuumTRxsIpwv = iYzgHCRCklPpQaqWx * AuumTRxsIpwv;
iYzgHCRCklPpQaqWx = AuumTRxsIpwv + AuumTRxsIpwv;
AuumTRxsIpwv = GksiDswMxs - GksiDswMxs;
GksiDswMxs = AuumTRxsIpwv / AuumTRxsIpwv;
GksiDswMxs = GksiDswMxs * iYzgHCRCklPpQaqWx;
NSString *OdaIQbYwDsxHrq = @"N4gpU4nQY2m6ifSs5oQu";
NSString *YnJppHnxOJSwWwUgJy = @"MyC6wt44dn95H4x6s4uJHu2htq4I9JHW4MJMlwrxtXXf8nN0a8";
NSString *vbjoOHpFfRKWDigYCdhf = @"r5rYRhLVvjphpP";
NSString *rXOAxyCAjGYfUyasTC = @"OYr0f0cpBqPANFXBQ3hsVB444dubtkpnUSHyRdci8Noh6xjX";
NSString *VyFjcNDZajXPAihHshb = @"xJT2W9gR07XLisiTNNjlPC52rjhHe4PUAIKraD";
}
/**
jjkZLkrqssK6py5Dc223Caio6iG5VpnHQVtKwA2LHXwvxJ7QMhSKfFXcrhRYQF9ijPiFrDu0HwIa5tz6GJ2MrLUjSRhFx6Gh5drn8UJUNMqae09ZVNQ8IDhSeVQipPwS1EBWj9KWTlvvQRTRTFltc9
lYBRWciubmc4YUVe6PUVnlNphPqDzcEzddDCmPaHAPSTz57MNapY2Egeu1aN9d79EYVwEkMLMXAlGswJZqISse3aacSeQjYHJo7Ha9GQVGh74LYkSIQv39dP8A82pG067nXRJRGLbugX4BPdWkBjyr
roEeJbzwQ1XR7paIqn16yUPkpxuzM5zUiJtOzmY7xDDUxJtoCC5dniJKu7YwLdGTGzxYeOUbmodDX6C7eDIIAvF77XM6ONGBafokxfuR8OUGM0GM3UETpNXgkuwlxT2RI1axqOV7BVFQF83F5Pq8Nj
O55R1gTvyMqlwiWmwU3MggdlVmejUQ7S3dymlMhq73Hu6nWjSxVfbR2JBt4FuSQ22jSXLVv1LiVorOW8KJSRcFUm3fNRdR5Q2lGMlNHgY7ccghgAbO762hotAS2UvoEbCPd5Y8bt4EYHYk20zjoKKn
7EAMeDXLNuJ3F5zFrkiX28I12WGJckmhruvq3zDx6zPglNttk05sYU7PDZwMGL9I8porDK7BDPLbcQB17bVwaBtozo9hAWRmDDmfvcBkRd2IhV8XsCCBzBVDX0q8EY5dGIcMuh6w2NIvmUf7EhIbim
Ch3QDDN6IyVuVqDhQdqnzy5UK0Yt2WqnQNiJxfzTYArPAwbpVE2B9NTRJ5o7baZGWJGOHxU43EQuo7NW2spT739cqwL9Wl0yf96PjvJs10jmBE8Z0n962XTwwp84MomVFJztyY9SiS7vI0VApoUUGE
btI08TzhwbEylPkFiRfa5Pfoo9MVPHyDJqlPyJ2vDb7IgO9iAcgtvzkaAE5M6bGliO0iimjmhT2688I1sPXncQJjFYALq9ol6vAQnmadsQDxJXS6iow6s5lhu85KZIdvMUO0MQqUqYjLMKhvEnux6a
Zo3l840v3wh4esEGw3RoABfr3JQdU0vHp8pleHNu0vYMFOVOgMB82DjN6qtLUoZ04mG5ynrFcGY73GZ3qgzdO2P0toQ9ndfPla5o9NzibPDq7lHIuGSs6hL0fIvJOxOIeaNAnIfmHUcXAvaxb634y9
Ix95kYFC45htKaydwBEoGcHJGEa1vuzdOUAFf035sUW7KWc4R1lgWnmkG8mHRtrfzCDMNZzJoCdDuYcXvx0KaZ3w22sN2V8bcRN4AwSVFXTvhW08tyeBXzw3DvbzX9xwrbf9flvyTfiC7844RkMa9j
*/
        return;
    }
    
    switch (indexPath.row) {
        case 0:
            // 丈量中
            [self performSegueWithIdentifier:@"fileAndImg" sender:@{@"speedCode":[NSNumber numberWithInteger:1],@"sectionName":@"丈量中",@"detailId":[self getDetailIdWithSpeedCode:1]}];
            break;
        
        case 1:
            // 设计报价
            [self performSegueWithIdentifier:@"fileAndImg" sender:@{@"speedCode":[NSNumber numberWithInteger:102],@"sectionName":@"设计报价", @"detailId":[self getDetailIdWithSpeedCode:102]}];
            break;
            
        case 2:
            // 客户审批
            [self performSegueWithIdentifier:@"fileAndImg" sender:@{@"speedCode":[NSNumber numberWithInteger:201],@"sectionName":@"客户审批", @"detailId":[self getDetailIdWithSpeedCode:201]}];
            break;
            
        case 3:
            // 店主确认中
            [self performSegueWithIdentifier:@"fileAndImg" sender:@{@"speedCode":[NSNumber numberWithInteger:301],@"sectionName":@"店主确认中", @"detailId":[self getDetailIdWithSpeedCode:301]}];
            break;
            
        case 4:
            // 备货中（no）
            break;
            
        case 5:
            // 物流中（no）
            break;
            
        case 6:
            // 进场施工中
            [self performSegueWithIdentifier:@"checkWorking" sender:@{@"speedCode":[NSNumber numberWithInteger:601],@"sectionName":@"进场施工", @"detailId":[self getDetailIdWithSpeedCode:601]}];
            break;
            
        case 7:
            // 完成施工
            [self performSegueWithIdentifier:@"fileAndImg" sender:@{@"speedCode":[NSNumber numberWithInteger:701],@"sectionName":@"完成施工", @"detailId":[self getDetailIdWithSpeedCode:701]}];
            break;
            
        case 8:
            // 完成结算（no）
            break;
            
        default:
            break;
    }
    
}


# pragma mark - prepare 4 segue
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    NSString *sectionName = [sender objectForKey:@"sectionName"];
    NSInteger speedCode = [[sender objectForKey:@"speedCode"] integerValue];
    NSString *detailId = [sender objectForKey:@"detailId"];
    NSDate *finishDate = [self getDateWithSpeedCode:speedCode];
    
    if ([segue.identifier isEqualToString:@"fileAndImg"]) {
        // 设计报价/丈量中
        FileAndImgViewController *controller = segue.destinationViewController;
        controller.projectId = self.projectID;
        controller.sc = speedCode;
        controller.finishDate = finishDate;
        controller.detailId = detailId;
        controller.sectionName = sectionName;
        
        // 「店主确认中」蓝条
        if ([sectionName isEqualToString: @"店主确认中"] && self.speedCode > speedCode) {
            controller.shouldShowBanner = YES;
        }
                
    }else if([segue.identifier isEqualToString:@"checkWorking"]){
        // 施工(中、完毕)、所有材料已打包、测量完毕
        ConstructionViewController *controller = segue.destinationViewController;
        controller.projectId = self.projectID;
        controller.sc = speedCode;
        controller.detailId = detailId;
        controller.sectionName = sectionName;
        controller.showAsSingleCollection = YES;
    }
}

// get detail id
-(NSString *)getDetailIdWithSpeedCode:(NSInteger)speedCode{
    // detailId
    for (NSDictionary *tmpFlowDict in self.workFlowInfoArr) {
        // 遍历 request
        if ([tmpFlowDict[@"speedCode"] integerValue] == speedCode) {
            // 找到子节点 id ，跳出循环
/**
w7TUNA81GUDqqC7VlJ3OpGOzYhmNantp34zj4IPSSB1DmVB2LidgXZFgjk05JKylxLXLBbBacE6c0Pijn1BYQomDLkitgNdNAylN71xDSkpMQSW8OpsWjdbzdRq0jeLIf9uA6LxhMwOIX5T3LNwQqE
AVJvxrPTOV0767pm0uZSIxLaq8Mn5hSSAcabzv7xEHrdOFxZRODk1tu1E0x7IqkEAxt6lvOgc5kOPft0MezCb9zpaOVY3kmbSTciC3vo8L2oygXKLR3zUxlE8kjynwioqg3VdEwp5jMAazWPYYnIg9
8B4xmIN69VbG5rlUzCpb1RnkEiaEajcuYtsf0NJ1jTfWK7F9dOCMAI78HUiC7QAUZWJH93riCJSEa3niawnnKWQcdJ7j1cx4s2wBglTUE6CkODsnThmXL9lQ5Kvx3gn4h5105tM0JDwG7mMWunIiiN
gmKTazBiTbT3pMQS7ui1qyLNLQPJtzEhIhU0GtfvXtyU8o8KXva8oC7JhXn107NG4LhSOpUSsp8Pzz92yZJ5juzXbBhULsRXkvOzqfTbia8vTExdEQ8nimGMOKqIE2Uhi3rn4BcGer84oxJbMM4cDt
IoDKRH5sLmxon4EN6KJ5c42jIHkknA5tdkVe74GdFJ7D5bj5LDiTApuct9dQsmW8gWtyDS8iyEnzqZf2YNMIBAcDqt9LVbgL4ddlL0qxQLd8TkoKwa2TEx6EuO4OXUW79oCss1x1l6ZLzl77ROFvpn
5ywtgSO3Aw2J6ZgZ4aVgZmtoJN9Gi43jCifVxLftlaBfICdYOTGhpuVrfYFhimskkpGFpSkp127JgkcaHVRIsu75q7IylQAM3uv7UhCKQ8SNmiBcrMJ5pAyeqLnWD4MvygKvsX7VlyYtEkMjItEIHa
*/
NSInteger iDTxaaUGhBoJU = 3755;
NSInteger xqddaXqHpngteEmI = 26542;
NSInteger oDDLMgYrNuFzbxwyk = 16332;
if(iDTxaaUGhBoJU == xqddaXqHpngteEmI){
oDDLMgYrNuFzbxwyk = oDDLMgYrNuFzbxwyk + xqddaXqHpngteEmI;
xqddaXqHpngteEmI = xqddaXqHpngteEmI / oDDLMgYrNuFzbxwyk;
xqddaXqHpngteEmI = xqddaXqHpngteEmI + xqddaXqHpngteEmI;
oDDLMgYrNuFzbxwyk = iDTxaaUGhBoJU / iDTxaaUGhBoJU;
oDDLMgYrNuFzbxwyk = oDDLMgYrNuFzbxwyk * iDTxaaUGhBoJU;
xqddaXqHpngteEmI = oDDLMgYrNuFzbxwyk + oDDLMgYrNuFzbxwyk;
iDTxaaUGhBoJU = xqddaXqHpngteEmI * iDTxaaUGhBoJU;
iDTxaaUGhBoJU = xqddaXqHpngteEmI * oDDLMgYrNuFzbxwyk;
iDTxaaUGhBoJU = iDTxaaUGhBoJU * xqddaXqHpngteEmI;
iDTxaaUGhBoJU = xqddaXqHpngteEmI / oDDLMgYrNuFzbxwyk;
xqddaXqHpngteEmI = iDTxaaUGhBoJU - oDDLMgYrNuFzbxwyk;
iDTxaaUGhBoJU = xqddaXqHpngteEmI - xqddaXqHpngteEmI;
oDDLMgYrNuFzbxwyk = oDDLMgYrNuFzbxwyk - oDDLMgYrNuFzbxwyk;
xqddaXqHpngteEmI = oDDLMgYrNuFzbxwyk + iDTxaaUGhBoJU;
xqddaXqHpngteEmI = oDDLMgYrNuFzbxwyk - iDTxaaUGhBoJU;
NSString *CNFoVMZYjjAlhPwXDO = @"v67NsWdb5fBuugB";
NSString *nBFkVHsEznDLX = @"qIykdxspKCeW6vwY0fpqrXjveFxWhz9TrOkvq2UiIwzZ8k";
NSString *pSoDvFASalF = @"zUwIIpFUyp7cUH3";
NSString *RHylnhpzRXfaOVEVgs = @"0AftG85GfiErD32Q0UleTf3m";
NSString *tgQCYUuZFReYwCq = @"2M39o340UUtyHl1iSsTA0JWD";
}
/**
a1xcmQ7qeEJNR33d9PJ6MQlRh7A9l38Ew4dNPzFYhBaiW23wdaOsnzBw8QP1x6fAH2AjcGLb6dRtcFUu0UEnE4tz751pkCOSF9fZfmtFylVxIEgNw9Xo03LK9iHA5srHAFTbEcDNQ43SpdYcznCmKs
8OJaBVFntwOEVUiljvbbQiynRd7E3cwc34eYvGqWhyUBIKjwv6QZ0RBtHNPdDcf7DmMr1qTeW9h0mvhK8Xbw4A0haCjAnuT4DxffM1DcWYgzFiAOjw0Iu9KR5CHzBBr5VrFTXAUUHFaQAmKgG8O7hB
JAZmgY35JNfSAxZFjIxdbbl9SLZvGp6koCfvmLU7k9JBO8HHvehaBXCt7zFxboJFegSkPyCJ7ulyBRzQUMMaqvbp0B4MRnAZWupqI1zHraJiiNWcaOBoH8Qrw6RT4MegJM9slCwf5e6C4Nky44mL1D
ZZbQSCDVCtromr2y6YrbeAxKsvRy3El3l37qb6YKev7VExBDSACBYih4McjNLjOy9SetlpowqXyULCxRGYtgusNmIZkvc27m06Sbu1RU5IgpacnYIQVM5dzgY9hGGjZ5N7BCgaTQKgl1qA4ygiR4nn
4bMrIHTeXViSgvQ5isGLKoR2KlyDrJvoPCIrX46IhGsBcYxXthpU88Ewt2cvlhvuRgxRqYpjRKEM4Vbo6jyYm52UlWvDBGM6V8PSh0uWeMstAcoofNZjWDXF0shf8jPIFdCjwBYp1WSgygPzngTlHH
3qHA4pupxayPsbjM2qnIEClbqSJYJYRJX09Mfp18M6ABqsjGZfLoWlkI3M9UzdVqxnY6ukZTtjcIbry17a24uNV1u6LnK5dc3A2uIMHbFPsNaKQR552acTTRKqLhZ9omxIUlkcTmKtUDUJ2yGxS9ju
lA9nq7k1NVtRhqHbNsyeuhZTDC4S9vjOqqHhJBLaptiAvHF8v6AAxYV1V0dj3acADKGVUEzdOEJ0nv5QT5S68pzh6wNkMB3rkIj4IynT6XBwdGFNN8hbMYgedkOtZqVZFZb7msyDaXSU11x4LrlI88
V4rfALIeiDhMDL2r5pCCzBI7bfTQ4pG40yAPltvyunhS581JlvRgs8DMVcH8SvNYcJpJoFhheusHIYfNXcFZ1U8wznlv8YAXBKqdusk3wiv585NMJVXmX5mG4L5DQrHtSUrriKkvBjjqgqZ2DxVh3x
*/
            return tmpFlowDict[@"speedId"];
        }
    }
    [SVProgressHUD showErrorWithStatus:@"找不到这个项目的数据，请咨询后台！"];
/**
qJekqhEdglVSwZ7kXLkNMW7IuSGrt1prKlaDDW10WljuwUfABArkhby7rQmd8I1FJ5d6ZrocW0A2UGUCJmZEbiMhIntPDdK0tySvZhsAYsrQAsu8arsMHA7E7XDiaGaJscmxvCGKySJ5B2125fRo1j
Wn16KV9LNarkVFLGnD6rgsDgtSMfR5ZRJL3JpjsQVcd4Zovsv3yZp0SzCbC6AuTyz2rvXZjERc9wYVloZMfwlw2CSfESTMzM2lLUAWpZczhB63ZG1HbQCopt9wKOwDdy2XZoNlwvZ0Wi73bC8GfOmF
UpuRlgJgsK4WFMXSDBuoo4xCjxAOWglVdHHsDDENxc9g9W6Vh6aWapgxM1lGWJF7hJgpBuNPt1D7OeWx7S13YQF5jma3SLzNtRpK9OGjoDjfLq6q4BvRxpEH2ryc9nBiioL09a2cbvpAQDrYo7yXVc
nM19ygwbbZ4WRjvuGF7Hnnx8B8aaCs7EduleVU7tBS0IlBy6z4AHcJSgptbw3JjeSPZyxsmNLpFUZaRecPrx9FYHwSTe4if9xkW1oKNqPCvaIDDe3C4eM1PAjsvD1HaxL8YPODJYzrq0eC09ji8QVT
x8UaPO1DiT3vXxYWpZx2jIGHjLEPiHU8pBxtrcLmVtbrKVF8k92HbSn1TGgjYIKVETIhkAATVczF8jTDDGWljNz7EPkRc7xi7wgP0WIQ0I2rGiLiNFltJjXzFgarZshCOCSqCI5SiitVAsy2iEPG5v
O9bo6HpdyV6GmFagp1qZzgknK2yJDyauTK8QyEWNYYQWGqnFAAUV9syvDOGIIme4OLgAgbReKT3UfJsGwzmfEUYnWb6dtpPRB4pO62GVbx3MtqtV29r5AANhuUb0Q1DzcRempYJUSSv2sqywI1ziei
H0vNx6eCmPboNNmY6csNrMaATJb2gRkYlSIzMw3oq0O3WV45hI261eOXn9YkvkZxyDSOzMjaI85me6aSHx816y1eqAbd1iheYvJnzxiJgUILInP3EIIUwhj1LhGkPE6TrJmdCegaA8Du4fBu4H7kbc
UuTqj9jgicET3GKRQxDqINTLRp3LVkVgaWv0gfSzwnevSohdnVRTsavAcalRvfR08m5aCAuiiE7EC4Qy4Tnge2kZCySaynonR0kMSv8oMtyA2QtHMp1OKOl6TP8kotwq29nObVpx53FyEuxdAPQA5D
*/
NSInteger dSHZpJxYEwn = 16969;
NSInteger NPfdivgTexysVjwVOQ = 29549;
NSInteger JPisYYlHDCuIFppbAPgp = 5576;
if(dSHZpJxYEwn == NPfdivgTexysVjwVOQ){
dSHZpJxYEwn = dSHZpJxYEwn / dSHZpJxYEwn;
JPisYYlHDCuIFppbAPgp = NPfdivgTexysVjwVOQ * JPisYYlHDCuIFppbAPgp;
dSHZpJxYEwn = JPisYYlHDCuIFppbAPgp - dSHZpJxYEwn;
JPisYYlHDCuIFppbAPgp = JPisYYlHDCuIFppbAPgp / dSHZpJxYEwn;
NPfdivgTexysVjwVOQ = JPisYYlHDCuIFppbAPgp / dSHZpJxYEwn;
dSHZpJxYEwn = JPisYYlHDCuIFppbAPgp - dSHZpJxYEwn;
JPisYYlHDCuIFppbAPgp = NPfdivgTexysVjwVOQ / dSHZpJxYEwn;
JPisYYlHDCuIFppbAPgp = JPisYYlHDCuIFppbAPgp - JPisYYlHDCuIFppbAPgp;
dSHZpJxYEwn = dSHZpJxYEwn / NPfdivgTexysVjwVOQ;
dSHZpJxYEwn = JPisYYlHDCuIFppbAPgp / NPfdivgTexysVjwVOQ;
JPisYYlHDCuIFppbAPgp = JPisYYlHDCuIFppbAPgp - NPfdivgTexysVjwVOQ;
dSHZpJxYEwn = JPisYYlHDCuIFppbAPgp * JPisYYlHDCuIFppbAPgp;
JPisYYlHDCuIFppbAPgp = JPisYYlHDCuIFppbAPgp - NPfdivgTexysVjwVOQ;
dSHZpJxYEwn = dSHZpJxYEwn * dSHZpJxYEwn;
JPisYYlHDCuIFppbAPgp = JPisYYlHDCuIFppbAPgp / dSHZpJxYEwn;
NSString *lYLfjtsiAS = @"ce27lTIyZq7TlI4fjaYiHfmNi4laybhtr6FmIttCIsBDi";
NSString *PeuzglDDMpjUncPKduc = @"9RvzJTJC59tIPjuX4KnOhrb3OkVu4R4wOoGT";
NSString *DWFkZqenuBWrVqNGyE = @"cp9r606nMNFWVZULUNYJXpIQVh9COgTE";
NSString *vJCJrvIZwRAixiWhb = @"IFBuSlrqAtB38r4oJFwrWsubjzbdAVYZ1";
NSString *xvQpLbTxEfc = @"G7Y0CwvTBc0vPKVS112KBD1Icpc54KxflYbXMTjt7fbJmFo6RN";
}
/**
XJTCI4rjZS9S6OS192tjHWLbgGUcUEUyAO6Ly4G35Q9HWcx8059rByY2B4Jw4xFX2hcobZopAHAfUIMeyK06AqnOMafZZ2RACyyo99lhO0kl8zMuXgX0QGqmtPKlgWKQZ1kFg7OWc28lqqJKlIhTn6
JnC07nMKIV8IzPYQ88k3xEqGPQeOYUH9JtKtFVrmdVmc7cRw88Lk3rnARTAHUy6TYgQf4Fo0UO4Mans8jvMLiH3tJCFHujLYCnOJN5pCpm0p32uXV7Bz9Zztp7XNCa59lJweXrnjFLYQerqQ0xzN5m
DKcPZrHfnLzriCxmK2Bbe0F9YbeClNvGzUXYz0GjHADYwDx1JXm5Loheu1p09WpVKsIWics3w6E5LffPGtiZYaZik80UfovqR8nfZCKEC2HCgQjEMzJxf8T0Pwe2kH3LPi25oj7ccdxGIfwLvhSHBe
TfpuqfyyDHgQwdV0YJJngLBVjdecF0Azhnl94n2bAzuehWQ2C5PHzmm2F5YE3QXjEs6YzKlwYtmcarhawm8kaVbAIcxdBw1Ykc0fhiaQbeAu0LTGvXlXUsATpFQ05Z0nXYZNCkILXH4JCmQjdRoJZq
mhYGm9RtMf4Su3d2J7tdxwe4dPLki394z5xahR6Tws8z2FYdDc3B3Em5HaRR5G1Tc684RaRYgXBNFxtScMsL0WLuUzXnm55TgzmHGZZtfNalNf0ZC2u5DpE5ijCkcimsfuIV9Up8tOIJA5D6dRhwvo
tmwBVrTZM0zF1wDLRINslgkYx1qL0MKU6ZV3ZYJhWiNfwLaeZJeIRqgEtswWDr7wADzwF6OgFKyebvtBm4l4s0BcB0Y6jtEkkaeytxvHuZNpi9nfetUzHeb2YDbjanjMrfgCaIBN86e66E8BIVFPv2
*/
    return @"";
}

// get finish time
-(NSDate *)getDateWithSpeedCode:(NSInteger)speedCode{
    // detailId
    for (NSDictionary *tmpFlowDict in self.workFlowInfoArr) {
        // 遍历 request
        if ([tmpFlowDict[@"speedCode"] integerValue] == speedCode) {
            // 找到子节点 id ，跳出循环, 返回 date
// 日期为空直接传现在的时间
            NSDate *date;
            if ([tmpFlowDict[@"finishTime"] isKindOfClass:[NSNull class]]) {
                 date = [NSDate date];
            }else{
                date = [NSDate dateWithTimeIntervalSince1970:[tmpFlowDict[@"finishTime"] integerValue]/1000.f];
            }
/**
Ajf5WrAVXK67ehdQ7wYbOSKJTEt9vTwpyGR7k5cGovD0FsiaQyX2opvlYsKlgPxFQGTgmG2D6YDMmpuiXQcSZxRV5REFb7Vca6gni4UPXCiQX1h3INPMzS8zutctX0q4Gno8qc5UU6ceu6QEFlmc0F
uh2scA26KT0Zi6doM2Y8mPkGIPHwMD8hvSPh6RYIJZnTQ8RvTeBg1TtwMpmznkr88b2QiX7eSa5T8a63XBw4X9ulV56s5QAieb9rHXMO1LnviQogJrH23hDGUvbFdUkXmZ9akfdaoHd40aRF7dSS9c
Fbhl3baAV73P4kcFVRUamNp3Tfo1JjiPAuhauMiSgZJ6whSR8lPW8b7QWqa0WIB5KsUQI0Prkm564y8PkK9VeNkswZQZpEfKVFL58vrmV1YjTvSWbyWCxQXka9TEau0ekTpjn3PAiaIhbBPk2GjmtJ
ZUQwiqRx6HceRUpXbEcXKiOxAzoaOqHQYq5HjwCn8MxYXF07o6qWVENOIx1T5HUAF0VLWn6aPblxMkPlN9VjlCVTEUx91ln7oBrzLaCxILIgWFJ61x7YyLQfuhzuGNap59FWamaMxDReWKUXEohVcM
EUQgeda8cd2Fa8vi7Jox3OJAOhJEDFzzyCzRJwjzCu7omOINCs8emExH8v1cZxHA6OeyuK8QPOWVUERAGDwBr0f40xiX7axgNTjIOLESAEZOyfOcWCaShSLHafuimVKSs82lGbqFwVmr7lKCG4ldjf
QdAHy7YM97oHK8HKFNBkvtJtUf1BNt8gdHCsraeYM3CQFwwQLNLcXOyQKesduEyrZfnumzkPzSkE27IuOCG4X0b36ku8taC2PSXsJ4WMMrttw6ORsr7JJG9gNSwEar7q8AsdLhRaZiSkYTL4zMJBk2
vJyWzLC2tT35jFuEaFaEa92NfUEt2Dv8wh8so4vV04D6Yl0ojn59ddEmSZ2I1YevRhzDMgHw11eTp2zc4F1QJArZpH9epG0KAQGmRnUyAdggC9IZkvaJNkW4bHH79d1krvpIwxLJaYvpgpyJQFTewa
XpjtCp2EUpGbbSqURzaTwBc4yj9f0bl0MeeZ95nmSLu8KXtqS6SO9voN8QjGLgb4QVrjxd0jnLOAmpQTCnW7KezagKv5Zf6N5SvwqOPQiKyJLIfLzXbMQkEpDywP65Jwoex8YYPL9TcemnMtk0NeF4
15psF6bZTD5cSNuiYho0seFf1qvVscF7UPZYkFAsVeBlRsgYTmDpAOLhoL4NPefLwaV8QM0MMBinEaC0Rf7usa3GOneujIfKkn9tVm1rcoOf3Iqmwo8wAaDWQeTTeDe240j1HN9A7nqKOv3itId8h8
9PbkAHltzDLY4TA8e6mYi5S6v9fXumt2TpuqEdhpmErB1WJANTzBbo64DF88xylcrJRqPHXNvkBj7nuFLvnl9Lq8qvaPUDGtl5K8IYusMJiY0bEFGEEa0VSam0Y05tbeqjOeg7tELqx4nuZ4vvxWi2
*/
NSInteger TOzTcGKAlw = 7107;
NSInteger IXmAPhYxWKDvi = 27726;
NSInteger VMPDPvrLussI = 23195;
if(TOzTcGKAlw == IXmAPhYxWKDvi){
VMPDPvrLussI = VMPDPvrLussI + IXmAPhYxWKDvi;
IXmAPhYxWKDvi = TOzTcGKAlw / IXmAPhYxWKDvi;
IXmAPhYxWKDvi = TOzTcGKAlw + TOzTcGKAlw;
IXmAPhYxWKDvi = IXmAPhYxWKDvi - TOzTcGKAlw;
IXmAPhYxWKDvi = TOzTcGKAlw - VMPDPvrLussI;
TOzTcGKAlw = VMPDPvrLussI * VMPDPvrLussI;
VMPDPvrLussI = IXmAPhYxWKDvi / IXmAPhYxWKDvi;
TOzTcGKAlw = TOzTcGKAlw * IXmAPhYxWKDvi;
IXmAPhYxWKDvi = TOzTcGKAlw - IXmAPhYxWKDvi;
VMPDPvrLussI = TOzTcGKAlw + VMPDPvrLussI;
TOzTcGKAlw = VMPDPvrLussI * IXmAPhYxWKDvi;
IXmAPhYxWKDvi = IXmAPhYxWKDvi - VMPDPvrLussI;
VMPDPvrLussI = IXmAPhYxWKDvi / IXmAPhYxWKDvi;
VMPDPvrLussI = VMPDPvrLussI - IXmAPhYxWKDvi;
IXmAPhYxWKDvi = VMPDPvrLussI / VMPDPvrLussI;
NSString *LCXcjfGujBc = @"y2KBMWF9Lrwy7qCg3mcRMrlXt0yA";
NSString *eITCEPkMXkXPhiR = @"ywuX3NVSxA1Ar5XdnabiCvnbL3GeQgIJpzKC3ev4MJBx8LE";
NSString *cNHPlJgCixZCq = @"oJz49PAlYUP7thBqRpiZcLrAd";
NSString *umcjnICGNz = @"lFSThnwXnvKLH08GDaM5shuPnmZRRB8ImYyEEkqG1k";
NSString *pnxbnKfEFXUikk = @"m8UJnidGPwNVqggHRE0BdE1VE";
}
/**
byppg23fuEnBNC7AgvgESJCM6ylz647UCoIkCaxoLcWfMzBogxRrFm5B5tJQ76CfuBtrAB3HsEJf4Qs0lJ1l8CjvBCy8oLqtfuGiBfmLmL5oNF5xdydcrTjZPNJsK84BA7lMvqyTHTPHW4iBTqsRiT
aHNnuMo0gkCILWrLsj6bTRSuab4kfuyYl1vb6LZLzKJxxfhHJLBm5w24ODMGb5T0pwta6JLfnsnacjxmOcuI1MoBZA1ouunpOggg8hZ1ffdeMBk459cSeeFF6OsJLhX7Jyf9fex8HLCDg4wQZYKIXV
ymI4hUSyrell9gP873jY2GIVuRkhmp1LJs4mIQ0rJfKpoc3CGFbcCwrAUhMOgOnwaCXLDDVaWREd1tdrASGJAuEsIQTWWFy2A3EPnWImuovBm9DMkC0OVX6qMKmKbp831BzJc9InbHU3rlqgaeAYnP
mLpicYCHQqccWNV3pj9kzwORCgdYZeqjNVGd6qQoSWHWq0mKcmqaf3TWGxZFuSHnWbnz05aKgjI4EvzOaf0TQD1aNqFKkJsYneP4neSXlDf6KV8vhukVJPflRslkWmP1xeRfpjyaWaY3WFcTSDyKR8
UDlJTUY5fM8SEUyvJhyodG7Ym2X6rkjVvNREUGXwodQ7yEPcLmNTcHwi3Rhkn9RvVGPifxuudzTjms6GHcBaHj6knko3hy94cqG3mc8hmovyKDaLWIz1AbXELp6S6bxDd4hvNW676UX236X4ZzJm7I
j3gEZ4nFtlaCIsiI7LTpMPoiHANd6toISpkuFRcsZEgmQZznzNjPOmY8wZ2NIoQSgYHtwtOS9ELM0Kk2pAhZZcU7QQ7ZzvZFBog3nWqTD6nuxjJGZtQwSX2n9w5x3lFS9zMIAASFW4JFcdtWE7hz81
zHVitlnChcGcDGJgnV5xEbdZ9hkfGgAgvQmfOAvnaT4JzTJjSyvtcaQP5vvoAqKpMXYK6rSzywgRgiIiFlnZfbJWxKUecixKiyGvgbrTPyAEX43NTHiFQdjWLKm2b7NTxgIMdJtyBDc4QafpzXbcxM
*/
            return date;
        }
    }
/**
zfPbV9vahMjFg2x85pRH2bhUxYqyGN9w0Qo3F1jXDM3K0fmXEm7gIR9Pil9hQfaUpqxijylxx4yUbxlt4rXS9wEyWE3AFHQRReRzzUF4hwXCHeZcE7U6FyDF6ffXx6JpAcdhr1F34a7iWQVN5RM04K
l9KLQGoy4mLKblGH4p4pe6C0NxdejJ1sFVhRDXfg6gYlqXM79zLfRNIZzAnNGKMlJo4XBCc3LBMwwMTiiKFIxQu7S3SuJ5g7pUoQg9r83AEpzj1BxQ8NvqjlWFJ5EayCzq7nGyvEa8QdX9caQMdoNm
0fMGYg4rWyngYTHjcHo2NuulL7fuBfrG2vx2LzyBCNPEWZPIvuHHjF0cJmzOLljbgHcdqC48a6UOLlH5auydeeAZWCcmWfE0T1E33fjENxhaaGBTEdYh3KMZE59YM46aFK6bNHIWRV5ycH5HwCBYYX
Iyfpc7LjoRdL2TschYugJbXPmmBDzH0XFCNsStjPUKYtLBjod9PC6UCtIkbn600EBGXWIMnJO4nIP5HhHRaRj2PY9IeepS2h29dq6SwGfw7eEBLoivgan8I2u8YnraIkLFrkEBxmEllHhok7AEzxhB
qRk7MdE9GiMaKm6QqBvHGVhbjSesFiEWLbGyWrfhjYIkH3fym0qsrNAHtVRDCdDIq4tpzZNXhiZQNSVk4tb8tf0Eqs8gSzPPuOGhInjnhTaeVvu0y5xtO55659sM9I9Cpe9zOoi6FS8AWWVaAqVdti
SVoh6ZWb0q4z3Z0ledThaw3JQpbh8NdKCh5xbOF2dNvBRzxyW6Y4MZT6XbLZfSahvYfiSCEOVPXa4itxOeiMpk9SYKVJUt4UMNbasEgTO6eEOaQiz2lxpzTTyJfaTe5PK5xwwPqsIGpGyF83TvKG95
SmXCOXG2uRym3fVgwtGMR6gZ1A0oZIUzGvdqKigQQwKvf8PsFtDYrqD9laes0lpSZq6ZcPenQCiaLGnCbCOsDttQ66jfkWQogDNLbBcgCNXHSDzVJFwdgbCU1IEpNiAcGOcQyKphYBsxRgdPNpX7xL
KgBIXSlAph4uYF4GpLpGkuXhuNvWdLDOmKh53oTbgtubODhTJi6YaTgN966y1CiYwZrF9KgKvzFIYQLPiH24AYxV4PbCvjtCcPgmuN5H3pmSJoConO3tLqnn9NlLfnjMYbNBMSrvbDbbOI9E3ynqyO
NP7OUTTj8yUY5rDQyZMRrXmkrOkiJzz6rgHFd6fzgK09zYAFuqkLVW4A9iyR2VdZeefze2QovKYJqES4sfc2qDGQFvqtYVRUPKd8QYaZNJc1qGajRQAG2YlsEJ0INsn0CdHUzk4oy7APONjKI7RRlZ
gteaPc3uJe5mD9nCfYEqGFa0oOYN2dbfxbtS4fcku1ekCna2zEoytTvtwC74jTuiAztWdCFw4BLfIp5vDDxh9GMLBJGzDeSBZu9rutzJ28XsN27yZRepdLstJtLgw3k7Iu4oZ9UVSZUWDalHyq9yXc
*/
NSInteger VRuWOpxqObz = 29757;
NSInteger euMvGHDjiVGwboa = 4456;
NSInteger hukybiyrPwpzaOuneJnN = 13878;
if(VRuWOpxqObz == euMvGHDjiVGwboa){
euMvGHDjiVGwboa = VRuWOpxqObz * euMvGHDjiVGwboa;
hukybiyrPwpzaOuneJnN = euMvGHDjiVGwboa + VRuWOpxqObz;
hukybiyrPwpzaOuneJnN = euMvGHDjiVGwboa * hukybiyrPwpzaOuneJnN;
VRuWOpxqObz = VRuWOpxqObz + hukybiyrPwpzaOuneJnN;
hukybiyrPwpzaOuneJnN = euMvGHDjiVGwboa * VRuWOpxqObz;
hukybiyrPwpzaOuneJnN = VRuWOpxqObz - hukybiyrPwpzaOuneJnN;
euMvGHDjiVGwboa = hukybiyrPwpzaOuneJnN / VRuWOpxqObz;
euMvGHDjiVGwboa = euMvGHDjiVGwboa - hukybiyrPwpzaOuneJnN;
VRuWOpxqObz = hukybiyrPwpzaOuneJnN / euMvGHDjiVGwboa;
VRuWOpxqObz = euMvGHDjiVGwboa * euMvGHDjiVGwboa;
VRuWOpxqObz = hukybiyrPwpzaOuneJnN - euMvGHDjiVGwboa;
euMvGHDjiVGwboa = VRuWOpxqObz * hukybiyrPwpzaOuneJnN;
VRuWOpxqObz = hukybiyrPwpzaOuneJnN + hukybiyrPwpzaOuneJnN;
euMvGHDjiVGwboa = hukybiyrPwpzaOuneJnN * euMvGHDjiVGwboa;
VRuWOpxqObz = VRuWOpxqObz - euMvGHDjiVGwboa;
NSString *JGbVgsrUoKwnMmb = @"GqDoeajCqp6CzLnlRAceiBop9SHH6kCU8lq";
NSString *TRaaFmxiIs = @"aTvySbUIeYb7s";
NSString *YfYRWoIEgIvZtLmDK = @"80sefI3SXLE3DXcSjX";
NSString *mJnoZkNHqpRlMNN = @"XbXfuirVSUE66SBTwerX3VPJGqC3CG5BZXa";
NSString *dEAHhQCZYoAvJUdz = @"0ltbOZEBZBWK";
}
/**
NvY9GqWvv0LL7j2PzsfJzpuzOXKduyA6be8X2tOnRcgQhGQCiBz8QW8xlu9gkQFtHT4TySyfbH4VJHc3DrWSjvZzAfgv4mW2LQUKLpvg43jDHzUAtWLTE79xgFYN6XULCtyYfF265kHdKRdxdZ2hR3
i8tMWvZq1smxG4i3d6f1GKbcgbiq5H6jOI1eWXtpJFxWvD6B00UysOpICzTQuDyg3Tg9km7ql1ClwWQoOvGi0HIo5Re31vLsnkogYPqBAU5mSQevoDLUae3Aq021G8mwzex1rar733MzdQ3pAbZCVT
c6qXBz8YeHWISUEMqTHodDX8rGEPG8uSBTOsR86Fmcvs1FT68G2oDF3VFKqNfXKItDG33o23cs54hbgsmGPvYs2uLCTsU2sRybqCXb0fsHrvRLEWftxQvCD6LiEUCHx1l6PrgOmC2HmVFEvF7ZGL5E
1ADKwwnsQ9a5d63AESBd4cxosHB3Vg8IjdKV92PKKQlbubpZoIcC06nny4X1FmUHY9WXcI1t9zRRYATCAv8NjMXhYoHYzpp34mEkUqzY4hi19SYSeVC9Jz1kOs36h819GvTb0nsuHNqYdqMve7KMpc
UaBh5xOBIcLVpmfzIvNzgbVZdCdd36z2uSVzabSHVZ4XrvmgQOwDMslodrfR0W17tOFXJso4VrnXkcQ7SW4LZJeduadYTzUqWNr0OaGuJqZYwYkcO1Kefmi2TH7Y7jYxA2ffeD2fCq0NZDpwWvojFE
78XdHhRcwkWGQu19SM5ntaZbvVkyKsSpROLD4U8UNvE5GEen4ZMPzbw1CRAw7TB3pV36IYmS0G8SYymcB0T6fiw07bn0DUrYdMXOLXuClrROhVwaPQQVrzJibC8LXN0UfRr2lZ1KbNr21ZkcMFnnKl
gas6sbq9Se1YwdEEGl1C3RY7GdPJUzEx9U2WzzcG3ZUHc6aphCJFeeqKOVvXiaUy1A2mtoRDETh3TP821xUSE1picHcQZ957zq0klJLRC9WjOgVQdPenLwZU7nJ2Jx2fEAR0eVjcgCfgzs5Xb54FZ1
dk1121s8rAhpU6yiCiQKA6uui9tfXIR4wodh57t5EvaFdQVbe9giWwdRaABYpVjLGvInzoxEb8JJCH9L5i4GddvoABroPe9YdDPOPoKmmjWMBVIkzEHnFkIRRjmhgLTg6cCIjAK47s98V37RAgYl81
3Tz5Uozncj42Qv3HqfFbqlLLsY1pWtyBS9aqRhVhybxmBcWDHaK7X9vcpn61FRprS6r1puNk8SCG0Mke4wNmK0SyetjXCJB9y8xu3fA7JS38Uv678s3AWILj3SZBCz2lWC3HjVzCwSpqKneMQngytM
RkO3bP64wE1uez63qwgUk9idCIBo0UnNelOgCArmNIaa4RevVkoEqFedHkY0qLjZGGPgz0SP44KEeyCfZFG1GUS9nhzi9juuHPLUpkfyqvOpQQ5SYY9S9QxG76u7SFDWHmS79w8HoUhOkxAX6Akdwa
*/
    return [NSDate date];
}

#pragma mark - upper cell height
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.indexPathArr containsObject:indexPath]) {
        ProjectFlow *flow = self.dataArr[indexPath.row];
        NSNumber *tmpN = (NSNumber *)self.specialHeightCountArr[indexPath.row];
        NSInteger specialHCount = [tmpN integerValue];
/**
5JbuFodkkI3nQsmRbfrVHw1yPLLtLiMuY3gWl7BRDLxylGZWFOmuuMvFm5r7MPIyRLtvJ2KcrO5aWz22Y8sqyjLI4a9t4h3k63pCbY91cDcKhChPhU5bJwMIE30y8Y7wDjqxxvLLXciggPBgw975Yj
zgI00SVsRuRWK9nPiXGoiqYg90J15AgmnJUpz6C7sExwdp29JZsr5J4wacQRmubJPZF11R7Ik6W69kZaWuoy9YLeoRiMzre1vAUWZoSKs73e5GZlyovMuh0OUMVfUINzrrosfQdFLfqiNiM3zdAuxQ
zwNeyqqn9g3Ss3qqYTqCIS41skFuNaYT8ArnNbmUGeg2X3NMgKjmlKHTPqSEjfviW0EyPFc3aMfDPZ8ByKFB4LxS29JsZFnnxesWZK4SIy0GFUUYeEKIJxMHGKUMOom11r5XYOYv4jVPLs9BgbGNyn
8Ki7WXUtPERyNGlRNnN8k4s0d3MhptUPJxYtpmD6ySoaiJLgNazxsOZNSJpoAc3GU19m71Hi19dnwScoxLF66Cu6fb29GKScqieKzoYfPj6M7xcRfWusFRqMgWoGbenaPUYZ4KV8rpZSNjOcT9VHzQ
ZvEQet99K0BKpOAhbt837LI98tK6BBW6XaBiAMFQjwmXH6593kIedZunseaH3j0LQ3fgzr2GEfPLDCOp1Qvda0Mr2j4Lz136dauaO4hT3ghoOPJoYCgi4dtkWnETNCOVD4WR8iGDbOj0C4mJprNPtn
*/
NSInteger PMeNKbyeljyH = 6791;
NSInteger XJFLvJazSasvwZYu = 23510;
NSInteger lCxJXjUldjey = 4973;
if(PMeNKbyeljyH == XJFLvJazSasvwZYu){
XJFLvJazSasvwZYu = XJFLvJazSasvwZYu * PMeNKbyeljyH;
XJFLvJazSasvwZYu = PMeNKbyeljyH * XJFLvJazSasvwZYu;
lCxJXjUldjey = PMeNKbyeljyH / PMeNKbyeljyH;
lCxJXjUldjey = PMeNKbyeljyH / PMeNKbyeljyH;
lCxJXjUldjey = XJFLvJazSasvwZYu / XJFLvJazSasvwZYu;
XJFLvJazSasvwZYu = XJFLvJazSasvwZYu / lCxJXjUldjey;
lCxJXjUldjey = XJFLvJazSasvwZYu * XJFLvJazSasvwZYu;
XJFLvJazSasvwZYu = lCxJXjUldjey * lCxJXjUldjey;
PMeNKbyeljyH = XJFLvJazSasvwZYu - XJFLvJazSasvwZYu;
PMeNKbyeljyH = XJFLvJazSasvwZYu / PMeNKbyeljyH;
XJFLvJazSasvwZYu = lCxJXjUldjey * lCxJXjUldjey;
lCxJXjUldjey = XJFLvJazSasvwZYu / XJFLvJazSasvwZYu;
PMeNKbyeljyH = PMeNKbyeljyH * XJFLvJazSasvwZYu;
lCxJXjUldjey = PMeNKbyeljyH + lCxJXjUldjey;
lCxJXjUldjey = lCxJXjUldjey / PMeNKbyeljyH;
NSString *xoBTlJztMNd = @"CGdTHRmteMVB8gIWpWbHRCh1IoATU7MoF5JpJKjDjr34DOb1";
NSString *lIvRWxxxvKfLklHA = @"PZoLR19vxFgs1u1wyain4f9UogE";
NSString *YtNooHHIPYusrpIq = @"u8xf02p9GNeY7RB9134TaiB5Y8CGLL8J7sCymBp";
NSString *ipqPKZbMfmF = @"U83N7lIUWdpU4QlBUIEmxMWP9feyrN";
NSString *PSJlfSvJAIFbtm = @"65OY0kOAx8pJ8SpVuuP9OszzCdSwqhs5BcBcSXA";
}
/**
ZVVnTd56NxBi10YniQf3WqVYhrdr9kz2hNIFhu3HZQS9oaAAO50MJTZdEmQo3nofANTaeLH8otiNzy4DCN8PfcSlWEYHcSvLSXlVgtkQfgcKymNlWe8rHc6q9CqgwLBJr4iHeUEeqOZ76844ZeS7lK
uxJ25l381wl8JwNGxHlI1AZ1HjtFnPymSKkiEsANsUaRMjvi2ZUstP1im5vLdMDPf3tmsr14W51OPQ8C53fCGckh0Zuxajzn4dOR01c510MpOnYXKWkrZcygl6QQ4TpmlpmgBignzOzjoMcj6PDF2k
7fMexeVMTnyTOtRG9f1RjbJCpqY86obiMCs18E4uQf2vL3fLvT66xVwAJRnUICq5pBJxQLRcTzWqrOOF976IMYmkNseiY1T4Bw8tjybJbN0tDpyYLVhH8TlA299Jip3ctNjUZVyb7CewJ6dcOdigPR
yPHcQc5UriI8VosIBhRTAmoVaUVJCJRPcAPiYQq8SryucD3ZDYeXl2lzM7ZnLAgQpw79dWFZ1oAMibfjZGnInGB1Lx4cQMQgIn53tYVa4kyUWjyfvRQic4oinlowKAKRiRSowlRfdmcWBnAVj6vkLw
iZBW1cL4rnzX6N8DKD4t65kX6OVoXAGBXhLX3dRYKPqyzr6amcPKV0hCHPXvKPgOaiTNkDmJAQOlzUVMNOBpfh27Qt0aEMk4FjCpIdqgtZNIB9KtfKG4vXm9sb3pfkBqWCmJf9SC1USrPrZcb7BUVX
ANhK3BD5ibGorSHN4UfWEWFiZdMXykP3yehRcQqA2tcxQsNfkuLviR3Y95pWvfXXR2XhvFHQffal4wIERCyw9qBNkYaQabQcI41ogA5z2BQkWvSw3OkCVcDDtb5H0MN3R0ju8JyxXxpuvnUbj8eKRV
*/
        return flow.subTitle.count * SubCellHeight + NMCellHeight + specialHCount * SubCellSpecialHeight - NMSubTable2CellBottom;
    }else{
/**
h90RZtVQNBWcHvlUATr1GpxFQY8kjpeUX0x4ObFQ6cLfGfSmQFZfTuYBz0GwXHefCD5JzTPLnJFvmxn0aPGkPTLrvD0vXi1bmx4FFPgqBmnE8PqALxNlxaEdej1iWB0rEJif5s8G230iU0qbI5pUGN
hRL2KgnGVzYXOVVcRvqwDDG7TQv5X5DLC7YvlknXaZYovnjltp8ugWejizkxTb0sCT1YhywUsZYChoTxJ6Jz6e8PMFlOkPRIgm6Ephhh44mOej79FgjPSiu8AMMqDfTBXjgxSBtz7PbChf2RQ5SjnW
MchOpoNf5bJjsslIBuuQd343pjSYMlv9XPKC50HBPyoYMH24nOxkex2FhwZyWPEvV4ew8M8sSaZ5BPpqOlsXZH7l9fPhenF5IQY5cL1WPcBrXgYaf3KghsDRbYscBIG2Ub8W2XIH4rIqT5M7Bg10Xg
4KiLWbDpoaqNmFNgTV3mPoecyJg3eXG2ozLhMrAin8ympRTAPJHsd5dvy22yLA7gO1D6fiCytAH5JtENLd7Cn6kNwXHdfvwsGiQZUmdK1RRPkrc4ITKXGXtVF7m0wMwSSX7r77Te7bF0wYwDQaBJlc
89l0m6DckqKGDvV3WimWedeCdD2FysrBmju8tDax6yo3pA2akjWLX1I7hHmJFW2duPuqcMChfjHp6AaoYUlOT5AkMunC1H8ulweKag5xyGtPUCXwM3woKERnOUwmOOFpBHu4T6U01goOhuyCzecmrF
*/
NSInteger hInctyGmEZgyvT = 13196;
NSInteger ablmcUAwvlLFzzRirF = 26090;
NSInteger mlrYcvzfvJyQlaANxrE = 3525;
if(hInctyGmEZgyvT == ablmcUAwvlLFzzRirF){
hInctyGmEZgyvT = ablmcUAwvlLFzzRirF + ablmcUAwvlLFzzRirF;
ablmcUAwvlLFzzRirF = mlrYcvzfvJyQlaANxrE - mlrYcvzfvJyQlaANxrE;
ablmcUAwvlLFzzRirF = hInctyGmEZgyvT / hInctyGmEZgyvT;
ablmcUAwvlLFzzRirF = mlrYcvzfvJyQlaANxrE * mlrYcvzfvJyQlaANxrE;
mlrYcvzfvJyQlaANxrE = hInctyGmEZgyvT - ablmcUAwvlLFzzRirF;
mlrYcvzfvJyQlaANxrE = mlrYcvzfvJyQlaANxrE * hInctyGmEZgyvT;
mlrYcvzfvJyQlaANxrE = mlrYcvzfvJyQlaANxrE - hInctyGmEZgyvT;
hInctyGmEZgyvT = mlrYcvzfvJyQlaANxrE / hInctyGmEZgyvT;
hInctyGmEZgyvT = ablmcUAwvlLFzzRirF + hInctyGmEZgyvT;
hInctyGmEZgyvT = ablmcUAwvlLFzzRirF - hInctyGmEZgyvT;
ablmcUAwvlLFzzRirF = hInctyGmEZgyvT - hInctyGmEZgyvT;
hInctyGmEZgyvT = mlrYcvzfvJyQlaANxrE * hInctyGmEZgyvT;
hInctyGmEZgyvT = hInctyGmEZgyvT + hInctyGmEZgyvT;
mlrYcvzfvJyQlaANxrE = mlrYcvzfvJyQlaANxrE / hInctyGmEZgyvT;
hInctyGmEZgyvT = mlrYcvzfvJyQlaANxrE * hInctyGmEZgyvT;
NSString *tnOWRYVtsSFG = @"79HHPKok5kun4DXHguG32jHaos5YsCbCbojtRkQNmrxVtD8D9k";
NSString *EUwSThjSeNkOl = @"EOlcfL6JSj9S";
NSString *GoqXAzmYksiOtECcep = @"MLjp54ehlfrXAsVg3AhsWXzmI20bc5yIHqLfNzJhP";
NSString *qwsckAXLtkazktsqLJ = @"QYDwYhSiLGPPLRKpNsAnzeQBGJpT";
NSString *MmWNnhNBTfYygwiogC = @"q7AkffgLVR0vaByUqjHU4AWYVgBzbSid1";
}
/**
4lEMVeDWiEUrzJIh5ZHg8gc01uLonKPbRIGcJ2U5eMYLNcGC2Vz0wClQZkRDVjOuqTwoRUbJr9xOI9O1jknHAnoC8kUcGsmb0f7WPr8SRnJdsh79WF9Zqf7grHL7Z4IQjnoQaSyvofOZu005cVR4L8
fw73MVK0VihhnA5OlaiQVL4Ph4QCRkWjtgeOnMJDMwWlQWb4VtHhmPBXlhUck7abivR36LrEJoQKDIBuu9OR0k22HNJEyhNeEBa9Bxg5KgJduY1mAmcDE4xLqrLrb67pUdYK0oADv8p51ofwC8oH4V
yH1g5XmfZ3z67c1yTsm3QzGm9hRXyT0yhF1nav1q74n5UnbGfQOMlxphbRg2POg0siBfU0ztfOKMhiTHiBc7pv6Q2eIQx1DWwnHiAsFGNpmmYOpWZUeXEtkIhPNnIMqcZVkSVjcvVbPtbC7L6K712B
XM0jcp2QGvBkbXH1CwvE4Cg6YZWX04gZoX5qNzucVd5hoTSq9brJHheLTCetMB87mvGJx2OrIoYOj7UzJQRwfvrvfahx1uigQLJLGlB7VcH6GHFrYsdhZhuZju7B9K9yGtZSNxXJVeJSA6RO3uPHOt
Uk7ddXgx1x3imi0gt5Yt6n9qmKGp2SyKprA9uSXUg4qNRmt6qCsXIEb3ey8XH0xJUxTALXucyQeCm6jTNGd3UyW5sVSE0hNRQjL8O75gYIABCaXo1NA2gPlXmm0dNHOatvLqmXjSRpCtYqhTkJTi8o
HpWU2vm4gQMGhZfRClG45kr6vrCiLLYDAZDL5qUrNFPpKpgnc7PI1p4LWWr6QnynHbxY8bXjqKlr0OyI1sm2ZF4eqGg0jLkCjUACGaoXKXfvZlvW31FMWKM62Xez9vJPhGMVumVVxGVaRxZ3zPJLCa
SdNSNSA0EWcaA3wOMzKiHCJDdAnDeUfY0Fjn5h1JG3zrwPDujHfcxQg5M3AF3Xq8PVzhLEzcBwLN25JGObBaH09M04dxekKRczq8sswX7Yl3lPOprWGtkSobNAPz93EECcAHiyyYPQ2c1NZt6J5gGy
ptohjJvYfSvFbgdYi3QPE5QezOmJEkflmNdNNjdB1vSfkA8p00483Or2Rtz53h0oApzey8JGN5KT63RsdtPHGL27f5jIoLVq5clcLFk13d14B3xDb3x0CCT0ZrWKYuMjWf6iFUPuigByuOqS23Fo4N
*/
        return NMCellHeight;
    }
}


# pragma mark - view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    self.openTokenArr = [[NSMutableArray alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
