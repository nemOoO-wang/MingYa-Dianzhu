//
//  ImgCollectionModel.h
//  MingYa
//
//  Created by 陈必锋 on 2017/10/20.
//  Copyright © 2017年 镓洲 王. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImgCollectionModel : NSObject

@property (strong,nonatomic) NSAttributedString* titleStr;
@property (strong,nonatomic) NSArray* imgDatas;

@property (nonatomic) NSInteger itemInLine;
@property (nonatomic) float itemSpace;
@property (nonatomic) float lineSpace;

+(ImgCollectionModel*)modelWithTitleStr:(NSString*)titleStr andImgDatas:(NSArray*)imgDatas andItemInLine:(NSInteger)itemInLine andItemSpace:(float)itemSpace andLineSpace:(float)lineSpace;
+(ImgCollectionModel*)modelWithTitleStr:(NSString*)titleStr andImgDatas:(NSArray*)imgDatas;
@end
