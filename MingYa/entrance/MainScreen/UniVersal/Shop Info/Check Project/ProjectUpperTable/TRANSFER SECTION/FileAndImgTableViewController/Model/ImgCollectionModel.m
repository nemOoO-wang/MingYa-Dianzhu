//
//  ImgCollectionModel.m
//  MingYa
//
//  Created by 陈必锋 on 2017/10/20.
//  Copyright © 2017年 镓洲 王. All rights reserved.
//

#import "ImgCollectionModel.h"

@implementation ImgCollectionModel

+(ImgCollectionModel*)modelWithTitleStr:(NSString*)titleStr andImgDatas:(NSArray*)imgDatas{
    return [self modelWithTitleStr:titleStr andImgDatas:imgDatas andItemInLine:3 andItemSpace:5 andLineSpace:5];
}

+(ImgCollectionModel *)modelWithTitleStr:(NSString *)titleStr andImgDatas:(NSArray *)imgDatas andItemInLine:(NSInteger)itemInLine andItemSpace:(float)itemSpace andLineSpace:(float)lineSpace{
    NSMutableParagraphStyle* style = [[NSMutableParagraphStyle alloc]init];
    style.lineSpacing = 10;
    
    NSMutableAttributedString* attrStr = [[NSMutableAttributedString alloc]initWithString:titleStr attributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#1C1C1C"],NSFontAttributeName:[UIFont systemFontOfSize:13]}];
    
    if ([titleStr containsString:@"\n"]) {
        [attrStr addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, titleStr.length)];
    }

    
    ImgCollectionModel* model = [[ImgCollectionModel alloc]init];
    model.titleStr = attrStr;
    model.imgDatas = imgDatas;
    model.itemSpace = itemSpace;
    model.lineSpace = lineSpace;
    model.itemInLine = itemInLine;
    return model;
}

@end
