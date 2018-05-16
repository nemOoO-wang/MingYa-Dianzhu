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
/**
wpnELC1CZ1rFDrQPpm7Iw1kiTcF2pJPTMLsERk09kUFDTsPzS1zW7386Tb10gD9X5FIPLzJTqbhOD9xOg2LdQACSNxC7w3OxnJR7Bi0XDTGolIL7hvMz4Otg7isX99m6TCruR8xLOpQKc88OfKfFN8
FKRiKPo9eJlwKkF8N9QLQc7EN05LEbtcPsCdP6vWHinQdcoPZRKoUPHvCiL5B79PkNvfzB3gMgZJHiibFSgUYstXbzGoUqzSHbvNwBTi0vujwRE5QviVn01nKSIrRw1Ts9t7iJvTJ7wn0wZgeFCdVm
f0WNe2vT0cjFNd3cIvStfLaJTGOjrs8buEf4umk3XDJd66OeMc7ZZcqqW3qHq8X4BOO2xOCb5neuR51kv7srddp95cWjnn6gl2CWzbvI1zKdWRIKiEygk6ZNjmlvfBBBDBZRsfZaR7WfHcgWnW3fqP
utl9NhgIbH2aI9bTea4Jlk9Pyhuf0pflJXqlmuulRRofBf4HguESJTOxB9btNJIh7yvYhYk3o5wTEe8tJMpKa7130LlGOwHpjmKxI067HSxk65KwmCoX8u2YOlu03GVS1WX6J59XcICzWeONAJwm7d
ldzyacgHfsDWc9vLr7gNMQZCJjviivKSbVoQJLSl0bzyClX2HQZHAKfEyKjRphXosffoHTIR9Rze4zaNY2Xk6oL5I4Zwmb3v9YUQrCPEeUhITTPc0U8BKNW5Mc7BWGkoVQLemyik4brJCUN9DRu87O
lpVosNxHlVAGrAIkpDDFMWOWiwOw2hTG5F5pqF5Su64FfpmQF9gEBjNohHDXt0iyAF59KiEWyTnaIO7LCXCLg2IifKLXyF9H6RtCszzDMnQj46hNeMzV9alVow9bb80RNoXwxuICfbgrQ1bTgLNcM4
xpzeGgz3mQZfpxDTeACfQh3jedKAR6bNVInSJTJ1UJYJgbALKwp9VUEEojNR3ZxkAyKDoc2nCFFoK4hnYLus6tIgZp7wwTVcs9unolHVAg7Ph371KH0qCH2irdWQSeryVYqAMBd28hWMgZrlEQrHrQ
*/
NSInteger xWyqwFvuvxW = 15648;
NSInteger KfdkLOqYcEKPlx = 24824;
NSInteger PxGopCSfsMZfYnguSGr = 9502;
if(xWyqwFvuvxW == KfdkLOqYcEKPlx){
KfdkLOqYcEKPlx = xWyqwFvuvxW * KfdkLOqYcEKPlx;
KfdkLOqYcEKPlx = xWyqwFvuvxW + KfdkLOqYcEKPlx;
xWyqwFvuvxW = KfdkLOqYcEKPlx - KfdkLOqYcEKPlx;
KfdkLOqYcEKPlx = KfdkLOqYcEKPlx * PxGopCSfsMZfYnguSGr;
PxGopCSfsMZfYnguSGr = PxGopCSfsMZfYnguSGr * PxGopCSfsMZfYnguSGr;
KfdkLOqYcEKPlx = PxGopCSfsMZfYnguSGr - PxGopCSfsMZfYnguSGr;
PxGopCSfsMZfYnguSGr = KfdkLOqYcEKPlx * PxGopCSfsMZfYnguSGr;
KfdkLOqYcEKPlx = xWyqwFvuvxW + xWyqwFvuvxW;
xWyqwFvuvxW = KfdkLOqYcEKPlx * xWyqwFvuvxW;
xWyqwFvuvxW = PxGopCSfsMZfYnguSGr + PxGopCSfsMZfYnguSGr;
xWyqwFvuvxW = KfdkLOqYcEKPlx * xWyqwFvuvxW;
KfdkLOqYcEKPlx = xWyqwFvuvxW - PxGopCSfsMZfYnguSGr;
KfdkLOqYcEKPlx = xWyqwFvuvxW * KfdkLOqYcEKPlx;
xWyqwFvuvxW = KfdkLOqYcEKPlx + KfdkLOqYcEKPlx;
PxGopCSfsMZfYnguSGr = xWyqwFvuvxW + PxGopCSfsMZfYnguSGr;
NSString *WCniuIIXRvqCyAU = @"Gtk7YoWNsRs0c8";
NSString *ZhkcCGJuHDHLmY = @"dOu4HcBvfZkaHgUPl";
NSString *EPBVMhkCPmDmxnODWPZI = @"qJBxhIxeWUXyzdgEhOzRqWEAoS39i00l1A2PK69Fc3i8GM";
NSString *mxmaokUhJeKNlDcNSq = @"r7AWcQtVXrz8G3cfEepPUa5yKfP4bO6";
NSString *ScNdOvzhpHugQKz = @"13R5mipQfAXtKkM3pA3o4zDPsCx50yaE34Xy1UO7z2ilp";
}
/**
aFKbP97IkHx2yLEUUgnCyVMYgzuv8aB7jbxqGlXoNqt8RlgFEE1B5RI2hmlbg7qkBGZrOUUp3rcJiZlfOjEeCu5RmNEBkvPfczftkSCLT5CurOoI3Rd1jraQzCbFcvHtWKkS0TeFjV1WbmMC4fiDoz
3jF3nMRLb5KObDfmTdLo4bfGNkAu3bL8OGRwB7O9HhIERAm2FTu0ziIITSWJvBGy7XSUQo4MiiMPOTk5Jkbl4W70VyQPReHJVarDeTpnBJgqa5aPlRx5vx9ESKEAVBMQzFhwUkeO7DM0Qlv0eTRJ5O
xRsgnI31T4gbegngrq6U4XCWCT7akw9MGncMjafp8niULhEgl4cccil4wvViWBpKnp60g3FEsQ8nqP73zgKu7SCs9B3BE1a83taBpppgyuKsRHAlc4SPlL9OaLtI1zWRJ0GBTXviOBXuCZ1VDWJJvd
MbDBceuGhPrFe6meKSsc2c7UU1PN4DCe3WEjCUTu8TbDprzipMOnHPbuV9NcO8y0kuObWWSL6ZLCFM0C9VEfkzle1OLLIT7ukb1qpvtueVMQrGLutv7omfdp5ebS3yqLBnKN9aDtUFJd0KeVoR6a3E
y64Z9CKFWLwqXxuhl3fCLVzXiE9TjSPLbHAtokcmvI9iS7zoW5TM3CD80as7yKsF8OQfh7u4hRog1Y2sufDrQP7pJG7zVnpmAf14wJQOprOwykgqWYnVTYgAzVZ908d6wvmVW9DxFlluGwywDBu5wW
8Bx8WjDRV79KWjL6aTQr1lzyHvKbjeapdOetfH731XEazmgFFF9JXFf7gRe9vQA23Oj8cXSezmI4ZFX7kSYAzzsezHcQBt9LjHtjk7cxDsbLj3rfJBn7TdWVgJZfJTt9DPnYBVKHboOOoY51ilmtyH
gYloypi3UwMa72hPUY8pdMhesJgW3U87kMBJYt0DRjGshVMRSzq2K9g0Ziun07YZQ2uOLmunhDgxdKISzU2stm1gyvgpLBt2KwqPRz4sbfNrPuANJLMXFDdBW61D694mED4hxANprmNCjcUqCvjilX
4nYPzvur1X4DrxUaHOdNCHvf4BYuoEmtPI8Ni4qWUz0psdSqLyJnbqWeMdP528sRoEW6aot6O0nEdHjvF3RwJiNvAoHnE6dzgAJThA2B7DNEf6H4QeCzNQGBsDl7WhEYJKfAqaZr0LCbAyCZ30gv4C
1uzezF4RL4AtP9aLRcl45dq08l0cl1cDq7pGLRZz15wR5CJhv99HEt7yQREhzrrGcNCgPKYeE8kboXeTfOtzjDpQbBd3vWuOleBKfXCEK961osULqAeMVmkpwllUQwQFb9HYSIc63VIRSjFFW7Mpe7
8W06118xkA6YOq5It7oHrnJ6UIwCGjfWDF7RojCDfnS0Bmky9SzREOE5VBfjXIxJvA8ns2rHHEiSfqpaJEX7nj09tHBDwBN6GyUngAkw1MipZfuHaIh9lstYfc4jmEIbLD6NVHuqECy19MWw4oK8ge
*/
    return YES;
}

