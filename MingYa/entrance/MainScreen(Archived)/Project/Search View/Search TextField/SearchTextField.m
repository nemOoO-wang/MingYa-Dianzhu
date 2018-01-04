//
//  SearchTextField.m
//  MingYa
//
//  Created by 镓洲 王 on 10/16/17.
//  Copyright © 2017 镓洲 王. All rights reserved.
//

#import "SearchTextField.h"

@implementation SearchTextField

-(void)setLeftViewImg:(UIImage *)leftViewImg{
    _leftViewImg = leftViewImg;
    UIImageView *imgView = [[UIImageView alloc] init];
    imgView.frame = CGRectMake(15, 7, 16, 20);
    imgView.image = leftViewImg;
    [self addSubview:imgView];
//    self.leftView = imgView;
//    self.leftViewMode = UITextFieldViewModeAlways;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
