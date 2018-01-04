//
//  NMButton.m
//  铭雅装饰
//
//  Created by 镓洲 王 on 10/10/17.
//  Copyright © 2017 镓洲 王. All rights reserved.
//

#import "NMButton.h"


IB_DESIGNABLE
@implementation NMButton
-(void)setBorderWidth:(CGFloat)borderWidth{
    _borderWidth = borderWidth;
    self.layer.borderWidth = borderWidth;
}

-(void)setBorderColor:(UIColor *)borderColor{
    _borderColor = borderColor;
    self.layer.borderColor = [borderColor CGColor];
}

-(void)setRadius:(CGFloat)radius{
    _radius = radius;
    self.layer.cornerRadius = radius;
    self.layer.masksToBounds = radius > 0;
}

-(void)setTextInset:(CGFloat)textInset{
    self.titleEdgeInsets = UIEdgeInsetsMake(5, textInset, 5, textInset);
}


@end
