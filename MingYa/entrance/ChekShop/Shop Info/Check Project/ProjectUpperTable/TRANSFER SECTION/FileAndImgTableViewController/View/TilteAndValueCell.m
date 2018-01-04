//
//  TilteAndValueCell.m
//  MingYa
//
//  Created by 陈必锋 on 2017/10/26.
//  Copyright © 2017年 镓洲 王. All rights reserved.
//

#import "TilteAndValueCell.h"

@implementation TilteAndValueCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setupWithModel:(TitleAndValueModel *)model{
    self.titleL.text = model.title;
    self.valueL.text = model.value;
}

@end
