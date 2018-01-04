//
//  ConstructionDatePickerVC.h
//  MingYa
//
//  Created by 镓洲 王 on 12/21/17.
//  Copyright © 2017 镓洲 王. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol ConstructionDatePickerVCDelegate<NSObject>

-(void)finishUpdateDate;

@end

@interface ConstructionDatePickerVC : UIViewController

@property (nonatomic,strong) NSString *projectId;
@property (nonatomic,strong) id delegate;


@end
