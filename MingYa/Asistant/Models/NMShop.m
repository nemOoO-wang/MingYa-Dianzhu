//
//  NMShop.m
//  MingYa
//
//  Created by 镓洲 王 on 10/24/17.
//  Copyright © 2017 镓洲 王. All rights reserved.
//

#import "NMShop.h"

@implementation NMShop
-(instancetype)initWithDict:(NSDictionary *)dict{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}


+(instancetype)shopWithDict:(NSDictionary *)dict{
    return [[NMShop alloc] initWithDict:dict];
}

@end
