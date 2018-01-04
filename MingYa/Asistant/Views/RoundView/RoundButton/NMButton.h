//
//  NMButton.h
//  铭雅装饰
//
//  Created by 镓洲 王 on 10/10/17.
//  Copyright © 2017 镓洲 王. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NMButton : UIButton

@property (nonatomic,assign) IBInspectable CGFloat radius;
@property (nonatomic,assign) IBInspectable CGFloat textInset;
@property (nonatomic) IBInspectable UIColor *borderColor;
@property (nonatomic) IBInspectable CGFloat borderWidth;

@end
