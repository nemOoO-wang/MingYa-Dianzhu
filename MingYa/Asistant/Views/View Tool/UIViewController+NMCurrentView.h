//
//  UIViewController+NMCurrentView.h
//  MingYa
//
//  Created by 镓洲 王 on 12/24/17.
//  Copyright © 2017 镓洲 王. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (NMCurrentView)


- (UIViewController *)getCurrentVC;
- (UIViewController *)getPresentedViewController;


@end
