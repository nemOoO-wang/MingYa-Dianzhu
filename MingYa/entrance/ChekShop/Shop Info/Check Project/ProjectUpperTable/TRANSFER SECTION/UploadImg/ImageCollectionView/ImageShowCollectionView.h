//
//  ImageShowCollectionView.h
//  MingYa
//
//  Created by 陈必锋 on 2017/10/18.
//  Copyright © 2017年 镓洲 王. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NormarlUploadVCSetting.h"

@class ImageShowCollectionView;

@protocol ImageShowCollectionDelegate <NSObject>

-(void)didSelectCountAtSection:(NSInteger)section andCount:(NSInteger)count inCollectionView:(ImageShowCollectionView*)collectionView;
-(NSInteger)maxItemCountAtSection:(NSInteger)section inCollectionView:(ImageShowCollectionView*)collectionView;

@optional
-(NSString*)sectionHeaderTitleInCollectionView:(ImageShowCollectionView*)collectionView andSection:(NSInteger)section;
-(CGFloat)sectionHeaderHeightInCollectionView:(ImageShowCollectionView*)collectionView andSection:(NSInteger)section;

@end


@interface ImageShowCollectionView : UICollectionView

@property (assign,nonatomic) id<ImageShowCollectionDelegate> imgDelegate;

//一行有多少个item
@property (nonatomic) NSInteger numberOfItemInLine;
//行间距
@property (nonatomic) CGFloat lineSpace;
//列间距
@property (nonatomic) CGFloat itemSpace;

//是否可编辑
@property (nonatomic) BOOL canEdit;
//是否显示网络图片
@property (nonatomic) BOOL isShowNetImg;

//section内边距
@property (nonatomic) UIEdgeInsets insets;

//section个数
@property (nonatomic) NSInteger sectionsCount;


-(NSArray*)imgsOf1stSection;
-(NSArray*)imgsWithSection:(NSInteger)sectionIdx;
-(void)clearDatas;
-(void)setupWithNormalSetting:(NormarlUploadVCSetting*)setting;
@end
