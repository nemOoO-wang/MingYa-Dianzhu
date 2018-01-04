//
//  NMapView.m
//  铭雅装饰
//
//  Created by 镓洲 王 on 10/9/17.
//  Copyright © 2017 镓洲 王. All rights reserved.
//

#import "NMapView.h"
#import "NMPikerView.h"
#import "NMAnnotationView.h"


@interface NMapView ()
@property (weak, nonatomic) IBOutlet NMPikerView *pikerView;
@property (weak, nonatomic) IBOutlet NMRoundView *pickerView;

@end


@implementation NMapView
// annotationView


// basic setting
-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    self.showsScale = NO;
    self.showsCompass = NO;
    self.rotateEnabled = NO;
    self.rotateCameraEnabled = NO;
    [self bringSubviewToFront:self.pickerView];
}


@end
