//
//  NMRoundView.h
//  MingYa
//
//  Created by 镓洲 王 on 10/13/17.
//  Copyright © 2017 镓洲 王. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NMRoundView : UIView
@property (nonatomic) IBInspectable CGFloat radius;

-(void)loadSubLayerWithController:(UIViewController *)controller;

@end
