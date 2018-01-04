//
//  NMRoundView.m
//  MingYa
//
//  Created by 镓洲 王 on 10/13/17.
//  Copyright © 2017 镓洲 王. All rights reserved.
//

#import "NMRoundView.h"


@interface NMRoundView()
@property (nonatomic,assign) BOOL haveShadow;
@end

IB_DESIGNABLE
@implementation NMRoundView
-(void)setRadius:(CGFloat)radius{
    _radius = radius;
    self.layer.cornerRadius = self.radius;
}

-(void)loadSubLayerWithController:(UIViewController *)controller{
    if (!self.haveShadow) {
        // set shadow
        CALayer *subLayer = [[CALayer alloc] init];
        subLayer.frame = self.layer.frame;
        [subLayer setMasksToBounds:NO];
        subLayer.cornerRadius = 25;
        subLayer.backgroundColor = [[UIColor whiteColor] CGColor];
        subLayer.shadowColor = [[UIColor lightGrayColor] CGColor];
        subLayer.shadowOffset = CGSizeMake(5, 5);
        subLayer.shadowRadius = 10.f;
        subLayer.shadowOpacity = 0.6;
        [controller.view.layer insertSublayer:subLayer below:self.layer];
        self.haveShadow = YES;
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
