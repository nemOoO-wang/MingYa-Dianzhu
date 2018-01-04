//
//  ShopInfoTableCell.m
//  MingYa
//
//  Created by 镓洲 王 on 10/16/17.
//  Copyright © 2017 镓洲 王. All rights reserved.
//

#import "ShopInfoTableCell.h"
#import "NMTextView.h"


@interface ShopInfoTableCell()
@property (weak, nonatomic) IBOutlet UILabel *leftLabel;
@property (weak, nonatomic) IBOutlet NMTextView *detailTextField;
@property (nonatomic,weak) IBOutlet UILabel *rightLabel;
@property (nonatomic,weak) IBOutlet UIButton *telNumBtn;
@property (weak, nonatomic) IBOutlet NMButton *statusBtn;


@end

@implementation ShopInfoTableCell
# pragma mark - set sub view
-(void)setProjectIsStopping:(BOOL)projectIsStopping{
    _projectIsStopping = projectIsStopping;
    NSString *statusStr = projectIsStopping? @"工程暂停中": @"工程进行中";
    [self.statusBtn setTitle:statusStr forState:UIControlStateNormal];
}

-(void)setLeftName:(NSString *)leftName{
    _leftName = leftName;
    self.leftLabel.text = leftName;
}
-(void)setDetailText:(NSString *)detailText{
    _detailText = detailText;
    self.detailTextField.text = detailText;
}
-(void)setRightText:(NSString *)rightText{
    _rightText = rightText;
    self.rightLabel.text = rightText;
}
-(void)setPhontNumText:(NSString *)phontNumText{
    _phontNumText = phontNumText;
    [self.telNumBtn setTitle:phontNumText forState:UIControlStateNormal];
}


#pragma mark - call phone
- (IBAction)clickCallBtn:(id)sender {
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