// start editing
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    CGFloat y = textField.frame.origin.y;
    if (self.keyboardHeight == 0) {
        self.firstEditingTFY = y;
/**
xJm2vk4GN4Xnt9QpINbl4H7wV1NnLpVljNKFoqAtAYDwwd3FA28xWrFqxGIKDAuG4zlIJ1lIv9QxaRU7mfDkRVeVu5aKOxj7R4JZbGRoliu25ChtgCNFOXoTgRKUIwK0CIGf2El8X3EGWYGhzmPZqL
cftym3Kaojg63DwvbVFb1s1u30d4AUw2aGtYzVRsFtA08wSD9mo5uKGFDoeEMYJcLtgiSmiwJb71kHfWRJedeMJ0X48KFrfG0bd5ef3nGLZmXXwoXiRserhtR2mw5io6M7ohJlDkIA6yRK3wlmJZEZ
guUovlPB9U1CCJquRFptlDvl0cDqifEAdOdKlTTHPv5BXZxM1bpRsNVrT4rXxpnNaw1mitPYkYz3F8eCRPCXtDXdsJZf3DaVHJc8uVhBS3Jz5veL4vo6O01XgJ02rF2dNSzKyr2SBS4QMfoaBm3hQ7
Q8nRqCkqTjiDteaD0rHAkPc5he7LMZ0oAtvezlvwd9xVHMyQYSnv6KM96M69itvSuKDwy3qxheYNejXVVGmhB3W2aMq00Ebjvgw38QJyUrJCUOC49rvL0DYqBcUeqA4lGNIudoiSpS0U5isxEx6OX4
BSHsVCARjSyRXrPwxRWloQPNbxfbvUEVZgq5ebgL8YftDTuTo3q2bcOmOLnXPSTGHPagzGpojnSJMYDtvEntQE7lY1D2mWLJlBgKrgZgTzqkDDQAANWZUOYLHsgnA88NsMQvGiw1iuvKscqUVPZf4W
MMerybb636SJhen5SRn4saYr0c023NwoKSXWEv4gjJNqbSJfzyn98yuirre2MbApv6VoGuTgp86CJ2RowHfnET5YRX5psyK2t8LPNDVXNYzcfokL0Z0bIdEHTt596nQVsh3OKext0EzFkDfU5eLJVU
*/
NSInteger lMTnAHfnpbHxZdaERSB = 14209;
NSInteger aNLsphlqbGWEj = 28701;
NSInteger fggUQQRtkyYRBPYKsW = 20620;
if(lMTnAHfnpbHxZdaERSB == aNLsphlqbGWEj){
fggUQQRtkyYRBPYKsW = aNLsphlqbGWEj - fggUQQRtkyYRBPYKsW;
lMTnAHfnpbHxZdaERSB = fggUQQRtkyYRBPYKsW - fggUQQRtkyYRBPYKsW;
lMTnAHfnpbHxZdaERSB = fggUQQRtkyYRBPYKsW / fggUQQRtkyYRBPYKsW;
lMTnAHfnpbHxZdaERSB = fggUQQRtkyYRBPYKsW - lMTnAHfnpbHxZdaERSB;
fggUQQRtkyYRBPYKsW = lMTnAHfnpbHxZdaERSB / lMTnAHfnpbHxZdaERSB;
lMTnAHfnpbHxZdaERSB = fggUQQRtkyYRBPYKsW / lMTnAHfnpbHxZdaERSB;
lMTnAHfnpbHxZdaERSB = aNLsphlqbGWEj + aNLsphlqbGWEj;
lMTnAHfnpbHxZdaERSB = lMTnAHfnpbHxZdaERSB * fggUQQRtkyYRBPYKsW;
lMTnAHfnpbHxZdaERSB = aNLsphlqbGWEj + fggUQQRtkyYRBPYKsW;
fggUQQRtkyYRBPYKsW = lMTnAHfnpbHxZdaERSB * lMTnAHfnpbHxZdaERSB;
fggUQQRtkyYRBPYKsW = fggUQQRtkyYRBPYKsW + fggUQQRtkyYRBPYKsW;
aNLsphlqbGWEj = lMTnAHfnpbHxZdaERSB + aNLsphlqbGWEj;
aNLsphlqbGWEj = aNLsphlqbGWEj * aNLsphlqbGWEj;
fggUQQRtkyYRBPYKsW = lMTnAHfnpbHxZdaERSB / aNLsphlqbGWEj;
aNLsphlqbGWEj = fggUQQRtkyYRBPYKsW / aNLsphlqbGWEj;
NSString *AkTwZFpkkBuQBbBLG = @"ccAytvVMVr8Yovn7Lo0kL";
NSString *GCylKOsoIvFz = @"eZXlHrji19mgZoD1gEMHR5w33tw";
NSString *OWhSIhoFaSmsxrF = @"dxlPpUyKdS6lp5TdF4q4v3ozfvqo6UCb";
NSString *DTuHdqrgBPzmljqpTHyb = @"8EolAomfCu6skFgIOdIX";
NSString *XdGBMaKkTLNuef = @"QDpmQL2hFDqWZ";
}
/**
HdcM7x2MejX2zsD6XDjX2FcFsNVPoAhVoJZHIIPgmHEvCJ4PP9SoHelwJe5U388tId5dgIYEIRCYBaDeYTs2Fqe4ub5qYWqt799ufqahkfk5ckDqksjvA1G9lr6sH6UT8PXjSLXx05pp9uuG8vLuQ6
eN1mTt0tm1jpEgmYgDRtS6EaaICJf9mJZoAiPi3WOIzWWvu0jHGH3PlPGWVl4TKodzv4rGV78gIblwKwBrkzjnLaxoXVKLC6mUuigdlVevGCmhUDrk2syrX0ajyAvtsapDQNazTYOzbH41STs3zVJ4
iIz4XLoqacGHZvvn5OcrFO1bHU4irJldYYmME5mX1T1XoZkn1ikbkosOgernFKiAzTmBPBecbL0lSNkaSEGwTLCuoMG8osgtcsXrC0TiO0Af75AUKHI7AltllypTrbtNf0LkVZXrR2kvp5p42hQzbj
aNDvunSRpWIHok2Zj0jaSnHTJkKVo5r9tmB0HsY0cKgJvrYOb3KN92wxQOKIW8yjcptGdnzOrPfGH06TuBnGejld7cG1ZRbEhHohrPMI34fUhy5m1DJMVOsI2Lt29kTTV8EnCTxpIBeLjE80ELOyKC
*/
        return YES;
    }
    CGFloat offset = [self computeViewOffsetWithViewX:y];
    [UIView animateWithDuration:0.5 animations:^{
        self.subviewsOffset.constant -= offset;
        [self.view layoutIfNeeded];
    }];
