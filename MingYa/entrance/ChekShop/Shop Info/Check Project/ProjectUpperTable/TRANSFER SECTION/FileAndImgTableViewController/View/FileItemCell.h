//
//  FileItemCell.h
//  MingYa
//
//  Created by 陈必锋 on 2017/10/19.
//  Copyright © 2017年 镓洲 王. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FileItemModel.h"

@interface FileItemCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *fileImgVIew;
@property (weak, nonatomic) IBOutlet UILabel *fileNameL;
@property (weak, nonatomic) IBOutlet UILabel *fileSizeL;

-(void)setupWithModel:(FileItemModel*)model;
@end
