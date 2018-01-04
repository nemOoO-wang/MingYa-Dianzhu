//
//  CommentTableViewCell.m
//  MingYa
//
//  Created by 镓洲 王 on 10/19/17.
//  Copyright © 2017 镓洲 王. All rights reserved.
//

#import "CommentTableViewCell.h"
#import "NMTextView.h"


@interface CommentTableViewCell()
@property (weak, nonatomic) IBOutlet NMTextView *textView;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end

@implementation CommentTableViewCell

-(void)setComment:(MYComment *)comment{
    _comment = comment;
    self.textView.text = comment.commentText;
    self.timeLabel.text = comment.time;
    self.nameLabel.text = comment.titleStr;
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
