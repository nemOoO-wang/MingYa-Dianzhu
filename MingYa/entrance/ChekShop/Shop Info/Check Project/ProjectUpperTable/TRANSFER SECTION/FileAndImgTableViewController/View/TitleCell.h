//
//  TitleCell.h
//  MingYa
//
//  Created by 陈必锋 on 2017/10/19.
//  Copyright © 2017年 镓洲 王. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TitleModel.h"

@interface TitleCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleL;

-(void)setupWithModel:(TitleModel*)model;
@end
