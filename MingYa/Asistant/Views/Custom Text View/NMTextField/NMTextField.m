//
//  NMTextField.m
//  铭雅装饰
//
//  Created by 镓洲 王 on 10/10/17.
//  Copyright © 2017 镓洲 王. All rights reserved.
//

#import "NMTextField.h"


IB_DESIGNABLE
@implementation NMTextField


-(void)setRadius:(CGFloat)radius{
    _radius = radius;
    self.layer.cornerRadius = radius;
    self.layer.borderColor = [[UIColor whiteColor] CGColor];
    self.layer.borderWidth = 1;
    self.layer.masksToBounds = YES;
}

-(void)setInsetX:(CGFloat)insetX{
    _insetX = insetX;
    UIView *subView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, insetX, 0)];
    self.leftView = subView;
    [self setLeftViewMode:UITextFieldViewModeAlways];
}

-(void)setHideBorder:(BOOL)hideBorder{
    _hideBorder = hideBorder;
    if (hideBorder) {
        self.layer.borderWidth = 1;
        self.layer.borderColor = [[UIColor whiteColor] CGColor];
    }
}
@end
