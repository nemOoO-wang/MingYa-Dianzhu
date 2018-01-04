//
//  NMRoundLabel.h
//  MingYa
//
//  Created by 镓洲 王 on 11/29/17.
//  Copyright © 2017 镓洲 王. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface NMRoundLabel : UILabel

@property (nonatomic,assign) IBInspectable CGFloat radius;
@property (nonatomic,assign) IBInspectable BOOL canShowRadius;

@end
