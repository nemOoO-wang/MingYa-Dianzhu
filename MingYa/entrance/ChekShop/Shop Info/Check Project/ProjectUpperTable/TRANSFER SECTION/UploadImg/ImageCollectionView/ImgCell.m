//
//  ImgCell.m
//  MingYa
//
//  Created by 陈必锋 on 2017/10/18.
//  Copyright © 2017年 镓洲 王. All rights reserved.
//

#import "ImgCell.h"
#import <Masonry.h>
#import <UIImageView+WebCache.h>

@interface ImgCell()

@property (strong,nonatomic) UIImageView* imgView;

@end

@implementation ImgCell

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.imgView = [[UIImageView alloc]init];
        [self.contentView addSubview:self.imgView];
        
        [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.right.equalTo(self.contentView);
        }];
    }
    return self;
}

-(void)setupWithImgUrl:(NSString *)imgUrl andCanEdit:(BOOL)canEdit{
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:imgUrl]];
}

-(void)setupWithImgPHAsset:(PHAsset *)asset andCanEdit:(BOOL)canEdit{
    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
    options.deliveryMode = PHImageRequestOptionsDeliveryModeOpportunistic;
    options.synchronous = YES;
    
    [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:self.bounds.size contentMode:PHImageContentModeAspectFit options:options resultHandler:^(UIImage *result, NSDictionary *info) {
        [self.imgView setImage:result];
    }];
    
}

-(void)setupAsAddImg{
    [self.imgView setImage:[UIImage imageNamed:@"add"]];
}



@end
