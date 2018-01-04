//
//  ImageShowCollectionView.m
//  MingYa
//
//  Created by 陈必锋 on 2017/10/18.
//  Copyright © 2017年 镓洲 王. All rights reserved.
//

#import "ImageShowCollectionView.h"
#import "ImgCell.h"
#import "TitleHeaderReusableView.h"

#import <QBImagePickerController.h>

@interface ImageShowCollectionView () <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,QBImagePickerControllerDelegate>

@property (strong,nonatomic) NSMutableArray* imgDatas;
@property (strong,nonatomic) QBImagePickerController* qbImgPicker;

@property (nonatomic) NSInteger selectPhotoSectionIndex;

@property (nonatomic) CGSize imgItemSize;

@end

@implementation ImageShowCollectionView

-(void)clearDatas{
    NSMutableOrderedSet* set = self.qbImgPicker.selectedAssets;
    [set removeAllObjects];
    [self.imgDatas makeObjectsPerformSelector:@selector(removeAllObjects)];
    [self reloadData];
}

-(void)awakeFromNib{
    [super awakeFromNib];
    self.delegate = self;
    self.dataSource = self;
    
    [self registerClass:[ImgCell class] forCellWithReuseIdentifier:@"ImgCell"];
    [self registerClass:[TitleHeaderReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"TitleHeaderReusableView"];
    
    self.qbImgPicker = [[QBImagePickerController alloc]init];
    self.qbImgPicker.delegate = self;
    [self.qbImgPicker setMediaType:QBImagePickerMediaTypeImage];
    [self.qbImgPicker setAllowsMultipleSelection:YES];
    [self.qbImgPicker setShowsNumberOfSelectedAssets:YES];
}

-(void)setupWithNormalSetting:(NormarlUploadVCSetting *)setting{
    self.numberOfItemInLine = setting.numberOfItemInLine;
    self.lineSpace = setting.lineSpace;
    self.itemSpace = setting.itemSpace;
    self.canEdit = setting.canEdit;
    self.isShowNetImg = setting.isShowNetImg;
    self.insets = setting.insets;
    self.sectionsCount = setting.sectionCount;
    
    self.imgDatas = [NSMutableArray array];
    for (NSInteger i = 0; i < self.sectionsCount; i++) {
        [self.imgDatas addObject:[NSMutableArray array]];
    }
    [self reloadData];
}

- (UIViewController *)viewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}


-(NSArray*)imgsOf1stSection{
    return [self imgsWithSection:0];
}

-(NSArray *)imgsWithSection:(NSInteger)sectionIdx{
    NSMutableArray* imgs = [NSMutableArray array];
    
    for (NSInteger i = 0; i < [self.imgDatas[sectionIdx] count] ; i++) {
        PHAsset* asset = self.imgDatas[sectionIdx][i];
        
        PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
        options.deliveryMode = PHImageRequestOptionsDeliveryModeOpportunistic;
        options.synchronous = YES;
        
        [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:CGSizeMake(asset.pixelWidth, asset.pixelHeight) contentMode:PHImageContentModeAspectFit options:options resultHandler:^(UIImage *result, NSDictionary *info) {
            [imgs addObject:result];
        }];
    }
    
    return imgs;
}

#pragma mark - UICollectionViewDelegate
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger maxCount = 0;
    if ([self.imgDelegate respondsToSelector:@selector(maxItemCountAtSection:inCollectionView:)]) {
        maxCount = [self.imgDelegate maxItemCountAtSection:indexPath.section inCollectionView:self];
    }
    
    if (indexPath.item == [self.imgDatas[indexPath.section] count]) {
        self.selectPhotoSectionIndex = indexPath.section;
        
        NSMutableOrderedSet* set = self.qbImgPicker.selectedAssets;
        [set removeAllObjects];
        [set addObjectsFromArray:self.imgDatas[indexPath.section]];
        
        [self.qbImgPicker setMaximumNumberOfSelection:maxCount];
        
        [[self viewController] presentViewController:self.qbImgPicker animated:YES completion:nil];
    }else{
        if (self.canEdit) {
            NSMutableOrderedSet* set = self.qbImgPicker.selectedAssets;
            [set removeObject:self.imgDatas[indexPath.section][indexPath.item]];
            
            if (maxCount == [self.imgDatas[indexPath.section] count]) {
                [self.imgDatas[indexPath.section] removeObjectAtIndex:indexPath.item];
                [self reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section]];
            }else{
                [self.imgDatas[indexPath.section] removeObjectAtIndex:indexPath.item];
                [self deleteItemsAtIndexPaths:@[indexPath]];
            }
            
            
            if ([self.imgDelegate respondsToSelector:@selector(didSelectCountAtSection:andCount:inCollectionView:)]) {
                [self.imgDelegate didSelectCountAtSection:indexPath.section andCount:[self.imgDatas[self.selectPhotoSectionIndex] count] inCollectionView:self];
            }
        }
    }
}

