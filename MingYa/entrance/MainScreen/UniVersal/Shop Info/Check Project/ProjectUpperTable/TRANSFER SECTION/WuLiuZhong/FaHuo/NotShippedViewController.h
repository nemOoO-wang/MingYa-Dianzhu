//
//  NotShippedViewController.h
//  MingYa
//
//  Created by 陈必锋 on 2017/10/24.
//  Copyright © 2017年 镓洲 王. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NotShippedViewController : UIViewController

@property (nonatomic) BOOL isShipped;
@property (nonatomic,strong) NSString *projectId;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)addItemBtnClick:(id)sender;
- (IBAction)submitBtnClick:(id)sender;

@end
