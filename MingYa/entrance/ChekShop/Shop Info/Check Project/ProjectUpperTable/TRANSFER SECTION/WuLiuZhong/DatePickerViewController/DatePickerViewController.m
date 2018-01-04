//
//  DatePickerViewController.m
//  MingYa
//
//  Created by 陈必锋 on 2017/10/24.
//  Copyright © 2017年 镓洲 王. All rights reserved.
//

#import "DatePickerViewController.h"

@interface DatePickerViewController ()

@end

@implementation DatePickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (self.nowSelectDateStr != nil && ![self.nowSelectDateStr isEqualToString:@""]) {
        NSDateFormatter* df = [[NSDateFormatter alloc]init];
        [df setDateFormat:@"yyyy-MM-dd"];
        [self.datePicker setDate:[df dateFromString:self.nowSelectDateStr]];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self dismissViewControllerAnimated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (IBAction)submitBtnClick:(id)sender {
    if (self.dateChanged != nil) {
        self.dateChanged(self.datePicker.date);
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
