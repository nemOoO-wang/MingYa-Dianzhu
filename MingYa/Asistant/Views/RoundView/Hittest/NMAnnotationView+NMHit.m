//
//  NMAnnotationView+NMHit.m
//  MingYa
//
//  Created by 镓洲 王 on 11/21/17.
//  Copyright © 2017 镓洲 王. All rights reserved.
//

#import "NMAnnotationView+NMHit.h"

@implementation NMAnnotationView (NMHit)

-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    CGPoint btnPoint = [self.btn convertPoint:point fromView:self];
    if (CGRectContainsPoint(self.btn.bounds, btnPoint)) {
        return [self.btn hitTest:btnPoint withEvent:event];

    }else{
        return [super hitTest:point withEvent:event];
    }
//    return [super hitTest:point withEvent:event];
}

@end
