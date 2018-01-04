//
//  TilteAndValueCell.h
//  MingYa
//
//  Created by 陈必锋 on 2017/10/26.
//  Copyright © 2017年 镓洲 王. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TitleAndValueModel.h"

@interface TilteAndValueCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleL;
@property (weak, nonatomic) IBOutlet UILabel *valueL;

-(void)setupWithModel:(TitleAndValueModel*)model;

@end
