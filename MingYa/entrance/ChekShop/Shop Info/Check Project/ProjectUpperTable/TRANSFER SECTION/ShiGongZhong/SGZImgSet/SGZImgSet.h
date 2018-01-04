//
//  SGZImgSet.h
//  MingYa
//
//  Created by 镓洲 王 on 1/3/18.
//  Copyright © 2018 镓洲 王. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SGZImgSet : NSObject

@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSMutableArray *imgUrlArr;


-(instancetype)initWithTitle:(NSString *)title andImgUrl:(NSString *)url;
+(instancetype)setWithTitle:(NSString *)title andImgUrl:(NSString *)url;
-(void)insertImgUrl:(NSString *)imgUrl;
-(BOOL)isInSameSection:(NSString *)title;

@end
