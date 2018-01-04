//
//  MYProject.m
//  MingYa
//
//  Created by 镓洲 王 on 11/16/17.
//  Copyright © 2017 镓洲 王. All rights reserved.
//

#import "MYProject.h"

@implementation MYProject

// init
-(instancetype) initWithDict: (NSDictionary *)dict{
    if (self = [super init]) {
        self.projectId = dict[@"projectId"];
        self.projectName = dict[@"projectName"];
        self.latitude = [dict[@"latitude"] doubleValue];
        self.longititude = [dict[@"longitude"] doubleValue];
    }
    return self;
}
+(instancetype) projectWithDict: (NSDictionary *)dict{
    return [[MYProject alloc] initWithDict:dict];
}


@end
