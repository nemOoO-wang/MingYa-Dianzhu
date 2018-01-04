//
//  FileAndImgViewController.h
//  MingYa
//
//  Created by 陈必锋 on 2017/10/19.
//  Copyright © 2017年 镓洲 王. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FileAndImgViewController : UIViewController

@property (nonatomic,strong) NSString *projectId;
@property (nonatomic,assign) NSInteger sc;
@property (nonatomic,strong) NSString *detailId;
@property (nonatomic,strong) NSString *sectionName;
@property (nonatomic,strong) NSDate *finishDate;
// 店主已确认的蓝条
@property (nonatomic,assign) BOOL shouldShowBanner;
// request user name
@property (nonatomic,strong) NSString *userId;
@property (nonatomic,strong) NSString *userName;
@property (nonatomic,strong) NSString *workerType;


@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIImageView *noDataTipIcon;
@property (weak, nonatomic) IBOutlet UILabel *noDataTipL;

@end
