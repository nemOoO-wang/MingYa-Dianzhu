//
//  ImgItemCell.m
//  MingYa
//
//  Created by 陈必锋 on 2017/12/27.
//  Copyright © 2017年 镓洲 王. All rights reserved.
//

#import "ImgItemCell.h"

#import <Masonry.h>
#import <UIImageView+WebCache.h>

@interface ImgItemCell () <UIScrollViewDelegate>

@property (strong,nonatomic) UIScrollView* scrollView;
@property (strong,nonatomic) UIImageView* imgView;

@end

@implementation ImgItemCell

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

-(void)setupUI{
    self.scrollView = [[UIScrollView alloc] init];
    self.scrollView.minimumZoomScale = 1;
    self.scrollView.maximumZoomScale = 1.5;
    self.scrollView.delegate = self;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    
    [self.contentView addSubview:self.scrollView];
    
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.equalTo(self.contentView);
    }];
    
    UIView* scrollContentView = [[UIView alloc] init];
    scrollContentView.userInteractionEnabled = NO;
    [self.scrollView addSubview:scrollContentView];
    
    [scrollContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.with.height.equalTo(self.scrollView);
        make.width.height.equalTo(self.scrollView);
    }];
    
    self.imgView = [[UIImageView alloc] init];
    [scrollContentView addSubview:self.imgView];
    
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(scrollContentView);
    }];
}

-(CGFloat)nowImgRealWidth{
    return self.scrollView.contentSize.width;
}

-(CGFloat)nowImgRealHeight{
    return self.scrollView.contentSize.width / self.imgView.image.size.width * self.imgView.image.size.height;
}

-(void)makeHeightCenter{
    CGSize imgSize = CGSizeMake([self nowImgRealWidth], [self nowImgRealHeight]);
    CGSize scrollSize = self.scrollView.frame.size;
    
//    NSLog(@"size:%@-------%@",NSStringFromCGSize(imgSize),NSStringFromCGSize(scrollSize));
    
    if (scrollSize.height > imgSize.height){
        [self.scrollView setContentOffset:CGPointMake(self.scrollView.contentOffset.x , (CGRectGetHeight(self.scrollView.subviews[0].frame) - scrollSize.height) / 2) animated:YES];
    }else{
        CGFloat minOffsetY = (CGRectGetHeight(self.scrollView.subviews[0].frame) - imgSize.height) / 2;
        CGFloat maxOffsetY = (CGRectGetHeight(self.scrollView.subviews[0].frame) - imgSize.height) / 2 + imgSize.height - scrollSize.height;
        CGFloat offsetY = self.scrollView.contentOffset.y;
        
        if (offsetY < minOffsetY) {
            [self.scrollView setContentOffset:CGPointMake(self.scrollView.contentOffset.x, minOffsetY) animated:YES];
        }
        
        if (offsetY > maxOffsetY) {
            [self.scrollView setContentOffset:CGPointMake(self.scrollView.contentOffset.x, maxOffsetY) animated:YES];
        }
    }
}

#pragma mark - UIScrollViewDelegate
-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return self.scrollView.subviews[0];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self makeHeightCenter];
}

-(void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale{
    [self makeHeightCenter];
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self makeHeightCenter];
}

//-(void)scrollViewDidZoom:(UIScrollView *)scrollView{
//    [self makeHeightCenter];
//}
//
//-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    [self makeHeightCenter];
//}




-(void)setImg:(UIImage *)img{
    [self.imgView setImage:img];
}

-(UIImage *)img{
    return self.imgView.image;
}

-(void)setImgUrl:(NSString *)url{
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] ] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        CGSize imgSize = image.size;
        CGSize cellSize = self.contentView.frame.size;
        
        if (imgSize.height / imgSize.width > cellSize.height / cellSize.width) {
            [self.imgView setContentMode:UIViewContentModeScaleAspectFit];
        }else{
            [self.imgView setContentMode:UIViewContentModeScaleAspectFit];
        }
    }];
}
@end
