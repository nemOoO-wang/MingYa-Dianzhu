//
//  ImgItemCollectionCell.h
//  MingYa
//
//  Created by 陈必锋 on 2017/10/20.
//  Copyright © 2017年 镓洲 王. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImgCollectionModel.h"

@interface ImgItemCollectionCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgView;

-(void)setupWithImgUrl:(NSString*)imgUrl;

@end
