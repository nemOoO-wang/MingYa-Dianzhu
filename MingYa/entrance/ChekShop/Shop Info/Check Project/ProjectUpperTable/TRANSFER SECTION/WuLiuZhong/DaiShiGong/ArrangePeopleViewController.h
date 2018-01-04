//
//  ArrangePeopleViewController.h
//  MingYa
//
//  Created by 陈必锋 on 2017/10/25.
//  Copyright © 2017年 镓洲 王. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ArrangePeopleViewController : UIViewController
// time
@property (weak, nonatomic) IBOutlet UILabel *expectedTimeL;
@property (weak, nonatomic) IBOutlet UILabel *realTimeL;
@property (weak, nonatomic) IBOutlet UILabel *expectedToShopTimeL;
// people
@property (weak, nonatomic) IBOutlet UILabel *constructionPeopleL;
@property (weak, nonatomic) IBOutlet UILabel *leaderPeopleL;


@property (strong, nonatomic) IBOutletCollection(NSLayoutConstraint) NSArray *rightToBorder;

- (IBAction)realTimeClick:(id)sender;
- (IBAction)expectedToShopTimeClick:(id)sender;
- (IBAction)constructionPeopleClick:(id)sender;
- (IBAction)leaderPeopleClick:(id)sender;


@property (nonatomic) BOOL isFinishArrange;
@property (nonatomic,strong) NSString *projectId;


@end
