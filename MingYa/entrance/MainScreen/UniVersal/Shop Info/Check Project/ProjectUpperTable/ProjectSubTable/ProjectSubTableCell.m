//
//  ProjectSubTableCell.m
//  MingYa
//
//  Created by 镓洲 王 on 10/16/17.
//  Copyright © 2017 镓洲 王. All rights reserved.
//

#import "ProjectSubTableCell.h"


@interface ProjectSubTableCell()

@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *leftCheckLabel;
@property (weak, nonatomic) IBOutlet UIImageView *indicateImageView;

@end

@implementation ProjectSubTableCell

# pragma mark - auto set subviews
// cell type
-(void)setCellType:(MYFlowCellType)cellType{
    _cellType = cellType;
    switch (cellType) {
        case MYFlowCellTypeNone:
            [self.indicateImageView setImage:[UIImage imageNamed:@"myAnno"]];
//            self isUserInteractionEnabled = NO;
            break;
            
        case MYFlowCellTypeNext:
            [self.indicateImageView setImage:[UIImage imageNamed:@"next"]];
            break;
            
        case MYFlowCellTypeNext_UnSelectable:
            [self.indicateImageView setImage:[UIImage imageNamed:@"next_little_white"]];
            break;
            
        case MYFlowCellTypeCompose:
            [self.indicateImageView setImage:[UIImage imageNamed:@"bianji-hui"]];
            break;
            
        case MYFlowCellTypeCompose_UnSelectable:
            [self.indicateImageView setImage:[UIImage imageNamed:@"bianji-bai"]];
            break;
            
        default:
            break;
    }
}

// active status
-(void)setActiveStatus:(MYFlowActiveStatus)activeStatus{
    _activeStatus = activeStatus;
    // 「活动」蓝色小单元的字体颜色
    switch (activeStatus) {
        case MYFlowActiveStatusDone:
            [self.statusLabel setTextColor:[UIColor whiteColor]];
            [self.timeLabel setTextColor:[UIColor whiteColor]];
            [self.leftCheckLabel setTextColor:[UIColor whiteColor]];
            break;
            
        case MYFlowActiveStatusActive:
            [self.statusLabel setTextColor:[UIColor whiteColor]];
            [self.timeLabel setTextColor:[UIColor whiteColor]];
            [self.leftCheckLabel setTextColor:[UIColor whiteColor]];
            break;
            
        case MYFlowActiveStatusToDo:
            [self.statusLabel setTextColor:[UIColor colorWithHexString:@"A9C8FF"]];
            [self.timeLabel setTextColor:[UIColor colorWithHexString:@"429BFF"]];
            [self.leftCheckLabel setTextColor:[UIColor colorWithHexString:@"429BFF"]];
            break;
            
        default:
            break;
    }
}

// project status
-(void)setProjectStatus:(MYFlowStatus)projectStatus{
    _projectStatus = projectStatus;
    // 小单元的颜色 蓝/白
    switch (projectStatus) {
        case MYFlowStatusDone:
            [self setBackgroundColor:[UIColor whiteColor]];
            [self.statusLabel setTextColor:[UIColor colorWithHexString:@"949494"]];
            [self.timeLabel setTextColor:[UIColor colorWithHexString:@"949494"]];
            [self.leftCheckLabel setTextColor:[UIColor colorWithHexString:@"65DE21"]];
            break;
            
        case MYFlowStatusActive:
            [self setBackgroundColor:[UIColor colorWithHexString:@"429BFF"]];
            break;
            
        case MYFlowStatusToDo:
            [self setBackgroundColor:[UIColor whiteColor]];
            [self.statusLabel setTextColor:[UIColor colorWithHexString:@"949494"]];
            [self.timeLabel setTextColor:[UIColor whiteColor]];
            [self.leftCheckLabel setTextColor:[UIColor whiteColor]];
            break;
            
        default:
            break;
    }
}

// status
-(void)setStatus:(NSString *)status{
    _status = status;
    self.statusLabel.text = status;
}
//time
-(void)setTime:(NSString *)time{
    _time = time;
    self.timeLabel.text = time;
}
//completed
-(void)setCompleted:(BOOL)completed{
    _completed = completed;
    if (completed) {
        self.leftCheckLabel.textColor = [UIColor colorWithRed:101/255.f green:222/255.f blue:33/255.f alpha:1.f];
    }else{
        self.leftCheckLabel.textColor = [UIColor clearColor];
    }
}


- (void)awakeFromNib {
    [super awakeFromNib];
    self.need2BecomeAlterCell = NO;
    // Initialization code

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
