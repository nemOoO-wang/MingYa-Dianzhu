//
//  TitleAndValueModel.h
//  MingYa
//
//  Created by 陈必锋 on 2017/10/26.
//  Copyright © 2017年 镓洲 王. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TitleAndValueModel : NSObject

@property (strong,nonatomic) NSString* title;
@property (strong,nonatomic) NSString* value;

+(TitleAndValueModel*)modelWithTitle:(NSString*)title andValue:(NSString*)value;

@end
