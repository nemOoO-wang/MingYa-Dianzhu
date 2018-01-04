//
//  ConstructionViewController.h
//  MingYa
//
//  Created by 陈必锋 on 2017/10/26.
//  Copyright © 2017年 镓洲 王. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageShowCollectionView.h"

@interface ConstructionViewController : UIViewController

@property (nonatomic,strong) NSString *projectId;
@property (nonatomic,assign) NSInteger sc;
@property (nonatomic,strong) NSString *detailId;
@property (nonatomic,strong) NSString *sectionName;
// 设置顶部 button 显示
@property (nonatomic,assign) BOOL showAsSingleCollection;

@property (weak, nonatomic) IBOutlet UIButton *checkConstructBtn;
@property (weak, nonatomic) IBOutlet UIButton *constructingBtn;
@property (weak, nonatomic) IBOutlet UIButton *constructedBtn;
@property (weak, nonatomic) IBOutlet UIScrollView *mainScrollView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *alignToConstructing;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *alignToConstructed;

- (IBAction)checkConstructionBtnClick:(id)sender;
- (IBAction)constructingBtnClick:(id)sender;
- (IBAction)constructedBtnClick:(id)sender;

@end
