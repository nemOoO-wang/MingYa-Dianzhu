//
//  MeTableViewCell.m
//  MingYa
//
//  Created by 镓洲 王 on 10/19/17.
//  Copyright © 2017 镓洲 王. All rights reserved.
//

#import "MeTableViewCell.h"


@interface MeTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *leftLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightLabel;


@end

@implementation MeTableViewCell
-(void)setLeft:(NSString *)left{
    _left = left;
    self.leftLabel.text = left;
}

-(void)setRight:(NSString *)right{
    _right = right;
    self.rightLabel.text = right;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
