//
//  NMAnnotationView.h
//  MingYa
//
//  Created by 镓洲 王 on 10/12/17.
//  Copyright © 2017 镓洲 王. All rights reserved.
//

#import <MAMapKit/MAMapKit.h>

@interface NMAnnotationView : MAAnnotationView

@property (nonatomic,strong) UIButton *btn;

@property (nonatomic,strong) NSString *projectId;

-(void)addBtnWithName:(NSString *)shopName andProjectId:(NSString *)projectId;
-(void)updateBtnWithName:(NSString *)shopName andProjectId:(NSString *)projectId;

@end
