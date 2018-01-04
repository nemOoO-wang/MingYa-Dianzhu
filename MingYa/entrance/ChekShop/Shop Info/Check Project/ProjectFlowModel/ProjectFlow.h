//
//  ProjectFlow.h
//  MingYa
//
//  Created by 镓洲 王 on 10/17/17.
//  Copyright © 2017 镓洲 王. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef NS_ENUM(NSInteger, MYFlowCellType) {
    MYFlowCellTypeNone,
    MYFlowCellTypeNext,
    MYFlowCellTypeNext_UnSelectable,
    MYFlowCellTypeCompose,
    MYFlowCellTypeCompose_UnSelectable,
};

typedef NS_ENUM(NSInteger, MYFlowStatus) {
    MYFlowStatusDone,
    MYFlowStatusActive,
    MYFlowStatusToDo,
};

typedef NS_ENUM(NSInteger, MYFlowActiveStatus) {
    MYFlowActiveStatusDone,
    MYFlowActiveStatusActive,
    MYFlowActiveStatusToDo,
};


@interface ProjectFlow : NSObject

// project name & id
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSArray *subTitle;

// init
-(instancetype)initWithDict:(NSDictionary *)dict;
+(instancetype)projectFlowWithDict:(NSDictionary *)dict;


@end
