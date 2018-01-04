//
//  SubTableViewWithinCellView.h
//  MingYa
//
//  Created by 镓洲 王 on 10/16/17.
//  Copyright © 2017 镓洲 王. All rights reserved.
//

#import "NMRoundView.h"
#import "ProjectFlow.h"


@protocol ProjectSubTableCellViewDelegate <NSObject>

//-(void)shouldPerformSegue:(NSString *)segueIden withViewType:(NSString *)typeStr;
-(void)shouldPerformSegue:(NSString *)segueIden withAttributesDict:(NSDictionary *)attributesDict;

@end


@interface SubTableViewWithinCellView : NMRoundView

@property (nonatomic,strong) ProjectFlow *flow;
@property (nonatomic,strong) NSArray *subCellInfoArr;
@property (nonatomic,assign) BOOL enable;

@property (nonatomic,assign) MYFlowStatus projectStatus;
@property (nonatomic,assign) NSInteger speedCode;
@property (nonatomic,assign) NSInteger sectionNumber;
@property (nonatomic,assign) NSInteger activeRowIndex;
@property (nonatomic,strong) NSArray *authorityArr;
@property (nonatomic,strong) NSArray *finishArr;
@property (nonatomic,assign) NSInteger isHandle;

@property (nonatomic,strong) id <ProjectSubTableCellViewDelegate>delegate;


@end
