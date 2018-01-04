//
//  NMTextView.m
//  MingYa
//
//  Created by 镓洲 王 on 10/16/17.
//  Copyright © 2017 镓洲 王. All rights reserved.
//

#import "NMTextView.h"


IB_DESIGNABLE
@implementation NMTextView
// inset
-(void)setInset:(CGFloat)inset{
    _inset = inset;
    self.textContainerInset = UIEdgeInsetsMake(inset, inset, inset, inset);
}

// horizon inset
-(void)setHorizonInset:(CGFloat)horizonInset{
    _horizonInset = horizonInset;
    [self resetInset];
}

// top inset
-(void)setTopInset:(CGFloat)topInset{
    _topInset = topInset;
    [self resetInset];
}

// reset inset
-(void)resetInset{
    if (self.topInset && self.horizonInset) {
        self.textContainerInset = UIEdgeInsetsMake(self.topInset, self.horizonInset, 0, self.horizonInset);
    }else if (self.horizonInset){
        self.textContainerInset = UIEdgeInsetsMake(0, self.horizonInset, 0, self.horizonInset);
    }else{
        self.textContainerInset = UIEdgeInsetsMake(self.topInset, 0, self.topInset, 0);
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
