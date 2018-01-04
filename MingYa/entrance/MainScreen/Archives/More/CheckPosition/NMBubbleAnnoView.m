//
//  NMBubbleAnnoView.m
//  MingYa
//
//  Created by 镓洲 王 on 10/12/17.
//  Copyright © 2017 镓洲 王. All rights reserved.
//

#import "NMBubbleAnnoView.h"

#define NMCalloutFontSize           14
#define NMCalloutWidth              100
#define NMCalloutHeight             67
#define NMCalloutBottomOffset       20


@implementation NMBubbleAnnoView

-(void)setBubbleWithName:(NSString *)shopName{
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, NMCalloutWidth, NMCalloutHeight)];
    UIImage *img = [UIImage imageNamed:@"sec_name"];
    [btn setBackgroundImage:img forState:UIControlStateNormal];
    [btn setTitle:shopName forState:UIControlStateNormal];
    [btn.titleLabel setFont:[UIFont systemFontOfSize:NMCalloutFontSize]];
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(-20, -10, 0, 0)];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    CGPoint originCenter = btn.center;
    btn.center = CGPointMake(originCenter.x - CGRectGetWidth(btn.bounds)/6.f, originCenter.y - CGRectGetHeight(btn.bounds) + NMCalloutBottomOffset);
    [self addSubview:btn];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