#pragma mark - UICollectionViewDataSource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return [self.imgDatas count];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (self.canEdit) {
        NSInteger maxCount = 0;
        if ([self.imgDelegate respondsToSelector:@selector(maxItemCountAtSection:inCollectionView:)]) {
            maxCount = [self.imgDelegate maxItemCountAtSection:section inCollectionView:self];
        }
        
        if ([self.imgDatas[section] count] == maxCount) {
            return maxCount;
        }else{
            return [self.imgDatas[section] count] + 1;
        }
    }else{
        return [self.imgDatas[section] count];
    }
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ImgCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ImgCell" forIndexPath:indexPath];
    
    if (indexPath.item == [self.imgDatas[indexPath.section] count]) {
        [cell setupAsAddImg];
    }else{
        if (self.isShowNetImg) {
            [cell setupWithImgUrl:self.imgDatas[indexPath.section][indexPath.item] andCanEdit:self.canEdit];
        }else{
            [cell setupWithImgPHAsset:self.imgDatas[indexPath.section][indexPath.item] andCanEdit:self.canEdit];
        }
    }
    
    return cell;
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if (kind == UICollectionElementKindSectionHeader) {
        TitleHeaderReusableView* view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"TitleHeaderReusableView" forIndexPath:indexPath];
        NSString* title = @"";
        if ([self.imgDelegate respondsToSelector:@selector(sectionHeaderTitleInCollectionView:andSection:)]) {
            title = [self.imgDelegate sectionHeaderTitleInCollectionView:self andSection:indexPath.section];
        }
        [view setupWithTitle:title];
        return view;
    }
    return nil;
}


#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    float itemWidth = (ScreenWidth - (self.insets.left + self.insets.right) - self.itemSpace * self.numberOfItemInLine) / self.numberOfItemInLine;
    self.imgItemSize = CGSizeMake(itemWidth, itemWidth);
    return self.imgItemSize;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return self.insets;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return self.lineSpace;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return self.itemSpace;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    CGFloat viewHeight = 0;
    if ([self.imgDelegate respondsToSelector:@selector(sectionHeaderHeightInCollectionView:andSection:)]) {
        viewHeight = [self.imgDelegate sectionHeaderHeightInCollectionView:self andSection:section];
    }
    return CGSizeMake(ScreenWidth, viewHeight);
}

#pragma mark - QBImagePickerControllerDelegate
- (void)qb_imagePickerController:(QBImagePickerController *)imagePickerController didFinishPickingAssets:(NSArray *)assets{
    self.imgDatas[self.selectPhotoSectionIndex] = [NSMutableArray arrayWithArray:assets];
    
    if ([self.imgDelegate respondsToSelector:@selector(didSelectCountAtSection:andCount:inCollectionView:)]) {
        [self.imgDelegate didSelectCountAtSection:0 andCount:[self.imgDatas[self.selectPhotoSectionIndex] count] inCollectionView:self];
    }
    
    [self reloadData];
    [imagePickerController dismissViewControllerAnimated:YES completion:nil];
}

- (void)qb_imagePickerControllerDidCancel:(QBImagePickerController *)imagePickerController{
    [imagePickerController dismissViewControllerAnimated:YES completion:nil];
}

-(void)qb_imagePickerController:(QBImagePickerController *)imagePickerController didDeselectAsset:(PHAsset *)asset{
    NSInteger itemIdx = [self.imgDatas[self.selectPhotoSectionIndex] indexOfObject:asset];
    
    if (itemIdx == NSNotFound) {
        return;
    }
    
    [self.imgDatas[self.selectPhotoSectionIndex] removeObjectAtIndex:itemIdx];
    [self deleteItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:itemIdx inSection:self.selectPhotoSectionIndex]]];
    
    if ([self.imgDelegate respondsToSelector:@selector(didSelectCountAtSection:andCount:inCollectionView:)]) {
        [self.imgDelegate didSelectCountAtSection:0 andCount:[self.imgDatas[self.selectPhotoSectionIndex] count] inCollectionView:self];
    }
}

@end
