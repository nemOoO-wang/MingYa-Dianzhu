//
//  LoginViewController.m
//  铭雅装饰
//
//  Created by 镓洲 王 on 10/10/17.
//  Copyright © 2017 镓洲 王. All rights reserved.
//

#import "LoginViewController.h"
#import "MD5Utils.h"
#import "MYUser.h"

#import "ShopInfoTabVC.h"
#import "NMTextField.h"
#import <JPUSHService.h>
#import <SVProgressHUD.h>


#define NMLabelOffsetY    30


@interface LoginViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet NMTextField *accountTextField;
@property (weak, nonatomic) IBOutlet NMTextField *pswTextField;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *subviewsOffset;
@property (weak, nonatomic) IBOutlet NMButton *regBtn;

@property (nonatomic,assign) CGFloat keyboardHeight;
@property (nonatomic,assign) const CGFloat constraintY;
@property (nonatomic,assign) const CGFloat firstEditingTFY;

@end

@implementation LoginViewController

# pragma mark - Login Button

- (IBAction)clickLogin:(id)sender {
    [self.pswTextField resignFirstResponder];
    [self.accountTextField resignFirstResponder];
    [[NSUserDefaults standardUserDefaults]setObject:self.accountTextField.text forKey:@"loggedAccount"];
    
    [SVProgressHUD show];
    NSString *pswMD5Str = [MD5Utils md5WithString:self.pswTextField.text];
    NSDictionary *paramDict = @{ @"pwd": pswMD5Str,
                                 @"loginaccount": self.accountTextField.text };
    
    [[BeeNet sharedInstance] requestWithType:Request_POST andUrl:@"keeper/login" andParam:paramDict andHeader:nil andSuccess:^(id data) {
        // success
        NSDictionary *tmpDic = data[@"data"];
        if ([tmpDic isKindOfClass:[NSDictionary class]] && [tmpDic count] > 0) {
            
            NSString *tokenStr = ((NSDictionary *)data[@"data"])[@"token"];
            NSString *idStr = ((NSDictionary *)data[@"data"])[@"shopkeeperId"];
            NSString *projectId = ((NSDictionary *)data[@"data"])[@"projectId"];
            NSString *projectName = ((NSDictionary *)data[@"data"])[@"projectName"];
            
            [[MYUser defaultUser] registToken:tokenStr andId:idStr andProjectId:projectId andProjectName:projectName];
            
            // save 2 userdefault
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setObject:tokenStr forKey:@"token"];
            [defaults setObject:idStr forKey:@"brandId"];
            [defaults setObject:projectId forKey:@"projectId"];
            [defaults setObject:projectName forKey:@"projectName"];
            [defaults synchronize];
            
            // 店主没有 jpush
            // set JPush info
//            [JPUSHService setAlias:tokenStr completion:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
//                NSLog(@"irescode:%ld\nialias:%@\nseq:%ld",(long)iResCode,iAlias,(long)seq);
//            } seq:0];
            
            // segue
            [self performSegueWithIdentifier:@"login" sender:self];
            [SVProgressHUD dismiss];
        }else{
            NSString *informStr = data[@"forUser"];
            [SVProgressHUD showErrorWithStatus:informStr];
        }
    } andFailed:^(NSString *str) {
        NSLog(@"%@",str);
        // failed
        [SVProgressHUD showErrorWithStatus:@"网络不给力？"];
    }];
}

#pragma mark - textfield delegation
// should return
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField != nil) {
        [textField resignFirstResponder];
    }
    return YES;
}

// start editing
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    CGFloat y = textField.frame.origin.y;
    if (self.keyboardHeight == 0) {
        self.firstEditingTFY = y;
        return YES;
    }
    CGFloat offset = [self computeViewOffsetWithViewX:y];
    [UIView animateWithDuration:0.5 animations:^{
        self.subviewsOffset.constant -= offset;
        [self.view layoutIfNeeded];
    }];
    return YES;
}

// end editing
-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    [UIView animateWithDuration:0.5 animations:^{
        self.subviewsOffset.constant = self.constraintY;
        [self.view layoutIfNeeded];
    }];
    return YES;
}


#pragma mark - view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    // set const constraint
    self.constraintY = self.subviewsOffset.constant;
    // set delegate
    self.accountTextField.delegate = self;
    self.pswTextField.delegate = self;
    // keyboard
    [[NSNotificationCenter defaultCenter]addObserver:self
            selector:@selector(keyboardWillShow:)
            name:UIKeyboardWillShowNotification
            object:nil];
    // init text field
    NSUserDefaults *df = [NSUserDefaults standardUserDefaults];
    if ([[df objectForKey:@"loggedAccount"] isKindOfClass:[NSString class]]) {
        self.accountTextField.text = [df objectForKey:@"loggedAccount"];
    }
    self.pswTextField.text = @"";
    // register?
    [[BeeNet sharedInstance] requestWithType:Request_GET andUrl:@"login/get/" andParam:nil andHeader:nil andSuccess:^(id data) {
        BOOL result = !(BOOL)data;
        self.regBtn.hidden = result;
    } andFailed:^(NSString *str) {
        NSLog(@"%@",str);
    }];
}

// set keyboard height
-(void)keyboardWillShow:(NSNotification *)notification{
    if (self.keyboardHeight == 0) {
        NSDictionary *userInfo = [notification userInfo];
        NSValue *value = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
        CGRect keyboardRect = [value CGRectValue];
        self.keyboardHeight = keyboardRect.size.height;
        // first time editing
//        CGFloat offset = [self computeViewOffsetWithViewX:self.firstEditingTFY];
//        [UIView animateWithDuration:0.5 animations:^{
//            self.subviewsOffset.constant -= offset;
//        }];
    }
}

// calculate offset
// x2 - x1 = - keyboardheight - ##defintHeight + tagViewX
-(CGFloat)computeViewOffsetWithViewX:(CGFloat)viewX{
    CGFloat offset = viewX - self.keyboardHeight - NMLabelOffsetY;
    return offset;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

# pragma mark - prepare4Login
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    UINavigationController *naviVC = [segue destinationViewController];
    if ([[[naviVC viewControllers]firstObject] isKindOfClass:[ShopInfoTabVC class]]) {
        ShopInfoTabVC *vc = [[naviVC viewControllers]firstObject];
        vc.projectID = [[MYUser defaultUser] projectId];
    }
}

@end
