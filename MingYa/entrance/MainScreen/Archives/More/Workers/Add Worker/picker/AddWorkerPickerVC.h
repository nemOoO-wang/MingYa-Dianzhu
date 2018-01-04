//
//  AddWorkerPickerVC.h
//  MingYa
//
//  Created by 镓洲 王 on 10/25/17.
//  Copyright © 2017 镓洲 王. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddWorkerPickerVC : UIViewController

@property (nonatomic,strong) NSString *identifier;
@property (nonatomic,strong) NSArray *proArr;
@property (nonatomic,strong) NSArray *workerTypeArr;
@property (nonatomic,strong) NSDictionary *selectedWorkerTypeDic;
@property (nonatomic,strong) NSDictionary *selectedCityDic;

@end
