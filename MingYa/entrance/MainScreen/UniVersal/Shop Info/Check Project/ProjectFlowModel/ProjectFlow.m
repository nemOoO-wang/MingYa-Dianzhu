//
//  ProjectFlow.m
//  MingYa
//
//  Created by 镓洲 王 on 10/17/17.
//  Copyright © 2017 镓洲 王. All rights reserved.
//

#import "ProjectFlow.h"

@implementation ProjectFlow

// init
-(instancetype)initWithDict:(NSDictionary *)dict{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+(instancetype)projectFlowWithDict:(NSDictionary *)dict{
    return [[self alloc]initWithDict:dict];
}



@end
