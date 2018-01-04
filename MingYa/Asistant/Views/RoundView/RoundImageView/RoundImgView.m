//
//  RoundImgView.m
//  MingYa
//
//  Created by 镓洲 王 on 12/6/17.
//  Copyright © 2017 镓洲 王. All rights reserved.
//

#import "RoundImgView.h"


@implementation RoundImgView

-(void)setCorner:(CGFloat)corner{
    _corner = corner;
    [self.layer setMasksToBounds:YES];
    self.layer.cornerRadius = corner;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
