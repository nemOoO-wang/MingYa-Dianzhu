//
//  ProjectSubTableCell.h
//  MingYa
//
//  Created by 镓洲 王 on 10/16/17.
//  Copyright © 2017 镓洲 王. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProjectFlow.h"

@interface ProjectSubTableCell : UITableViewCell

@property (nonatomic,strong) NSString *status;
@property (nonatomic,strong) NSString *time;
@property (nonatomic,assign) MYFlowStatus projectStatus;
@property (nonatomic,assign) MYFlowActiveStatus activeStatus;
@property (nonatomic,assign) MYFlowCellType cellType;


@property (nonatomic,assign) BOOL need2BecomeAlterCell;
@property (nonatomic,assign) BOOL completed;
@property (nonatomic,assign) BOOL activeBlue;

@end
