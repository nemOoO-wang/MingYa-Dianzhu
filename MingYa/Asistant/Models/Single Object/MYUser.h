//
//  MYUser.h
//  MingYa
//
//  Created by 镓洲 王 on 11/15/17.
//  Copyright © 2017 镓洲 王. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MYUser : NSObject

@property (nonatomic, strong, readonly) NSString *token;
@property (nonatomic, strong, readonly) NSString *userId;

+(instancetype) defaultUser;
-(void) registToken:(NSString *)token andId:(NSString *)userId;

@end
