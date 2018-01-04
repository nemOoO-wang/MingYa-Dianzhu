//
//  ProjectRightCollectionCell.m
//  MingYa
//
//  Created by 镓洲 王 on 11/24/17.
//  Copyright © 2017 镓洲 王. All rights reserved.
//

#import "ProjectRightCollectionCell.h"
#import "NMSmallTextButton.h"
#import "NMRoundLabel.h"


@interface ProjectRightCollectionCell()
@property (weak, nonatomic) IBOutlet NMRoundLabel *label;

@end


@implementation ProjectRightCollectionCell

-(void)setCellName:(NSString *)cellName{
    _cellName = cellName;
    self.label.text = cellName;
//    [self.btn setTitle:cellName forState:UIControlStateNormal];
}


@end
