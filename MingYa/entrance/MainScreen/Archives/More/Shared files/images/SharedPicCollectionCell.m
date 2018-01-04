//
//  SharedPicCollectionCell.m
//  MingYa
//
//  Created by 镓洲 王 on 10/26/17.
//  Copyright © 2017 镓洲 王. All rights reserved.
//

#import "SharedPicCollectionCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface SharedPicCollectionCell()
@property (weak, nonatomic) IBOutlet UIImageView *imgView;

@end

@implementation SharedPicCollectionCell

-(void)setImageDict:(NSDictionary *)imageDict{
    _imageDict = imageDict;
    UIImage *holderImg = [UIImage imageNamed:@"icon_unknow"];
    [self.imgView sd_setImageWithURL:imageDict[@"shareUrl"] placeholderImage:holderImg];
}

@end
