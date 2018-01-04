//
//  SGZImgSet.m
//  MingYa
//
//  Created by 镓洲 王 on 1/3/18.
//  Copyright © 2018 镓洲 王. All rights reserved.
//

#import "SGZImgSet.h"

@implementation SGZImgSet

-(instancetype)initWithTitle:(NSString *)title andImgUrl:(NSString *)url{
    if (self = [super init]) {
        self.title = title;
        [self insertImgUrl:url];
    }
    return self;
}

+(instancetype)setWithTitle:(NSString *)title andImgUrl:(NSString *)url{
    return [[SGZImgSet alloc]initWithTitle:title andImgUrl:url];
}


-(void)insertImgUrl:(NSString *)imgUrl{
    if (!self.imgUrlArr) {
        self.imgUrlArr = [[NSMutableArray alloc] init];
    }
    if (imgUrl) {
        [self.imgUrlArr addObject:imgUrl];
    }
}

-(BOOL)isInSameSection:(NSString *)title{
    if ([self.title isEqualToString:title]) {
        return YES;
    }
    return NO;
}

@end
