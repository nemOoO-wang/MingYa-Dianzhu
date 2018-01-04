//
//  FileItemCell.m
//  MingYa
//
//  Created by 陈必锋 on 2017/10/19.
//  Copyright © 2017年 镓洲 王. All rights reserved.
//

#import "FileItemCell.h"

@implementation FileItemCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setupWithModel:(FileItemModel *)model{
    [self.fileImgVIew setImage:[UIImage imageNamed:[model fileIconImgName]]];
    [self.fileNameL setText:model.fileName];
    
    NSString* fileSizeStr = @"";
    if (model.fileSize < 1024 * 1024) {
        fileSizeStr = [NSString stringWithFormat:@"%.2fKB   %@",floorf(model.fileSize / 1024.0),model.isFinishDownload ? @"已下载" : @"未下载"];
    }else{
        fileSizeStr = [NSString stringWithFormat:@"%.2fM   %@",floorf(model.fileSize / 1024.0 / 1024.0),model.isFinishDownload ? @"已下载" : @"未下载"];
    }
    
    [self.fileSizeL setText:fileSizeStr];
}

@end
