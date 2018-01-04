//
//  ShopHeadTableViewCell.m
//  MingYa
//
//  Created by 镓洲 王 on 10/24/17.
//  Copyright © 2017 镓洲 王. All rights reserved.
//

#import "ShopHeadTableViewCell.h"


@interface ShopHeadTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *sectionLabel;

@end

@implementation ShopHeadTableViewCell

-(void)setSectionName:(NSString *)sectionName{
    _sectionName = sectionName;
    self.sectionLabel.text = sectionName;
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
