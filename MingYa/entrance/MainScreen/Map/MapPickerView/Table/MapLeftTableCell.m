//
//  MapLeftTableCell.m
//  MingYa
//
//  Created by 镓洲 王 on 11/17/17.
//  Copyright © 2017 镓洲 王. All rights reserved.
//

#import "MapLeftTableCell.h"


@interface MapLeftTableCell()
@property (weak, nonatomic) IBOutlet UILabel *label;

@end


@implementation MapLeftTableCell

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
