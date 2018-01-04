//
//  NMRoundLabel.m
//  MingYa
//
//  Created by 镓洲 王 on 11/29/17.
//  Copyright © 2017 镓洲 王. All rights reserved.
//

#import "NMRoundLabel.h"

@interface NMRoundLabel ()

@property (strong,nonatomic) CALayer* borderLayer;

@end

@implementation NMRoundLabel

-(void)setRadius:(CGFloat)radius{
    _radius = radius;
    self.layer.cornerRadius = radius;
}


-(void)setCanShowRadius:(BOOL)canShowRadius{
    _canShowRadius = canShowRadius;
    if (canShowRadius) {
        [self.borderLayer removeFromSuperlayer];
        
        CGSize textSize = [self sizeThatFits:self.frame.size];
        
        self.borderLayer = [CALayer layer];
        [self.borderLayer setBorderColor:[UIColor colorWithHexString:@"429BFF"].CGColor];
        [self.borderLayer setBorderWidth:1];
        [self.borderLayer setCornerRadius:(CGRectGetHeight(self.bounds) + 10) / 2];
        [self.borderLayer setFrame:CGRectMake((CGRectGetWidth(self.frame) - textSize.width - 15) / 2, (CGRectGetHeight(self.frame) - textSize.height - 10) / 2, textSize.width + 15, textSize.height + 10)];
        [self.layer addSublayer:self.borderLayer];
    }
}

-(void)drawRect:(CGRect)rect{
    self.canShowRadius = self.canShowRadius;
    [super drawRect:rect];
}

-(void)drawTextInRect:(CGRect)rect{
    self.canShowRadius = self.canShowRadius;
    [super drawTextInRect:rect];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
