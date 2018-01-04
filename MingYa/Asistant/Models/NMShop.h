//
//  NMShop.h
//  MingYa
//
//  Created by 镓洲 王 on 10/24/17.
//  Copyright © 2017 镓洲 王. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NMShop : NSObject

@property (nonatomic,strong) NSString *section;
@property (nonatomic,strong) NSArray *information;

-(instancetype)initWithDict:(NSDictionary *)dict;
+(instancetype)shopWithDict:(NSDictionary *)dict;

@end
