//
//  ImgCollectionCell.h
//  MingYa
//
//  Created by 陈必锋 on 2017/10/20.
//  Copyright © 2017年 镓洲 王. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImgCollectionModel.h"

@interface ImgCollectionCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleL;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

-(void)setupWithModel:(ImgCollectionModel*)model;

@property (strong,nonatomic) UIViewController* baseVC;

@end
