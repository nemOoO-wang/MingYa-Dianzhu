//
//  ImgItemCollectionCell.m
//  MingYa
//
//  Created by 陈必锋 on 2017/10/20.
//  Copyright © 2017年 镓洲 王. All rights reserved.
//

#import "ImgItemCollectionCell.h"
#import <UIImageView+WebCache.h>

@implementation ImgItemCollectionCell

-(void)setupWithImgUrl:(NSString *)imgUrl{
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:[imgUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        CGSize imgSize = image.size;
        CGSize cellSize = self.contentView.frame.size;
        
        if (imgSize.height / imgSize.width > cellSize.height / cellSize.width) {
            [self.imgView setContentMode:UIViewContentModeScaleAspectFit];
        }else{
            [self.imgView setContentMode:UIViewContentModeScaleAspectFill];
        }
    }];
}

@end
