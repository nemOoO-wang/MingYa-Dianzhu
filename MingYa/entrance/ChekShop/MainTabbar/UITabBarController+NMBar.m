//
//  UITabBarController+NMBar.m
//  铭雅装饰
//
//  Created by 镓洲 王 on 10/10/17.
//  Copyright © 2017 镓洲 王. All rights reserved.
//

#import "UITabBarController+NMBar.h"

@implementation UITabBarController (NMBar)

-(void)viewDidLoad{
    [super viewDidLoad];
    // 设置 bar 颜色
    [[UITabBarItem appearance]setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:156/255.f green:201/255.f blue:255/255.f alpha:1]} forState:UIControlStateNormal];
    [[UITabBarItem appearance]setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateSelected];
    
}

@end
