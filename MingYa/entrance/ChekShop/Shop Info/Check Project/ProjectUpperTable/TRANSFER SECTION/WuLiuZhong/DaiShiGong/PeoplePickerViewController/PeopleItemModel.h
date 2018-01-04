//
//  PeopleItemModel.h
//  MingYa
//
//  Created by 陈必锋 on 2017/10/25.
//  Copyright © 2017年 镓洲 王. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PeopleItemModel : NSObject

@property (strong,nonatomic) NSString* peopleId;
@property (strong,nonatomic) NSString* name;

-(instancetype)initWithPeopleId:(NSString*)peopleId andName:(NSString*)name;

@end
