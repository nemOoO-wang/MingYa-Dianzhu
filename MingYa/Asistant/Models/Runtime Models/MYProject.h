//
//  MYProject.h
//  MingYa
//
//  Created by 镓洲 王 on 11/16/17.
//  Copyright © 2017 镓洲 王. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MYProject : NSObject

@property (nonatomic,strong) NSString *projectId;
@property (nonatomic,strong) NSString *projectName;
@property (nonatomic,assign) CGFloat latitude;
@property (nonatomic,assign) CGFloat longititude;


-(instancetype) initWithDict: (NSDictionary *)dict;
+(instancetype) projectWithDict: (NSDictionary *)dict;

@end
