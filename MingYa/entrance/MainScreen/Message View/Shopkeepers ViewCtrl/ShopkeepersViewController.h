//
//  ShopkeepersViewController.h
//  MingYa
//
//  Created by 镓洲 王 on 10/19/17.
//  Copyright © 2017 镓洲 王. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ShopkeepersVCType) {
    ShopkeepersVCTypeProject,
    ShopkeepersVCTypeWork,
    ShopkeepersVCTypeComment,
};


@interface ShopkeepersViewController : UIViewController

@property (nonatomic,strong) NSString *selection;
@property (nonatomic,assign) ShopkeepersVCType showType;

@end
