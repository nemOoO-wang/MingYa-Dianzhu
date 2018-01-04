//
//  TitleHeaderReusableView.m
//  MingYa
//
//  Created by 陈必锋 on 2017/10/26.
//  Copyright © 2017年 镓洲 王. All rights reserved.
//

#import "TitleHeaderReusableView.h"
#import <Masonry.h>

@interface TitleHeaderReusableView ()

@property (strong,nonatomic) UILabel* titleL;

@end

@implementation TitleHeaderReusableView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.titleL = [[UILabel alloc]init];
        [self.titleL setFont:[UIFont systemFontOfSize:13]];
        [self.titleL setTextColor:[UIColor colorWithHexString:@"#1C1C1C"]];
        [self addSubview:self.titleL];
        
        [self.titleL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.left.equalTo(self).offset(20);
        }];
    }
    return self;
}

-(void)setupWithTitle:(NSString *)title{
    self.titleL.text = title;
}

@end
