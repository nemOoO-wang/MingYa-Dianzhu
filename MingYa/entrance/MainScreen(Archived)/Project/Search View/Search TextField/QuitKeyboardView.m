//
//  QuitKeyboardView.m
//  MingYa
//
//  Created by 镓洲 王 on 10/16/17.
//  Copyright © 2017 镓洲 王. All rights reserved.
//

#import "QuitKeyboardView.h"
#import "SearchTextField.h"


@interface QuitKeyboardView()

@end


@implementation QuitKeyboardView

-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    if (!CGRectContainsPoint(self.textField.frame, point)) {
        [self.textField resignFirstResponder];
    }
    return [super hitTest:point withEvent:event];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
