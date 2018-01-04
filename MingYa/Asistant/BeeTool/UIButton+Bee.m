//
//  UIButton+Bee.m
//  MingYa
//
//  Created by 陈必锋 on 2017/10/23.
//  Copyright © 2017年 镓洲 王. All rights reserved.
//

#import "UIButton+Bee.h"

@implementation UIButton (Bee)

-(void)setCorner:(CGFloat)corner{
    self.layer.cornerRadius = corner;
}

-(CGFloat)corner{
    return 0;
}

@end
