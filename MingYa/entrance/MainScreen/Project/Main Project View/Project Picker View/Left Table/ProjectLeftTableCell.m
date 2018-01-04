//
//  ProjectLeftTableCell.m
//  MingYa
//
//  Created by 镓洲 王 on 11/24/17.
//  Copyright © 2017 镓洲 王. All rights reserved.
//

#import "ProjectLeftTableCell.h"


@interface ProjectLeftTableCell()

@property (weak, nonatomic) IBOutlet UILabel *label;

@end


@implementation ProjectLeftTableCell

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

    if (selected) {
        [self.label setTextColor:[UIColor colorWithHexString:@"429BFF"]];
    }else{
        [self.label setTextColor:[UIColor blackColor]];
    }
}

@end
