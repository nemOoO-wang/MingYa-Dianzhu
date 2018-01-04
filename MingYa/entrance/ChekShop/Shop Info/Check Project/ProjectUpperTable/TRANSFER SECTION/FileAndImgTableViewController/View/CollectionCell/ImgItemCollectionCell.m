//
//  ImgItemCollectionCell.m
//  MingYa
//
//  Created by 陈必锋 on 2017/10/20.
//  Copyright © 2017年 镓洲 王. All rights reserved.
//

#import "ImgItemCollectionCell.h"
#import <SDWebImageDownloader.h>

@implementation ImgItemCollectionCell

-(void)setupWithImgUrl:(NSString *)imgUrl{
    [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:imgUrl] options:SDWebImageDownloaderProgressiveDownload progress:nil completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
        [self.imgView setImage:image];
    }];
}

@end
