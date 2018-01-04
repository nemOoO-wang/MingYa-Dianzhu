//
//  ImgItemCell.h
//  MingYa
//
//  Created by 陈必锋 on 2017/12/27.
//  Copyright © 2017年 镓洲 王. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImgItemCell : UICollectionViewCell

-(void)setImg:(UIImage*)img;
-(void)setImgUrl:(NSString*)url;

-(UIImage*)img;
@end
