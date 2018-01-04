//
//  PeopleItemModel.m
//  MingYa
//
//  Created by 陈必锋 on 2017/10/25.
//  Copyright © 2017年 镓洲 王. All rights reserved.
//

#import "PeopleItemModel.h"

@implementation PeopleItemModel

-(instancetype)initWithPeopleId:(NSString *)peopleId andName:(NSString *)name{
    self = [super init];
    if (self) {
        self.peopleId = peopleId;
        self.name = name;
    }
    return self;
}

@end
