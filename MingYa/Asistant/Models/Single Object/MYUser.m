//
//  MYUser.m
//  MingYa
//
//  Created by 镓洲 王 on 11/15/17.
//  Copyright © 2017 镓洲 王. All rights reserved.
//

#import "MYUser.h"
#import "BeeNet.h"
#import "AliOSSKit.h"

@implementation MYUser

+(instancetype)defaultUser{
    static MYUser *user;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!user) {
            user = [[MYUser alloc] init];
        }
    });
    return user;
}

-(void) registToken:(NSString *)token andId:(NSString *)userId andProjectId:(NSString *)projectId andProjectName:(NSString *)projectName{
    _token = token;
    _userId = userId;
    _projectId = projectId;
    _projectName = projectName;
    [[AliOSSKit sharedInstance] initOSSClient];
}

@end
