//
//  NMPikerView.m
//  铭雅装饰
//
//  Created by 镓洲 王 on 10/9/17.
//  Copyright © 2017 镓洲 王. All rights reserved.
//

#import "NMPikerView.h"

#define NMShowAlphaDuration     0.1
#define NMHideAlphaDuration     0.15
#define NMConstantDuration      0.25
#define NMPickerMinimalHeight       48


@interface NMPikerView()
@property (nonatomic,strong) CALayer *subLayer;


@end

IB_DESIGNABLE
@implementation NMPikerView
// set hideConstant
-(void)loadHideConstant{
    self.hidePickerConstant = 0.f;
    // 先让 view 为 show, 计算到 hide 时候的 constant
    self.view2BottomConstraint.constant = self.showPickerConstant;
    // 顺便生成 layer
    // set shadow
    CALayer *subLayer = [[CALayer alloc] init];
    subLayer.frame = self.layer.frame;
    [subLayer setMasksToBounds:NO];
    subLayer.cornerRadius = 25;
    subLayer.backgroundColor = [[UIColor whiteColor] CGColor];
    subLayer.shadowColor = [[UIColor lightGrayColor] CGColor];
    subLayer.shadowOffset = CGSizeMake(5, 5);
    subLayer.shadowRadius = 20.f;
    subLayer.shadowOpacity = 0.7;
    self.subLayer = subLayer;
    
    CGFloat height = self.frame.size.height;
    self.hidePickerConstant = (height - NMPickerMinimalHeight) + self.showPickerConstant;
    self.view2BottomConstraint.constant = self.hidePickerConstant;
}



// animation
-(void)animateWithViewController:(UIViewController *)controller TargetIdentifier:(NSString *)identifer{
    // init hideConstant
    if (!self.hidePickerConstant) {
        [self loadHideConstant];
    }
    
    // switch
    if (!self.identifier) {
        // identifier is nil
        // 未出现
//        [self pickWillShow];
        self.identifier = identifer;
        CGFloat targetAlpha = 1.f;
        UIViewAnimationOptions constOption = UIViewAnimationOptionCurveEaseOut;
        CGFloat alphaDuration = NMShowAlphaDuration;
        [UIView animateWithDuration:NMConstantDuration delay:0
                            options:constOption animations:^{
                                [UIView animateWithDuration:alphaDuration delay:0 options:UIViewAnimationOptionOverrideInheritedDuration animations:^{
                                    self.alpha = targetAlpha;
                                } completion:nil];
                                self.view2BottomConstraint.constant = self.showPickerConstant;
                                [controller.view layoutIfNeeded];
                            } completion:^(BOOL finished) {
                                [controller.view.layer insertSublayer:self.subLayer below:self.layer];
                                if (finished) {
                                    [self shouldAddSubLayer:YES WithController:controller];
                                }
                            }];
    }else{
        
        // identifier is not nil
        if (![self.identifier isEqualToString: identifer]) {
            // different identifer
            // 重新加载
            self.identifier = identifer;
            self.subLayer.opacity = 0.2;
            [UIView animateWithDuration:NMConstantDuration delay:0
                options:UIViewAnimationOptionCurveEaseIn animations:^{
                // 消失
                [UIView animateWithDuration:NMHideAlphaDuration delay:0 options:UIViewAnimationOptionOverrideInheritedDuration animations:^{
                    self.alpha = 0;
                    } completion:nil];
                self.view2BottomConstraint.constant = [UIScreen mainScreen].applicationFrame.size.height/ 2.f;
                [controller.view layoutIfNeeded];
            } completion:^(BOOL finished) {
                // 出现
                if (finished) {
                    [self shouldAddSubLayer:YES WithController:controller];
//                    [self pickWillReload];
                }
                [UIView animateWithDuration:NMConstantDuration delay:0
                    options:UIViewAnimationOptionCurveEaseOut animations:^{
                        [UIView animateWithDuration:NMShowAlphaDuration delay:0 options:UIViewAnimationOptionOverrideInheritedDuration animations:^{
                            self.alpha = 1;
                            } completion:nil];
                        self.view2BottomConstraint.constant = self.showPickerConstant;
                        [controller.view layoutIfNeeded];
                    }completion:nil];
            }];
            
        }else{
            // same identifer
            // 点击取消
            self.identifier = nil;
            CGFloat targetAlpha = 0.f;
            UIViewAnimationOptions constOption = UIViewAnimationOptionCurveEaseIn;
            CGFloat alphaDuration = NMHideAlphaDuration;
            [self shouldAddSubLayer:NO WithController:controller];
            [UIView animateWithDuration:NMConstantDuration delay:0
                                options:constOption animations:^{
                                    [UIView animateWithDuration:alphaDuration delay:0 options:UIViewAnimationOptionOverrideInheritedDuration animations:^{
                                        self.alpha = targetAlpha;
                                    } completion:nil];
                                    self.view2BottomConstraint.constant = self.hidePickerConstant;
                                    [controller.view layoutIfNeeded];
                                } completion:^(BOOL finished) { }];
        }
        
    }
    
}


// init
// view 初始化之后调用

-(void)initFrameInSuperViewWithConstraint:(NSLayoutConstraint *)constraint showConstant:(CGFloat)showConstant{
    self.view2BottomConstraint = constraint;
    self.showPickerConstant = showConstant;
    
    // hide view
    self.alpha = 0;
}

# pragma mark - shadow
-(void)shouldAddSubLayer:(BOOL)add WithController:(UIViewController *)controller{
    if (add) {
        // animation
        self.subLayer.opacity = 1.f;
        CABasicAnimation *ani = [CABasicAnimation animationWithKeyPath:@"opacity"];
        ani.fromValue = [NSNumber numberWithFloat:0.f];
        ani.toValue = [NSNumber numberWithFloat:1];
        ani.duration = 0.5;
        
        [self.subLayer addAnimation:ani forKey:@"add layer"];
        self.subLayer.opacity = 1.f;
        
    }else{
        // animation1
        CABasicAnimation *ani = [CABasicAnimation animationWithKeyPath:@"transform.scale.y"];
        ani.fromValue = [NSNumber numberWithFloat:1];
        ani.toValue = [NSNumber numberWithFloat:0.2];
        ani.duration = NMConstantDuration;
        // animation2
        CABasicAnimation *ani2 = [CABasicAnimation animationWithKeyPath:@"opacity"];
        ani2.fromValue = [NSNumber numberWithFloat:0.5];
        ani2.toValue = [NSNumber numberWithFloat:0.f];
        ani2.duration = NMConstantDuration;
        
        [self.subLayer addAnimation:ani forKey:@"ani1"];
        [self.subLayer addAnimation:ani2 forKey:@"ani2"];
        
        [self.subLayer removeFromSuperlayer];
    }
    
}

//-(void)initFrameInSuperView:(NSLayoutConstraint *)constraint{
//    self.alpha = 0;
//    constraint.constant = [UIScreen mainScreen].applicationFrame.size.height/ 2.f;
//}

@end
