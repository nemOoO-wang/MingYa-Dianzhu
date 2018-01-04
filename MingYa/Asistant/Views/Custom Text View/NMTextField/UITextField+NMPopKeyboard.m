//
//  UITextField+NMPopKeyboard.m
//  铭雅装饰
//
//  Created by 镓洲 王 on 10/10/17.
//  Copyright © 2017 镓洲 王. All rights reserved.
//

#import "UITextField+NMPopKeyboard.h"

@implementation UITextField (NMPopKeyboard)
// quit keyboard
-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    if (!CGRectContainsPoint(self.bounds, point)) {
        [self resignFirstResponder];
    }
    return [super hitTest:point withEvent:event];
}

@end
