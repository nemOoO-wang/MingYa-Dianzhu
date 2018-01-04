//
//  ImgCell.h
//  MingYa
//
//  Created by 陈必锋 on 2017/10/18.
//  Copyright © 2017年 镓洲 王. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>

@interface ImgCell : UICollectionViewCell

-(void)setupWithImgUrl:(NSString*)imgUrl andCanEdit:(BOOL)canEdit;
-(void)setupWithImgPHAsset:(PHAsset*)asset andCanEdit:(BOOL)canEdit;
-(void)setupAsAddImg;

@end
