//
//  DatePickerViewController.h
//  MingYa
//
//  Created by 陈必锋 on 2017/10/24.
//  Copyright © 2017年 镓洲 王. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DatePickerViewController : UIViewController

@property (strong,nonatomic) void(^dateChanged)(NSDate* date);
@property (strong,nonatomic) NSString* nowSelectDateStr;
@property (nonatomic,strong) NSDate *nowSelectDate;


@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

- (IBAction)submitBtnClick:(id)sender;

@end
