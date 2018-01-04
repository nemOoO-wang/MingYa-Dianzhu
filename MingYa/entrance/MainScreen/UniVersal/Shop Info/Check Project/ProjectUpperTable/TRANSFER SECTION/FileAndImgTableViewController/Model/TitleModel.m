//
//  TitleModel.m
//  MingYa
//
//  Created by 陈必锋 on 2017/10/19.
//  Copyright © 2017年 镓洲 王. All rights reserved.
//

#import "TitleModel.h"

@implementation TitleModel

+(TitleModel *)modelWithTitleAttr:(NSString *)titleStr{
    NSMutableParagraphStyle* style = [[NSMutableParagraphStyle alloc]init];
    style.lineSpacing = 10;
    
    NSMutableAttributedString* attrStr = [[NSMutableAttributedString alloc]initWithString:titleStr attributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#1C1C1C"],NSFontAttributeName:[UIFont systemFontOfSize:13]}];
    
    if ([titleStr containsString:@"\n"]) {
        [attrStr addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, titleStr.length)];
    }
    
    TitleModel* model = [[TitleModel alloc]init];
    model.titleAttr = attrStr;
    return model;
}

@end
