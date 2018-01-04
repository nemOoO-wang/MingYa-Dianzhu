//
//  NSNull+FaultObjFunction.m
//  MingYa
//
//  Created by 镓洲 王 on 12/25/17.
//  Copyright © 2017 镓洲 王. All rights reserved.
//

#import "NSNull+FaultObjFunction.h"

@implementation NSNull (FaultObjFunction)

-(NSInteger)length{
    NSLog(@"\n\nnull 对象接收的方法：length");
    return 0;
}

-(NSInteger)count{
    NSLog(@"\n\nnull 对象接收的方法：count");
    return 0;
}

-(NSInteger)integerValue{
    NSLog(@"\n\nnull 对象接收的方法：count");
    return 0;
}

@end
