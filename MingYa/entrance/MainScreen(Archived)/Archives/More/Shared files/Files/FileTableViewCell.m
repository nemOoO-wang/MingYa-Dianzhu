//
//  FileTableViewCell.m
//  MingYa
//
//  Created by 镓洲 王 on 10/25/17.
//  Copyright © 2017 镓洲 王. All rights reserved.
//

#import "FileTableViewCell.h"


@interface FileTableViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *fileNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;

@end

@implementation FileTableViewCell
// set dict
-(void)setDict:(NSDictionary *)dict{
    _dict = dict;
    // time
    NSInteger timestamp = [dict[@"shareDate"] integerValue]/1000.f;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timestamp];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    self.detailLabel.text = [formatter stringFromDate:date];
    // image
    NSString *fileType = dict[@"shareSuffix"];
    if ([fileType isEqualToString:@"xls"] || [fileType isEqualToString:@"xlsx"]) {
        [self.imgView setImage:[UIImage imageNamed:@"icon_excel2"]];
    }else if ([fileType isEqualToString:@"ai"]) {
        [self.imgView setImage:[UIImage imageNamed:@"icon_ai2"]];
    }else if ([fileType isEqualToString:@"doc"] || [fileType isEqualToString:@"docx"]) {
        [self.imgView setImage:[UIImage imageNamed:@"icon_word2"]];
    }else if ([fileType isEqualToString:@"pdf"]) {
        [self.imgView setImage:[UIImage imageNamed:@"icon_pdf2"]];
    }else if ([fileType isEqualToString:@"power"]) {
        [self.imgView setImage:[UIImage imageNamed:@"icon_power2"]];
    }else if ([fileType isEqualToString:@"ps"]) {
        [self.imgView setImage:[UIImage imageNamed:@"icon_ps2"]];
    }else if ([fileType isEqualToString:@"rar"] || [fileType isEqualToString:@"zip"]) {
        [self.imgView setImage:[UIImage imageNamed:@"icon_rar2"]];
    }else{
        [self.imgView setImage:[UIImage imageNamed:@"icon_unknow2"]];
    }
    // file name
    NSString *fileName = dict[@"shareName"];
    self.fileNameLabel.text = [NSString stringWithFormat:@"%@.%@",fileName,fileType];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
