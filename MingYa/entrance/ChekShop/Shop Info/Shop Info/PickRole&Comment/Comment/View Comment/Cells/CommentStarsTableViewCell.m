//
//  CommentStarsTableViewCell.m
//  MingYa
//
//  Created by 镓洲 王 on 10/19/17.
//  Copyright © 2017 镓洲 王. All rights reserved.
//

#import "CommentStarsTableViewCell.h"


@interface CommentStarsTableViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *star0;
@property (weak, nonatomic) IBOutlet UIImageView *star1;
@property (weak, nonatomic) IBOutlet UIImageView *star2;
@property (weak, nonatomic) IBOutlet UIImageView *star3;
@property (weak, nonatomic) IBOutlet UIImageView *star4;

@end

@implementation CommentStarsTableViewCell

-(void)setStar:(NSInteger)star{
    _star = star;
    [self resetStars];
    if (star >= 0 && star <5) {
        // 范围检测
        UIImage *star2Img = [UIImage imageNamed:@"Star2"];
        switch (star) {
                // 去掉了 break 顺序向下执行
            case 0:
                self.star4.image = star2Img;
            case 1:
                self.star3.image = star2Img;
            case 2:
                self.star2.image = star2Img;
            case 3:
                self.star1.image = star2Img;
            case 4:
                self.star0.image = star2Img;
            default:
                break;
        }
    }
}


-(void)resetStars{
    UIImage *starImg = [UIImage imageNamed:@"Star"];
    
    self.star0.image = starImg;
    self.star1.image = starImg;
    self.star2.image = starImg;
    self.star3.image = starImg;
    self.star4.image = starImg;
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
