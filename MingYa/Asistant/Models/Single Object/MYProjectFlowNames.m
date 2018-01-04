//
//  MYProjectFlowNames.m
//  MingYa
//
//  Created by 镓洲 王 on 11/24/17.
//  Copyright © 2017 镓洲 王. All rights reserved.
//

#import "MYProjectFlowNames.h"


@interface MYProjectFlowNames()
@property (nonatomic,strong) NSArray *dataArr;

@end


@implementation MYProjectFlowNames


// shared instance
+(instancetype)sharedInstance{
    static MYProjectFlowNames *flowNames;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        if (!flowNames) {
            flowNames = [[MYProjectFlowNames alloc] init];
            // load arr
            NSString *pathStr = [[NSBundle mainBundle] pathForResource:@"ProjectFlow" ofType:@"plist"];
            flowNames.dataArr = [NSArray arrayWithContentsOfFile:pathStr];
        }
    });
    return flowNames;
}

-(NSString *)getNameOfSection:(NSInteger)section andRow:(NSInteger)row{
    NSArray *tmpArr = self.dataArr[section][@"subTitle"];
    row = (row == 0)? 1: row;
    if (tmpArr.count-1 <= row) {
        NSLog(@"后台存在错误数据：节点schedule");
        return (NSString *)tmpArr[tmpArr.count-1][@"name"];
    }else{
        return (NSString *)tmpArr[row-1][@"name"];
    }
}

@end
