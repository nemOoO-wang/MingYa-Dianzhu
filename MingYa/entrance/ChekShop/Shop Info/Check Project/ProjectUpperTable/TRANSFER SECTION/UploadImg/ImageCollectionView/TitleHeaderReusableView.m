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
/**
0wqsOxBtH2eovqDIbQ4kO3aJOWWgVtLVAFaZxEwSwcf4lDKhy8HjPALDulFoFj8k3niwgl4q11HCWZLQxSU6ZETi48XwohS0QA3MU7cdJmoyVPI6PDmYrO1MAJIWLcJR1ztqu7rVAS5hyT19ATyEKC
1j4uqJ4dv1QFWN1hJThauW1Av02eTIoyHb7dZeX1uS8PVlsPCt4T8n1wtryA6hLxHb0tcAlZCgSYlGzA7VMojzj5Wnpsp27wI7S8TavOVHpZGpE5GUMXteAXsLt844VJh2I1jU7Z5cmAVXyWCvUBa1
BcbFEm961VoofEa0IxytzEYOZRq8Ki7Wt7XZyxuvLp2B4zLChMyDGyml2y3sFsB0LihYZWRHSyFwMhuP8tdGLVOohJCGzZjZSbRLM54WwUgGf0dmXcgeq9HmBj5mq961wBbSDggmsTV5GZxBieyJC6
836dBbCwkviG9noB2FcKL27SYOX4S6up8o0JZiOMby99LfUgStD7QS6UzcqGsRv9DXEe81dslNaCI8TvBLz09deJEhAGlNB2QQt5tY8GKB0hKBonlSsM72PPmx51YI8qqaf9SJsqXHTr7KIn4F8Of4
jGNgBB3mcD8m37C9Uskr4E2O3kNGXCteQYGekyEnyeZ08BDXcCD2t14MDYbGjXwpYNosR7Nkwgpwgee6wk7ffbNQLV4ZXW30lMSaTluNU7XAVClOlPWMC6Ear7JkgDTDszzjNPg3JoA7plCHkM3gSD
*/
NSInteger OfuvNLQnFWLkoSQSw = 20660;
NSInteger rMYYoKGPxzacaRX = 9397;
NSInteger BEwEbASDwc = 21535;
if(OfuvNLQnFWLkoSQSw == rMYYoKGPxzacaRX){
OfuvNLQnFWLkoSQSw = OfuvNLQnFWLkoSQSw / BEwEbASDwc;
rMYYoKGPxzacaRX = OfuvNLQnFWLkoSQSw * rMYYoKGPxzacaRX;
rMYYoKGPxzacaRX = BEwEbASDwc + BEwEbASDwc;
BEwEbASDwc = BEwEbASDwc / rMYYoKGPxzacaRX;
BEwEbASDwc = BEwEbASDwc / OfuvNLQnFWLkoSQSw;
BEwEbASDwc = rMYYoKGPxzacaRX + OfuvNLQnFWLkoSQSw;
OfuvNLQnFWLkoSQSw = BEwEbASDwc * BEwEbASDwc;
rMYYoKGPxzacaRX = BEwEbASDwc / BEwEbASDwc;
OfuvNLQnFWLkoSQSw = BEwEbASDwc - BEwEbASDwc;
BEwEbASDwc = rMYYoKGPxzacaRX / BEwEbASDwc;
rMYYoKGPxzacaRX = OfuvNLQnFWLkoSQSw / rMYYoKGPxzacaRX;
BEwEbASDwc = rMYYoKGPxzacaRX - BEwEbASDwc;
rMYYoKGPxzacaRX = OfuvNLQnFWLkoSQSw * OfuvNLQnFWLkoSQSw;
BEwEbASDwc = BEwEbASDwc - BEwEbASDwc;
OfuvNLQnFWLkoSQSw = OfuvNLQnFWLkoSQSw * rMYYoKGPxzacaRX;
NSString *sGaDSRzSVvbxLbV = @"ry68Cg4CGfUw3CB7g1YVrN";
NSString *OYHBzMTceHLtdJyGEw = @"3SJAFgY9uGbH";
NSString *kEPhgEXfWtZmSezvBOy = @"vjRCuvSjdIUciblAf";
NSString *bNilqIgAWPW = @"E6a3iS7UlgNXzekSFsx2sXIDaqKrtwt";
NSString *VmittMdIUEkR = @"KMVqz8DaF2RIJDtPJBNzQ6iEnxVmh1L47PLcKjW4X3bmz";
}
/**
8FkzdCVlUrXaC3LM0isM583wLUECeZrkxc1IRgIPTeJU1Pu5hr5UL5jVTytHnrwK56VIi1KvMTtAroNQ0HVsYWxq0c4EZLepuyQPD6T3wtBfLwHvKvEA83DYV5G19xV9H38AMr2zhU7oR3sZ2b1Cri
K0yU1lSVZMzS0zndj9fZ8D7KN4fFoAkpEKiajy3pPLAVqMZWfrP5fYdL5zHMzwlt04mA0mmgOpG7wAIk7Yq8BAlyXRsdzvvrCAMWkW8N0bzOqhwS0kmVvv6DyvbDZvSabDUif6XQVPps1mYizTK4N0
z0FUeP2M7tqQQkq90JBPyGsW4N1ua9PIhpAZGiMIRyaBKgQmk75OMDpFZPXbnL6jfKKe2WV7MiBMm8oIN67FthgVOU3qebuVrIA6duMzXOBWhJcnGUPypMskCjHyznxJJk0NkUTucuXYs5A0v4JIQI
rbAvPLmC8Dr7GDg0mSm5sYzo2CfhtZVRUTKPzbHnVlWCYCwv58VMASoVyHwlY5fZzpn5IyS6rMpmW81eve7MEfb9Cb3SmEDwrtUe5tEhb3Psr3OTdl595KV4cEPJBvWSrkgnuyDLQnUXMoM1NxThPg
*/
    return self;
}

-(void)setupWithTitle:(NSString *)title{
    self.titleL.text = title;
}

@end
