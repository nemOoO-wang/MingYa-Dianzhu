

//
//  WorkersTableCell.m
//  MingYa
//
//  Created by 镓洲 王 on 12/6/17.
//  Copyright © 2017 镓洲 王. All rights reserved.
//

#import "WorkersTableCell.h"
#import "RoundImgView.h"
#import <SDWebImage/UIImageView+WebCache.h>


@interface WorkersTableCell()
@property (weak, nonatomic) IBOutlet RoundImgView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *workerTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *areaLabel;
@property (weak, nonatomic) IBOutlet UIButton *phoneNumButton;
@end


@implementation WorkersTableCell

-(void)setDataDict:(NSDictionary *)dataDict{
    _dataDict = dataDict;
    self.nameLabel.text = dataDict[@"personalname"];
    self.workerTypeLabel.text = dataDict[@"name"];
    [self.phoneNumButton setTitle:dataDict[@"tel"] forState:UIControlStateNormal];
    // head img
    NSString *imgUrl = dataDict[@"image"];
    if (![imgUrl isEqualToString:@""]) {
        // 存在照片链接
        NSURL *url = [NSURL URLWithString:imgUrl];
        [self.headImageView sd_setImageWithURL:url];
    }
    // area string
    NSString *areaStr = [NSString stringWithFormat:@"%@%@",dataDict[@"city"],dataDict[@"area"]];
    self.areaLabel.text = areaStr;
}


# pragma mark - click call btn
- (IBAction)clickCallNumBtn:(id)sender {
    UIButton *phoneBtn = (UIButton *)sender;
    NSString *phoneNumber = phoneBtn.titleLabel.text;
    NSString *urlStr = [NSString stringWithFormat:@"telprompt://%@",phoneNumber];
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:urlStr] options:@{}
                            completionHandler:^(BOOL success) {
                                if (!success) {
                                    NSLog(@"拨打电话失败!!");
                                }
                            }];
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
