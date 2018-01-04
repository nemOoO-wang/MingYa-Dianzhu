//
//  PeopleItemCell.h
//  MingYa
//
//  Created by 陈必锋 on 2017/10/25.
//  Copyright © 2017年 镓洲 王. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PeopleItemModel.h"

@interface PeopleItemCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleL;

-(void)setupWithModel:(PeopleItemModel*)model;

@end
