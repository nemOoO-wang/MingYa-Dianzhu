//
//  ProjectUpperTableCell.h
//  MingYa
//
//  Created by 镓洲 王 on 10/17/17.
//  Copyright © 2017 镓洲 王. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProjectFlow.h"
#import "SubTableViewWithinCellView.h"


typedef NS_ENUM(NSInteger, ProjectSubTableStatus) {
    ProjectSubTableStatusOpen,
    ProjectSubTableStatusClosed,
};


@interface ProjectUpperTableCell : UITableViewCell
@property (nonatomic,assign) CGFloat call4Height;
@property (nonatomic,strong) ProjectFlow *flow;
@property (nonatomic,assign) MYFlowStatus status;
@property (nonatomic,assign) NSInteger activeRowIndex;
@property (nonatomic,strong) NSArray *authorityArr;
@property (nonatomic,assign) BOOL hideArrow;

@property (nonatomic,strong) NSArray *finishArr;
@property (weak, nonatomic) IBOutlet SubTableViewWithinCellView *subTableView;

@property (nonatomic,assign) ProjectSubTableStatus subTableStatus;

@end
