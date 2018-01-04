//
//  MYInfoProject.m
//  MingYa
//
//  Created by 镓洲 王 on 11/24/17.
//  Copyright © 2017 镓洲 王. All rights reserved.
//

#import "MYInfoProject.h"


@implementation MYInfoProject

-(instancetype)initWithDict:(NSDictionary *)dict{
    if(self = [super initWithDict:dict]){
        self.brandName = dict[@"brandName"];
        self.schedule = [dict[@"schedule"] integerValue];
        self.province = dict[@"province"];
        self.city = dict[@"city"];
    }
    
    return self;
}

+(instancetype)projectWithDict:(NSDictionary *)dict{
    return [[MYInfoProject alloc]initWithDict:dict];
}

@end
