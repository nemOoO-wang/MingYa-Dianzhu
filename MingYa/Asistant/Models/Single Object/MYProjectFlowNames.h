//
//  MYProjectFlowNames.h
//  MingYa
//
//  Created by 镓洲 王 on 11/24/17.
//  Copyright © 2017 镓洲 王. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MYProjectFlowNames : NSObject

// get flow name
-(NSString *)getNameOfSection:(NSInteger)section andRow:(NSInteger)row;

// shared instance
+(instancetype)sharedInstance;

@end
