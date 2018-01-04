//
//  NMSmallTextButton.m
//  MingYa
//
//  Created by 镓洲 王 on 10/27/17.
//  Copyright © 2017 镓洲 王. All rights reserved.
//

#import "NMSmallTextButton.h"

@implementation NMSmallTextButton

-(void)drawRect:(CGRect)rect{
    rect.size.width += 15;
    self.bounds = rect;
}
@end
