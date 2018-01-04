//
//  NormarlUploadVCSetting.h
//  MingYa
//
//  Created by 陈必锋 on 2017/10/19.
//  Copyright © 2017年 镓洲 王. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NormarlUploadVCSetting : NSObject

@property (strong,nonatomic) NSString* title;
@property (nonatomic) NSInteger sectionCount;
@property (nonatomic) NSInteger numberOfItemInLine;
@property (nonatomic) float lineSpace;
@property (nonatomic) float itemSpace;
@property (nonatomic) BOOL canEdit;
@property (nonatomic) BOOL isShowNetImg;
@property (nonatomic) UIEdgeInsets insets;


/**
 生成NormalUploadViewController的基本设置

 @param title viewController title
 @param sectionCount collectionView的section数量
 @param numberOfItemInLine collectionView一行有多少个元素
 @param lineSpace collectionView行间距
 @param itemSpace collectionView元素艰巨
 @param canEdit item是否可以编辑（删除，新增）
 @param isShowNetImg item图片是否来源于网络图片
 @param insets collectionView section内边距
 @return NormalUploadVCSetting
 */
+(NormarlUploadVCSetting*)normalSettingWithVCTitle:(NSString*)title andSectionCount:(NSInteger)sectionCount andNumberOfItemInLine:(NSInteger)numberOfItemInLine andLineSpace:(float)lineSpace andItemSpace:(float)itemSpace andCanEdit:(BOOL)canEdit andIsShowNetImg:(BOOL)isShowNetImg andInsets:(UIEdgeInsets)insets;

@end
