//
//  ImgBrowserViewController.h
//  MingYa
//
//  Created by 陈必锋 on 2017/12/27.
//  Copyright © 2017年 镓洲 王. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImgBrowserViewController : UIViewController

+(ImgBrowserViewController*)viewControllerWithImgArray:(NSArray*)imgArray andKeyPath:(NSString*)keyPath andStartIdx:(NSInteger)startIdx;

@end
