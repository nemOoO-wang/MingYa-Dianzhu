//
//  NormarlUploadVCSetting.m
//  MingYa
//
//  Created by 陈必锋 on 2017/10/19.
//  Copyright © 2017年 镓洲 王. All rights reserved.
//

#import "NormarlUploadVCSetting.h"

@implementation NormarlUploadVCSetting

+(NormarlUploadVCSetting *)normalSettingWithVCTitle:(NSString *)title andSectionCount:(NSInteger)sectionCount andNumberOfItemInLine:(NSInteger)numberOfItemInLine andLineSpace:(float)lineSpace andItemSpace:(float)itemSpace andCanEdit:(BOOL)canEdit andIsShowNetImg:(BOOL)isShowNetImg andInsets:(UIEdgeInsets)insets{
    NormarlUploadVCSetting* setting = [[NormarlUploadVCSetting alloc]init];
    
    setting.title = title;
    setting.sectionCount = sectionCount;
    setting.numberOfItemInLine = numberOfItemInLine;
    setting.lineSpace = lineSpace;
    setting.itemSpace = itemSpace;
    setting.canEdit = canEdit;
    setting.isShowNetImg = isShowNetImg;
    setting.insets = insets;
    
    return setting;
}

@end
