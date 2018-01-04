//
//  ProjectCollectionReusableView.m
//  MingYa
//
//  Created by 镓洲 王 on 11/24/17.
//  Copyright © 2017 镓洲 王. All rights reserved.
//

#import "ProjectCollectionReusableView.h"


@interface ProjectCollectionReusableView()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *label2TopConstraint;

@end


@implementation ProjectCollectionReusableView

-(void)setHeaderName:(NSString *)headerName{
    _headerName = headerName;
    self.label.text = headerName;
}

-(void)setShowLabel:(BOOL)showLabel{
    _showLabel = showLabel;
    self.label2TopConstraint.constant = showLabel? 15: 0;
}

@end
