//
//  UINavigationController+NMCustomBar.m
//  MingYa
//
//  Created by 镓洲 王 on 10/20/17.
//  Copyright © 2017 镓洲 王. All rights reserved.
//

#import "UINavigationController+NMCustomBar.h"

@implementation UINavigationController (NMCustomBar)

-(void)viewWillAppear:(BOOL)animated{
    [self.navigationBar setShadowImage:[UIImage new]];
    [self.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:1/244.f green:1/243.f blue:1/244.f alpha:1.f]];
}

@end
