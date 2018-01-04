//
//  SearchTableCell.m
//  MingYa
//
//  Created by 镓洲 王 on 10/18/17.
//  Copyright © 2017 镓洲 王. All rights reserved.
//

#import "SearchTableCell.h"


@interface SearchTableCell()
@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation SearchTableCell

-(void)setText:(NSString *)text{
    _text = text;
    self.label.text = text;
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
