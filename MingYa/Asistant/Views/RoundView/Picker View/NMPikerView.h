//
//  NMPikerView.h
//  铭雅装饰
//
//  Created by 镓洲 王 on 10/9/17.
//  Copyright © 2017 镓洲 王. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NMRoundView.h"


@interface NMPikerView: NMRoundView

@property (nonatomic,strong) NSString *identifier;

/// 先调用init 方法赋值 constraint 自动计算以下变量
@property (nonatomic,strong) NSLayoutConstraint *view2BottomConstraint;
@property (nonatomic,assign) CGFloat hidePickerConstant;
@property (nonatomic,assign) CGFloat showPickerConstant;



// 初始化位置
-(void)initFrameInSuperViewWithConstraint:(NSLayoutConstraint *)constraint showConstant:(CGFloat)showConstant;
// 通用动画处理
-(void)animateWithViewController:(UIViewController *)controller TargetIdentifier:(NSString *)identifer;


@end
