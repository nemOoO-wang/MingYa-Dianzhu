//
//  ProjectUpperTableCell.m
//  MingYa
//
//  Created by 镓洲 王 on 10/17/17.
//  Copyright © 2017 镓洲 王. All rights reserved.
//

#import "ProjectUpperTableCell.h"


#define imgShang [UIImage imageNamed:@"jiantou_shang"]
#define imgShangBai [UIImage imageNamed:@"jiantoushang-bai"]
#define imgXia [UIImage imageNamed:@"jiantou-you-hui "]
#define imgXiaBai [UIImage imageNamed:@"jiantou-you-bai"]


@interface ProjectUpperTableCell()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *completeLabel;
//@property (weak, nonatomic) IBOutlet UILabel *directionLabel;
@property (weak, nonatomic) IBOutlet NMRoundView *leftRoungView;
@property (weak, nonatomic) IBOutlet UIImageView *directionImgView;

@end


@implementation ProjectUpperTableCell
# pragma mark - set status
-(void)setStatus:(MYFlowStatus)status{
    _status = status;
    // switch
    switch (status) {
        case MYFlowStatusDone:
            // done
            [self.subTableView setBackgroundColor:[UIColor whiteColor]];
            [self.leftRoungView setBackgroundColor:[UIColor colorWithHexString:@"65DE21"]];
            [self.completeLabel setTextColor:[UIColor colorWithHexString:@"949494"]];
            [self.titleLabel setTextColor:[UIColor blackColor]];
            self.completeLabel.text = @"已完成";
            break;
            
        case MYFlowStatusActive:
            // active
            [self.subTableView setBackgroundColor:[UIColor colorWithHexString:@"429BFF"]];
            [self.leftRoungView setBackgroundColor:[UIColor whiteColor]];
            [self.completeLabel setTextColor:[UIColor whiteColor]];
            [self.titleLabel setTextColor:[UIColor whiteColor]];
            self.completeLabel.text = @"进行中";
            break;
            
        case MYFlowStatusToDo:
            // to do
            [self.subTableView setBackgroundColor:[UIColor whiteColor]];
            [self.leftRoungView setBackgroundColor:[UIColor colorWithHexString:@"#BBBBBB"]];
            [self.completeLabel setTextColor:[UIColor blackColor]];
            [self.titleLabel setTextColor:[UIColor blackColor]];
            self.completeLabel.text = @"";
            break;
            
        default:
            break;
    }
    self.subTableView.projectStatus = status;
}


-(void)setHideArrow:(BOOL)hideArrow{
    _hideArrow = hideArrow;
    if (hideArrow) {
        self.directionImgView.hidden = YES;
    }
}


-(void)setSubTableStatus:(ProjectSubTableStatus)subTableStatus{
    _subTableStatus = subTableStatus;
    switch (subTableStatus) {
        case ProjectSubTableStatusOpen:
            if (self.status == MYFlowStatusActive) {
                self.directionImgView.image = imgShangBai;
            }else{
                self.directionImgView.image = imgShang;
            }
            break;
            
        case ProjectSubTableStatusClosed:
            if (self.status == MYFlowStatusActive) {
                self.directionImgView.image = imgXiaBai;
            }else{
                self.directionImgView.image = imgXia;
            }
            break;
            
        default:
            break;
    }
}

# pragma mark - set row index
-(void)setActiveRowIndex:(NSInteger)activeRowIndex{
    _activeRowIndex = activeRowIndex;
    self.subTableView.activeRowIndex = activeRowIndex;
}

# pragma mark - set flow
-(void)setFlow:(ProjectFlow *)flow{
    _flow = flow;
    self.titleLabel.text = flow.title;
    self.subTableView.flow = flow;
}

# pragma mark - set authority/finish arrr
// authority arr
-(void)setAuthorityArr:(NSArray *)authorityArr{
    _authorityArr = authorityArr;
    self.subTableView.authorityArr = authorityArr;
}

// finish arr
-(void)setFinishArr:(NSArray *)finishArr{
    _finishArr = finishArr;
    self.subTableView.finishArr = finishArr;
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
