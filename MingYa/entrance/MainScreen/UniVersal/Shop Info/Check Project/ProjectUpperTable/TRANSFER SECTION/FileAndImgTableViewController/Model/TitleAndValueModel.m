//
//  TitleAndValueModel.m
//  MingYa
//
//  Created by 陈必锋 on 2017/10/26.
//  Copyright © 2017年 镓洲 王. All rights reserved.
//

#import "TitleAndValueModel.h"

@implementation TitleAndValueModel

+(TitleAndValueModel *)modelWithTitle:(NSString *)title andValue:(NSString *)value{
    TitleAndValueModel* model = [[TitleAndValueModel alloc]init];
    model.title = title;
    model.value = value;
    return model;
}

@end