/**
MREq71GYNSSLcOJPQxLJXbu0CFFRMk17MD1CITdq4WSKtdUDW7Jrf5lgl8kB8VygxUhpwxN46cCzHBJXETi2UVbUy0GTTE2S2Lrm3GgKr9HZ6EDfDVca5EblLJMh8ziV33CQUsF7ykY2XpWtxXHyYA
MShLQofhJJWDVdCCb6v0YWQa7uOlkEtKC5COXo5WGdQ0ZOmoDm4EJIXPFz98hBLwes0D5pLkU7xMxHvbICtoa4E4fGAkQAdyQekfLK5NpzXx5YaxsD6gagz5vmjTIIdvvck1cYkxSxBWuKdU4d9Ujb
oZYd5yp3U1ckGlOPdPTi0Tz89A2oMJi4h57KqqEG9cOfgwDexLlvJ21K8ROoN9vQxqhpMTCHTc0mT7swoWmQOvSuDLGDvLdMMypkCBOlZ6eZZZspZvsZvMUf8XHycMNxZ7K8lOcZB3SYT9Q6Hu5QBI
*/
NSInteger jtXktyXdIPe = 9744;
NSInteger fFGwONVjCnAxOR = 11796;
NSInteger cyNoxDsQccefOYPEa = 23366;
if(jtXktyXdIPe == fFGwONVjCnAxOR){
fFGwONVjCnAxOR = fFGwONVjCnAxOR - cyNoxDsQccefOYPEa;
fFGwONVjCnAxOR = jtXktyXdIPe * jtXktyXdIPe;
fFGwONVjCnAxOR = fFGwONVjCnAxOR / cyNoxDsQccefOYPEa;
fFGwONVjCnAxOR = jtXktyXdIPe / cyNoxDsQccefOYPEa;
cyNoxDsQccefOYPEa = jtXktyXdIPe / cyNoxDsQccefOYPEa;
fFGwONVjCnAxOR = fFGwONVjCnAxOR - fFGwONVjCnAxOR;
fFGwONVjCnAxOR = cyNoxDsQccefOYPEa / cyNoxDsQccefOYPEa;
cyNoxDsQccefOYPEa = cyNoxDsQccefOYPEa - cyNoxDsQccefOYPEa;
cyNoxDsQccefOYPEa = cyNoxDsQccefOYPEa * fFGwONVjCnAxOR;
jtXktyXdIPe = jtXktyXdIPe + jtXktyXdIPe;
jtXktyXdIPe = fFGwONVjCnAxOR + fFGwONVjCnAxOR;
cyNoxDsQccefOYPEa = fFGwONVjCnAxOR + cyNoxDsQccefOYPEa;
jtXktyXdIPe = fFGwONVjCnAxOR / jtXktyXdIPe;
cyNoxDsQccefOYPEa = cyNoxDsQccefOYPEa + jtXktyXdIPe;
fFGwONVjCnAxOR = fFGwONVjCnAxOR - fFGwONVjCnAxOR;
NSString *ueVwAMYfrLRcWmPned = @"lWE2OAVnZnBc3J1v";
NSString *kzZznGaueBYvPLWlb = @"SV8gD40Jnv6XNI2ld";
NSString *GnczEEUstPlXZHLwtMo = @"KpZom3j4zAHnscFPeZZSk";
NSString *DDtXfjLkmYDMjMJjJBn = @"JyHhbql18SbeSq6VaAZXwYRvlO7";
NSString *dSJBXXNCprmEDOkvp = @"53YNd6kUS0lf";
}
/**
zTstp5B7VIPKjCYAbbQh2MHn6rNic7sy5T9nGTKWiJswMh48HhXPE8s8L8OwzqunQcapDaqSeTrQZ9ejGIJrT4OxWZD9y6uodsHMXnvZbrPqt3TEZvjQVrvLTbpQMnjvPhcVYsMmnh8s6umqy2Lqta
H2fuUpoON1nr9u7uZz6Hs7phmZh5FyakL2VAdLKHCrjhwfdhDkW8gju75V0YAkCxFNMVr1A5HvN9NdcEzUhwnqB4I81JOiTBKYLLAPnwi9aMiOvPQoTsO8HHSmjVASW0zAwwHE8Uva5Fzr27SOGrug
Ilh2cxqQhP222Y9m8BWnjsRrANKEVXaPrISBNWEsa7Zgd6fiwscnPw064ULQRVM6w5AB7RmVfNBCxSSUNDumuyXvlSwqItfF5IS2fDMIf5uae5hvyO03Lu4TZkmItEaomXJNSckJH8vVuo0yFuxaF5
RMmIrQRmK1wqqPCZv7hYTtT02fHPcYdftZACCBAtxBDVjpMisbyPKff3DbUrLzhUhEt2lkvnT57o86Xjhn4sRmvl2O9CACGDzYPWIAD9h57hJQyzLInGVqPz09qcQAH3Mg71NEBqcab3Q4fwwbs266
hnnAkAXJyaHn7yFhrvq675G64ttd5GNXwMERmtPgyCoOfD7q7YRAVDBrO2iu2ZutBnI8ocIsOhUK6xuC2Wda2cJKSNwLaaY31dUhq2RXJnasdzplwp6MnriBOl2MmbP949vd5X4ZiVU11UbyWG7OmS
OaB3lzxECXiOaDgrQQJaDPHAxlyDfs7pv9gc2SwNp7j8VZ5KRGUCuaH8yfkF9Hg5tfNqt1wYeWw7VpzHiXWGJz7ztzbz5abebx18llo7s8E8cKVi0y2OvuJzq8dFIBCDc9MX15HzoFvHOgJMTbIdEZ
MCsbUXnA4xvDDopMoY7L4z4zPOZpDYo78iY2ZGvci6jyKRVieXrdhWnr1m5f80IOUTrUCu0I2ry60xeb66s98XVvUqq73yWWqkkDwmzp0V3C43ytZrDsMm4pc0gaj0OawxuXoOr4VIAeeWo3yH6dlz
qSwyDR6wvrgyJRI1JVlXRsRvJAisk54tGmEMQrmVRXifDNFNUl6G6mtfJu9NzUEFl8nRV34td3jqwcj7MNeaTx7UMgg2xAYeb13nZ19aLPndN4wzxk5gjFQxXQYHj9ng1OSvgjvFbg0b0lD0R9NWHT
zFEqUmNxy7WylFTNnqHofh9WdRtNa7K52prXTB01OQL4NfdV42lylmQcUBGgCnyr3cDiVYDsmleprIaiCkFuoFvJC0TV28Lec8rNHyij41DnjXTyAaNjRW7BAjlqrZ3aKncsL6bWpAQ7O1CG3i1zLO
oq0cqzjMM57O5fc5C4S6mtn5qxd3QtQZ4KTwhyJaqMUTXcjPDYIEmGE6FA5ONBoty8LggMlHwJHzeGK2WuYO4gCfz8p8sSonrvtenJK8u4vwTFGjhHnx8TbTgBHuzEl22qUG3M5RZaWBD6B2HiWOMu
*/
    return YES;
}

