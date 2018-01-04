//
//  MessageTableCell.m
//  MingYa
//
//  Created by 镓洲 王 on 10/18/17.
//  Copyright © 2017 镓洲 王. All rights reserved.
//

#import "MessageTableCell.h"


@interface MessageTableCell()
@property (nonatomic,weak) IBOutlet UILabel *contentLabel;
@property (nonatomic,weak) IBOutlet UILabel *date;
@property (nonatomic,weak) IBOutlet UILabel *time;

@end

@implementation MessageTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
