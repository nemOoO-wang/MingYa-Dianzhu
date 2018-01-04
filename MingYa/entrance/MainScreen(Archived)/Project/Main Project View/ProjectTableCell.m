//
//  ProjectTableCell.m
//  MingYa
//
//  Created by 镓洲 王 on 10/19/17.
//  Copyright © 2017 镓洲 王. All rights reserved.
//

#import "ProjectTableCell.h"
#import "MYProjectFlowNames.h"


@interface ProjectTableCell()
@property (weak, nonatomic) IBOutlet UILabel *shopNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *brandLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UILabel *positionLabel;
@property (weak, nonatomic) IBOutlet UILabel *progressLabel;

@end

@implementation ProjectTableCell

# pragma mark - auto set sub views
// set project
-(void)setInfoProject:(NSDictionary *)infoProject{
    _infoProject = infoProject;
    self.shopNameLabel.text = infoProject[@"projectName"];
    self.brandLabel.text = infoProject[@"brandName"];
    // get section and row
    NSInteger schedule = [infoProject[@"schedule"] integerValue];
    NSInteger section = schedule / 100;
    NSInteger row = schedule % 100;
#warning 防后台错误数据越界
    if (section<=8 && section>=0) {
        // 数据正确
    }else{
        section = 0;
        NSLog(@"后台存在错误数据：节点schedule");
    }
    if (row > 0) {
        // 数据正确
    }else{
        row = 1;
        NSLog(@"后台存在错误数据：节点schedule");
    }
    
    NSString *status = [[MYProjectFlowNames sharedInstance] getNameOfSection:section andRow:row];
    self.statusLabel.text = status;
    if ([status isEqualToString:@"暂停中"]) {
        [self.statusLabel setTextColor:[UIColor colorWithHexString:@"#FF5736"]];
    }else{
        [self.statusLabel setTextColor:[UIColor colorWithHexString:@"#429BFF"]];
    }
    self.progressLabel.text = status;
    // get position
    NSString *position = [NSString stringWithFormat:@"%@ - %@",infoProject[@"province"], infoProject[@"city"]];
    self.positionLabel.text = position;
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
