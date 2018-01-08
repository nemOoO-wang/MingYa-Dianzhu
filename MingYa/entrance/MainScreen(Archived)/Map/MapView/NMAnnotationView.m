//
//  NMAnnotationView.m
//  MingYa
//
//  Created by 镓洲 王 on 10/12/17.
//  Copyright © 2017 镓洲 王. All rights reserved.
//

#import "NMAnnotationView.h"

#define NMCalloutFontSize           12.f
#define NMCalloutWidth              calloutWidth
#define NMCalloutHeight             65
#define NMCalloutBottomOffset       22


@implementation NMAnnotationView

#pragma mark - Button
-(void)addBtnWithName:(NSString *)shopName andProjectId:(NSString *)projectId{
    // project id
    self.projectId = projectId;
    
    // cal text width
    UIFont *font = [UIFont systemFontOfSize:NMCalloutFontSize];
    CGSize labelSize = [shopName sizeWithAttributes:@{NSFontAttributeName:font}];
    CGFloat calloutWidth = labelSize.width + 60.f;
    
    // add button
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, NMCalloutWidth, NMCalloutHeight)];//99\44
    UIImage *img = [UIImage imageNamed:@"sec_shop"];
    [btn setBackgroundImage:img forState:UIControlStateNormal];
    [btn setTitle:shopName forState:UIControlStateNormal];
    [btn.titleLabel setFont:[UIFont systemFontOfSize:NMCalloutFontSize]];
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(-20, -10, 0, 0)];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    CGPoint originCenter = btn.center;
    btn.center = CGPointMake(originCenter.x - CGRectGetWidth(btn.bounds)/6.f, originCenter.y - CGRectGetHeight(btn.bounds) + NMCalloutBottomOffset);
    [btn addTarget:self action:@selector(test) forControlEvents:UIControlEventTouchUpInside];
    self.btn = btn;
    [self addSubview:btn];
}

# pragma mark - Update
-(void)updateBtnWithName:(NSString *)shopName andProjectId:(NSString *)projectId{
    // project id
    self.projectId = projectId;
    
    // cal text width
    UIFont *font = [UIFont systemFontOfSize:NMCalloutFontSize];
    CGSize labelSize = [shopName sizeWithAttributes:@{NSFontAttributeName:font}];
    CGFloat calloutWidth = labelSize.width + 60.f;
    
    // remove btn
    [self.btn removeFromSuperview];
    
    // add button
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, NMCalloutWidth, NMCalloutHeight)];//99\44
    UIImage *img = [UIImage imageNamed:@"sec_shop"];
    [btn setBackgroundImage:img forState:UIControlStateNormal];
    [btn setTitle:shopName forState:UIControlStateNormal];
    [btn.titleLabel setFont:[UIFont systemFontOfSize:NMCalloutFontSize]];
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(-20, -10, 0, 0)];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    CGPoint originCenter = btn.center;
    btn.center = CGPointMake(originCenter.x - CGRectGetWidth(btn.bounds)/6.f, originCenter.y - CGRectGetHeight(btn.bounds) + NMCalloutBottomOffset);
    [btn addTarget:self action:@selector(test) forControlEvents:UIControlEventTouchUpInside];
    self.btn = btn;
    [self addSubview:btn];
}

-(void)test{
    // send notification
    [[NSNotificationCenter defaultCenter] postNotificationName:@"selectAnnoInMap" object:self.projectId];

}



//
//-(void)setImage:(UIImage *)image{
//    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 30)];
//    label.text = @"TESTTTESTT";
//    [self addSubview:label];
//    [super setImage:image];
//}
//-(instancetype)initWithFrame:(CGRect)frame
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
