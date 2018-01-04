//
//  PeoplePickerViewController.h
//  MingYa
//
//  Created by 陈必锋 on 2017/10/25.
//  Copyright © 2017年 镓洲 王. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PeopleItemCell.h"

@interface PeoplePickerViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIImageView *searchIcon;
@property (weak, nonatomic) IBOutlet UITextField *searchTF;

@property (strong,nonatomic) void(^peopleSelected)(PeopleItemModel* userModel);

// 施工人员 id
@property (nonatomic,strong) NSString *constructionManId;

@end