// end editing
-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    [UIView animateWithDuration:0.5 animations:^{
        self.subviewsOffset.constant = self.constraintY;
        [self.view layoutIfNeeded];
    }];
/**
bhle1iNbFJTSGtWogQ1RQtFAdzUW7sWUMjhCMoqJYSeB8mlnoyghBpENVE11V3rg9Emzee7kN3Danag64DTp5aWkdSzYIqyVDrirn9o609HPyzUUlairRjGyZmHingE1XCOvuEBey4bcgp9Y7TzFHJ
83xeS4hKyx7g4jEi9PsDBHzPyEfo1bHOW7acVz2XXW0K7U46iMhU3XjmPijksSkTGFk9l5RV8vTYpXFIlh5KdE0iib9PehcKC2FkYbSAyRzGBzRbd25lpmZRhs2Ir8YJGNAHGoU1q025o73PmcWzUB
lzAHq49umZJfRoPY2ps2rfK34jXK1u0TzvQ5JMjzdwZnX1YHB5iuueZcj75X3x9JwMcadkzHyQkBUZHdFCotdhJdUEqjEV1VszMAghUSGrKbYAYuEebe75dmOZF975snNnQbmpUgDBjJaCvbFF9nNR
bXgC646vc98OYSXuCYYwdlMXF9vj7GCtkBw9G5UMhO9b0g05kHfnTCar2wqGllryOiKQAckoI5bx4JltKVMiVbgD7Xn3K9hYK0tZlPy7Q2nUbE8fAEZ8k1qGBTeya8leLEQyLGpx3Ea1pq4JfWOEnM
LIn5rmICvmycc7HaQTzZcty0gZBRGpHaQEOERaPN7TcHU1u7Z4BmiebGwkbJfLCJLoMXhsc4KxoE27MxopQ4ZHxfhvVn8qjuklUafXMVy6CswXc1CglxMlaZkr1Yx3lpEuHf2gKgGPFM3IyykkCEv3
ZvjRCrRMvjSTWYIRtR6loED1Mtdfju9rtG4zf3KQJUaLvmPm2hA2SdpEL4cLd726LIPDM9eDblDnBRA0bXMSo853xKPwzNuZ3KkADMSxbchgFhMOeV9t6WerliIOGvfB4vs9sHFmsBdQdaUhJO3Abs
j7zKZtjuaQKp1VKzOxWzzNLuuC1GNAn0PT599XQhW4UPb16uPcQONQg0BYRfmgEDF5VQZjn7FhsRZaEl31uRoZSysx4jnlPN6YZvzwtyPextlWnjHHFtY73ekgtJRtLGv6CU9qLEXY4mjUDQhbz60Q
4ZM51A3nlcRZ7sw8MwD5zBy5hscEev19f8PPxDrSfIVZ5C2Q6hU9efFTKZ3K5YvDBnLoox1G7HxuDEk4swMS6qXFO6xZIzASXkOtpyymWN3QszoU2blrJKs45zycRXtUd98Mf2p539lxX1A0EKUm3E
FdnclJcsyuyrbYT97wqu1aPJ93N0cEAXStLcN3lBff0XyWoHDiFcLcHMlWUP6g1hylZY480mj6ASmkW2UMXyJYGL1rDRmtPynu5oV5c8K82DTWRDSVce0PX0ZqPY7yNcNaZtpi6AtWuQzNNm0gahP1
*/
NSInteger pAfLxAdWePWWfTeyu = 20526;
NSInteger OSoIspNVxTHUqzcZNCB = 16144;
NSInteger zpPajArrMz = 24943;
if(pAfLxAdWePWWfTeyu == OSoIspNVxTHUqzcZNCB){
pAfLxAdWePWWfTeyu = OSoIspNVxTHUqzcZNCB / OSoIspNVxTHUqzcZNCB;
OSoIspNVxTHUqzcZNCB = pAfLxAdWePWWfTeyu * OSoIspNVxTHUqzcZNCB;
pAfLxAdWePWWfTeyu = pAfLxAdWePWWfTeyu / pAfLxAdWePWWfTeyu;
OSoIspNVxTHUqzcZNCB = zpPajArrMz + OSoIspNVxTHUqzcZNCB;
OSoIspNVxTHUqzcZNCB = pAfLxAdWePWWfTeyu - zpPajArrMz;
OSoIspNVxTHUqzcZNCB = zpPajArrMz - zpPajArrMz;
pAfLxAdWePWWfTeyu = zpPajArrMz + zpPajArrMz;
OSoIspNVxTHUqzcZNCB = zpPajArrMz - OSoIspNVxTHUqzcZNCB;
OSoIspNVxTHUqzcZNCB = pAfLxAdWePWWfTeyu * OSoIspNVxTHUqzcZNCB;
OSoIspNVxTHUqzcZNCB = zpPajArrMz - OSoIspNVxTHUqzcZNCB;
zpPajArrMz = OSoIspNVxTHUqzcZNCB * OSoIspNVxTHUqzcZNCB;
pAfLxAdWePWWfTeyu = pAfLxAdWePWWfTeyu * zpPajArrMz;
OSoIspNVxTHUqzcZNCB = zpPajArrMz + pAfLxAdWePWWfTeyu;
zpPajArrMz = pAfLxAdWePWWfTeyu + OSoIspNVxTHUqzcZNCB;
pAfLxAdWePWWfTeyu = pAfLxAdWePWWfTeyu * OSoIspNVxTHUqzcZNCB;
NSString *vWlMYfhXZyy = @"GrO2N7uhrm";
NSString *lwNkdiOQAnhDNtV = @"ou21GBzBQ2174XqS7oLApko6JZBw";
NSString *KPwPaKqikUiAlKjGyCb = @"1IrTMs07aIpIfkEpOBOi6tdXP323";
NSString *mknCHMEaMcDyDA = @"Tu7bycwnrVwZ9ZzsRR0wQqlSyOtFF888clt";
NSString *BdQcPowLRjgHZ = @"QvqBszq30AT295HGwUniowPgLRemmR0noqU5QVJ7H";
}
/**
IRQLGozuMevx6fD2IQ9kACSVtTgTnEtx3c3jD4c4bLd6ddQ1qrBM33gF2cgBC5exp8PvMVjpenHwmLIQnyrJ645tLqB2A5RthBKseCbcjTdcYdrVWVgTVnPtmKSbKKZFhTl1mA50aRtN8T9Owv98me
csriuVJ82pNIXUbWZOwiS9IU4besV1puXxtpGuuXxKkazTBLZBzwcBSeVFYvcOwisJtO1zC2ku2RGwok2LW3cyDAUwyfxrfyvWJRfuXbptHSkNXTFqsbDemNKyNAMBhYheclzT2zHLGmc25qqj4BST
y2Xk9Dm4ZXjGXGjUe59ydERVHxMgnYzpKseq1Lk4GpSOKsgpFDjQs8G4h7uBydKSluKg7iVgkjei8CLNmpdanR9zADJhQkzGK1JIhLNES3zUOtLa8Ontk0SHvoJGU1PkVqSFILwEHhEakzTEfryhmr
wgdL1F3Vi8ClTAiX7F5Okn4akyshrEVUWT0TPow0tiRGo5fPr9oBknn71Z41sj3rSrlJ57ClxFjpMhg0Na6SmI5rdR1GjSfHTWdhTHidj3LjUiMDxWwTIRJvf5Zh7GQxZm8XSi9FilwIyB8CIrVsga
CjGddlmagkduVPksbUBXF2dCYEzL5tHY8fbKCx4EdtXEd2QlTKvlV7m6PkexRKRO44aYjDRFwvG1QEvEX7PYgPZVPewIoEY0nS4YoZJPyyqAvaxMJiDfGdonBybG5pbMjX5F74POkGciXjzIgftF3v
GDMqstyOvCJIzBHamEdInTJaVJxtMZEdXbkpVH4OYSg61e61ibt8yfTKsU0UXMGx9sO0jlzlbhrIGD3qYlxBf98eDgsTIw8ScNUcns6yEFdnZE9z39jFI3uuwio6J6NTwOO8as8EpbDb4lMXxEoEdk
UfGBB5xZDcaZ4UQ2IdUy4J7g8CotfErolNI78h0x7B6HOjxsN5cfJWRcGRQo8TS54ANSMzW84m1anYpdocSGSjOrb7Fi7dok4LJFP27hQfzvFYZh6CtzXE8SSIVi3XzIzPLRlq6sxbOED0SCa8PKmq
*/
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
/**
Y93UcacsenHz5b0X2GCmVxVpp1sKNOXldw9lDG10W4egMzyEpNJFyhCq3I84t4DozqIssDtUnr7V64VBCADvIT98yixWrFsXvbbueuciLasyzMExK4GfXlNADLIgx4FxqBHnr9NwzCvq0BK6kqHoqk
HcuHgwl50ou8dznGcBJiGMLdmovVyWPMtFqDPh2oMX4MK0MTx1tJi9zdVfqGC6UddJxbhaIL2G73e3axnn66OMskPCQthp4Fo8rPebT1aib0Mm51uOOajXza127BVBZH10zGZkRlDVdW9TRmyS1kUP
bfk1yebcdosJTSmqxbks0r6EKpBWBFwxQ740DHNu2ts0gbWh0sLgagEPyAscyY25p44tTyhI3k0TywVz0mdAdxjeEq5Ig76Q9UHUJmt42DfeTcipjSU54XNrduqJ1VpsVINHZAPgmOHDMk77tPpq0F
KqtFUZIKXpIO5pvcLeoPt1f5Vj8PrfJ7fOdenhLfAcM0DZfXLSZStDRW7c9R00isWVrYV2QFB3F6oOp99hNcCjMCHRKAWjLsRaS2NwbDbM3gSaxhwmJS934DiX1bxJXo6PKORLHt6bkUha7EqKnDKk
7ghUuqjUmovhKIAIXfuwYg3oL2w46JmIfhZyZxP40ZLCTYaHkEphMrZANbNuTWYSY7dHnyZ2bjApkvjr0MnMcVNZPhfm6QuylqbMX8k8Biamuj7bTsbayl39PJByG8Rm3DAqRugfX4Fm6Y23gDlWZi
jr3KoxciBkqaYPkhazmaJ5VIRHXumg17JhYIjiiIykAudYGv8SkW4VfXkihjSNjBSMN8y36S0lS1xzIZyQdWsjLZFJ6maAaVzK1ucDHFpU5BMGI7xvTid1oGj5vLybaarRibaVBkLjeHTqMkrpRDwv
Yhnw9UlguzTr3qOwOcxk5RNhWzit3KnVi82AevqgVvTyZuHEJFoZ7cGqdN87uu22X9cwkvbxXyeU84LEQIWxAnpVjY6vgOme0g2i5OkvutSLCcFP4xML0gNbsGCnXDmaTf5EAHUyuolSr871xJNvJj
*/
NSInteger abPvHzQsVg = 4364;
NSInteger cTqNGWkvUfqwPGVdeglf = 26668;
NSInteger jXlcBKNseGbIqyDiIPtC = 28629;
if(abPvHzQsVg == cTqNGWkvUfqwPGVdeglf){
abPvHzQsVg = abPvHzQsVg - jXlcBKNseGbIqyDiIPtC;
cTqNGWkvUfqwPGVdeglf = jXlcBKNseGbIqyDiIPtC + cTqNGWkvUfqwPGVdeglf;
cTqNGWkvUfqwPGVdeglf = jXlcBKNseGbIqyDiIPtC - cTqNGWkvUfqwPGVdeglf;
jXlcBKNseGbIqyDiIPtC = jXlcBKNseGbIqyDiIPtC * cTqNGWkvUfqwPGVdeglf;
jXlcBKNseGbIqyDiIPtC = cTqNGWkvUfqwPGVdeglf * cTqNGWkvUfqwPGVdeglf;
cTqNGWkvUfqwPGVdeglf = cTqNGWkvUfqwPGVdeglf + cTqNGWkvUfqwPGVdeglf;
cTqNGWkvUfqwPGVdeglf = cTqNGWkvUfqwPGVdeglf / abPvHzQsVg;
abPvHzQsVg = jXlcBKNseGbIqyDiIPtC - abPvHzQsVg;
jXlcBKNseGbIqyDiIPtC = jXlcBKNseGbIqyDiIPtC / abPvHzQsVg;
cTqNGWkvUfqwPGVdeglf = abPvHzQsVg / jXlcBKNseGbIqyDiIPtC;
cTqNGWkvUfqwPGVdeglf = cTqNGWkvUfqwPGVdeglf - abPvHzQsVg;
abPvHzQsVg = jXlcBKNseGbIqyDiIPtC * jXlcBKNseGbIqyDiIPtC;
jXlcBKNseGbIqyDiIPtC = jXlcBKNseGbIqyDiIPtC * jXlcBKNseGbIqyDiIPtC;
cTqNGWkvUfqwPGVdeglf = cTqNGWkvUfqwPGVdeglf + cTqNGWkvUfqwPGVdeglf;
abPvHzQsVg = jXlcBKNseGbIqyDiIPtC + abPvHzQsVg;
NSString *RAMyeUHMvC = @"7amZekOzbCIiO2kSQqojkVi52GU7";
NSString *SDLgYczgpZRsMbu = @"XGLTsDfyUYbfEZre5kSN6KNmi";
NSString *JMPeXjqHeYHwpohKDApG = @"B64gGIGKLVrdgO40w7IzMwJwt2AlCtsrckeEoN255C";
NSString *wYIWCSNNRFDuJwUjf = @"uO6BYbsmCYwDLPtGuPKOy";
NSString *RvwVEyOyRfGvDu = @"ASlyuV6hpJRCDWDJi5dd8H";
}
/**
SVeBVo1JDOC22Nnw9IBWI98qgxmywJKLtOeqBsGrIOupvfDJdy5FI3QmdWKXHxA6d3jlA2Nln4MGMG7khFztSxTg2YuOTUgyGjzHgmcyfOiwzNVSg8y40wEqhwl8eBZDLxd9W3Rvjx6p7zxIzon5RF
BmASxAgHIjX93qhEUxhI9sxt5kIlDacNgcjp6wzPxSazKa4MF0yMgmeU0cxHKZNYrLervHAoKUya0FsJqL3ltP1cYWwC0Xxj39lmpP6H7BK66yE4jQzzMSWY9GkLyp7lgv75lOSlOvNBeSM9xDRqN9
HXNg73OW2U2R8Jmcp79heQZSyNTTckiGdZRU8nAPlBi7ilTTuzL125sIB2gaJvJ6alsykHFLn3IujKjc5pguG0G85DB3IOojYgxTgxnGsn5sz3njVtcOA5QIUUR95c2q3tmhfSA8IFJ9i3Xs8PcOR4
XPtmcaoK5Lui7T0PF6HMdB9OV00qNnycWp3oITJLwitY595FdXr2MG02WzrcKx1ql1ohQbT6rcEFywRhxeRuBvhFzoGJJoTP6XFVaqP9XOVggF3nFBkpBSkXxKfEQtpE6NUHAX4YNGIbn3dM7cgqCK
pL6XkVdTqhfGjgBadknLIydivK35mXNeHeClp83YFf7xv2LDtaU99NpE4EU5Em0mM451F4SLQz5NXXIgucBMS1fzYucGOb37XFpt21IZx5cDt41NPwPE2U4tMsowB9C5E2LtVPQBuofiPgeY0TA6Ed
*/
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
