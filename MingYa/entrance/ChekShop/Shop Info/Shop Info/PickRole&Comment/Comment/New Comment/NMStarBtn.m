//
//  NMStarBtn.m
//  MingYa
//
//  Created by 镓洲 王 on 1/5/18.
//  Copyright © 2018 镓洲 王. All rights reserved.
//

#import "NMStarBtn.h"

@implementation NMStarBtn

-(void)setRaking:(NSInteger)raking{
    _raking = raking;
    if (raking >= self.tag) {
        [self setImage:[UIImage imageNamed:@"Star"] forState:UIControlStateNormal];
    }else{
        [self setImage:[UIImage imageNamed:@"Star2"] forState:UIControlStateNormal];
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
