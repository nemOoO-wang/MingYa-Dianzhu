//
//  TitleModel.h
//  MingYa
//
//  Created by 陈必锋 on 2017/10/19.
//  Copyright © 2017年 镓洲 王. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface TitleModel : NSObject

@property (strong,nonatomic) NSAttributedString* titleAttr;

+(TitleModel*)modelWithTitleAttr:(NSString*)titleStr;

@end
