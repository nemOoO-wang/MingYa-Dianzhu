//
//  SubTableViewWithinCellView.m
//  MingYa
//
//  Created by 镓洲 王 on 10/16/17.
//  Copyright © 2017 镓洲 王. All rights reserved.
//

#import "SubTableViewWithinCellView.h"


#define NMUsedWidth4Status          221
#define NMSubTableSpecialHeight     63
#define NMSubTableNormallHeight     41

@interface SubTableViewWithinCellView()
@property (nonatomic,strong) NSMutableArray *specialHeight4IndexPathArr;
@property (nonatomic,strong) NSDateFormatter *timeFM;
// true 表示本 section 是 active（蓝色）
@property (nonatomic,assign) BOOL shouldShowActiveRowType;

@end


@implementation SubTableViewWithinCellView

-(void)setActiveRowIndex:(NSInteger)activeRowIndex{
    _activeRowIndex = activeRowIndex;
    self.shouldShowActiveRowType = YES;
}

// pre set time formatter
-(NSDateFormatter *)timeFM{
    if (!_timeFM) {
        _timeFM = [[NSDateFormatter alloc] init];
        [_timeFM setDateFormat:@"yyyy-MM-dd HH:mm"];
    }
    return _timeFM;
}

# pragma mark - set status
-(void)setProjectStatus:(MYFlowStatus)projectStatus{
    _projectStatus = projectStatus;
    
    switch (projectStatus) {
        case MYFlowStatusDone:
            //
            break;
            
        case MYFlowStatusActive:
            
            break;
            
        case MYFlowStatusToDo:
            //
            break;
            
        default:
            break;
    }
}

# pragma mark - special height arr
-(NSMutableArray *)specialHeight4IndexPathArr{
    if (!_specialHeight4IndexPathArr) {
        _specialHeight4IndexPathArr = [[NSMutableArray alloc] init];
    }
    return _specialHeight4IndexPathArr;
}

# pragma mark - setFlow
-(void)setFlow:(ProjectFlow *)flow{
    _flow = flow;
}

// get finish time
-(NSDate *)getDateWithCellName:(NSString *)name{
    // detailId
    for (NSDictionary *tmpFlowDict in self.subCellInfoArr) {
        // 遍历 request
        if ([tmpFlowDict[@"speedName"] isEqualToString:name]) {
            // 找到子节点 id ，跳出循环, 返回 date
// 日期为空直接传现在的时间
            NSDate *date;
            if ([tmpFlowDict[@"finishTime"] isKindOfClass:[NSNull class]]) {
//                date = [NSDate date];
                date = nil;
            }else{
                date = [NSDate dateWithTimeIntervalSince1970:[tmpFlowDict[@"finishTime"] integerValue]/1000.f];
            }
            return date;
        }
    }
    return [NSDate date];
}

// set delegate
-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
}

@end
