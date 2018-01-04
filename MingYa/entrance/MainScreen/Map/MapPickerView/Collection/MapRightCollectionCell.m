//
//  MapRightCollectionCell.m
//  MingYa
//
//  Created by 镓洲 王 on 11/21/17.
//  Copyright © 2017 镓洲 王. All rights reserved.
//

#import "MapRightCollectionCell.h"
#import "NMSmallTextButton.h"
#import "NMRoundLabel.h"


@interface MapRightCollectionCell()
@property (weak, nonatomic) IBOutlet NMRoundLabel *label;

@property (weak, nonatomic) IBOutlet NMSmallTextButton *btn;

@end


@implementation MapRightCollectionCell

-(void)setCellName:(NSString *)cellName{
    _cellName = cellName;
    self.label.text = cellName;
//    [self.btn setTitle:cellName forState:UIControlStateNormal];
}

-(void)layoutSubviews{
    [super layoutSubviews];
//    self.btn.titleLabel.numberOfLines = 0.f;
}

@end
