//
//  SharedPicHeaderView.m
//  MingYa
//
//  Created by 镓洲 王 on 10/26/17.
//  Copyright © 2017 镓洲 王. All rights reserved.
//

#import "SharedPicHeaderView.h"


@interface SharedPicHeaderView()
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end

@implementation SharedPicHeaderView
-(void)setTime:(NSString *)time{
    self.timeLabel.text = time;
}

@end
