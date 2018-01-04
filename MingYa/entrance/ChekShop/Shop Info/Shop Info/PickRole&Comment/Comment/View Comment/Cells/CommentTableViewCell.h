//
//  CommentTableViewCell.h
//  MingYa
//
//  Created by 镓洲 王 on 10/19/17.
//  Copyright © 2017 镓洲 王. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MYComment.h"

@interface CommentTableViewCell : UITableViewCell

@property (nonatomic,strong) MYComment *comment;


@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end
