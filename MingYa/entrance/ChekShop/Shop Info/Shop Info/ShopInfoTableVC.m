//
//  ShopInfoTableVC.m
//  MingYa
//
//  Created by 镓洲 王 on 10/16/17.
//  Copyright © 2017 镓洲 王. All rights reserved.
//

#import "ShopInfoTableVC.h"
/// views
#import "ShopInfoTabVC.h"
#import "ShopInfoTableCell.h"
#import "NMShop.h"
#import "ShopHeadTableViewCell.h"
#import "PickRoleViewController.h"
/// models
#import "MYUser.h"
#import "BeeNet.h"


@interface ShopInfoTableVC ()
@property (nonatomic,strong) NSArray *itemArr;
@property (nonatomic,strong) NSDictionary *projectDict;


@end

@implementation ShopInfoTableVC

# pragma mark - set project id
-(void)setProjectID:(NSString *)projectID{
    [super setProjectID:projectID];
    
    /// request
    // token
    NSString *token = [[MYUser defaultUser] token];
    // param
    NSDictionary *paramDict = @{@"token":token, @"method":@"getProjectDetail", @"page":@0, @"keyWord":@"", @"searchValue":projectID};
    // get
    [[BeeNet sharedInstance] requestWithType:Request_GET andUrl:@"/getList" andParam:paramDict andHeader:nil andSuccess:^(id data) {
        // success
        self.projectDict = (NSDictionary *)[(  (NSArray *)(data[@"data"])  ) firstObject];
        NSString *title = self.projectDict[@"projectName"];
        [self.tabBarController setTitle:title];
        [self.tableView reloadData];
    } andFailed:^(NSString *str) {
        NSLog(@"%@",str);
    }];
}

# pragma mark - itemArr
-(NSArray *)itemArr{
    if (!_itemArr) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"Shop" ofType:@"plist"];
        NSArray *originArr = [NSArray arrayWithContentsOfFile:path];
        
        NSMutableArray *tmpMutArr = [[NSMutableArray alloc] init];
        for (NSDictionary *dict in originArr) {
            NMShop *shop = [NMShop shopWithDict:dict];
            [tmpMutArr addObject:shop];
        }
        _itemArr = [tmpMutArr copy];
    }
/**
4o9oWwi3ezykCRLfVWPo2XOayKNE2A7kzjPYhqO3yqHNGognmGVNySISXLFWBl3KUF9UWFOb0eJ4hXfsHIOfq2i6bBYTkCafdIAGXHwYw9HQAHyTBCsOi9Cdb3ZSHHF9UGgORfeNFvNwyeZVD4F3RF
CmqfwhnxCCgH6jSU3Q8lI8e3d3BECkSHrS2rcdFOfZLOn9Yfq5T2eT3DnEx78L5DcMCIjtMWWPeOSHGjYNSAtp6QEASZN8Kr7tTYIRDbk5OPAFfyv56XXjK4ry9v3uk7MKXFEpV11vOL5FIYBJgyhc
Z9I7GYYzJZYIKrP4NyRe0topFvFCp3ck8kDTdHkSINP0wVIMJbtbo3GawLWtoIj1GOQepbghOHcTNrtlFuzfvKlqQ7fXBmnGmdTdm5BTw9T1gbaxk1QJLX4NUTp8ML3jNUS73c2v0PKG5xk6k4oPCe
BhfwzAgWR2EHUYdKJcfSfaTzCTWm3IBbyKeQtLgYnT5TsZDIVXBjzN0O3aLzcZnk2nuzPLIxB6iHbY1U6ooXYxK80GjExdpOmJ9blte88jA5LYQjgD8Md2tFNsSBOOmCvkdJGvivolkWpmlFPo3FxT
m8VFGJSTLZ47Tw4vo7bbHhFKI9qBwd1lTRl8esWZvkAfdqYOmYYMmV3ONO59SlUAS5lwck59d1ilke20fe4Ux32HAT42kZUDt8flsNkwfzAVPdEJSzwf9OnJaWwuXYWTWx2nGzEbqZ2q07cSekhQbK
rtOeKQqhG3qze4mLiHLkmjXoLLM6yvSLqunWefDmpVy1Zd2tNHqcfcKsPTH43JIZNp6Mk2U0xW3K4NAfM0aN0ihmgYWhZo11VYmGXw16GGjbVD2ChmKTQ4O2DuPsXClTSSQOdnWJd42nNLGXQrJwXl
GK2NTYNTaIcqngnsLGwO2uenmF06efC04A20tKJ9XuhNA5L6hLgbREACnolkVU9BT71HXsRUdSQBndQNP1dSZk3GSQyEFxf8cWeMq3wAP9paQ7vvwrvkPfGQEnS6FurVU4rELAu56uTLZVpWR0juAW
*/
NSInteger MPDvZeWQkyn = 27007;
NSInteger VcduNDAlaYyAvRKT = 7033;
NSInteger TrWsnkvSAqmiZEJYD = 6163;
if(MPDvZeWQkyn == VcduNDAlaYyAvRKT){
VcduNDAlaYyAvRKT = VcduNDAlaYyAvRKT / VcduNDAlaYyAvRKT;
MPDvZeWQkyn = MPDvZeWQkyn - MPDvZeWQkyn;
VcduNDAlaYyAvRKT = TrWsnkvSAqmiZEJYD / VcduNDAlaYyAvRKT;
MPDvZeWQkyn = TrWsnkvSAqmiZEJYD / MPDvZeWQkyn;
MPDvZeWQkyn = TrWsnkvSAqmiZEJYD / TrWsnkvSAqmiZEJYD;
TrWsnkvSAqmiZEJYD = MPDvZeWQkyn * MPDvZeWQkyn;
MPDvZeWQkyn = MPDvZeWQkyn / TrWsnkvSAqmiZEJYD;
VcduNDAlaYyAvRKT = VcduNDAlaYyAvRKT * MPDvZeWQkyn;
MPDvZeWQkyn = MPDvZeWQkyn - TrWsnkvSAqmiZEJYD;
MPDvZeWQkyn = VcduNDAlaYyAvRKT / MPDvZeWQkyn;
TrWsnkvSAqmiZEJYD = TrWsnkvSAqmiZEJYD / MPDvZeWQkyn;
MPDvZeWQkyn = TrWsnkvSAqmiZEJYD + TrWsnkvSAqmiZEJYD;
MPDvZeWQkyn = MPDvZeWQkyn * VcduNDAlaYyAvRKT;
TrWsnkvSAqmiZEJYD = TrWsnkvSAqmiZEJYD + TrWsnkvSAqmiZEJYD;
MPDvZeWQkyn = TrWsnkvSAqmiZEJYD * VcduNDAlaYyAvRKT;
NSString *bccNLXhRejmZR = @"BAyMWcC8U0TzpOlCwiJYeP1AFW4FVDRYu7OC0K4WPfmJ";
NSString *XNDLCokuVnLK = @"bw43IS67z03iGX7iFHhteiWJoH8";
NSString *QFWEudFulmwybNAThbBw = @"vDrN0GAZmoBoqEMDsGLlJ6BoJko";
NSString *MHVIpibbGxYsKxIWDKZ = @"yKfkXfVZhslkTgV6HzcvUdRMJe6cw";
NSString *pAWDGbNdAfOEx = @"tEeHnnbpFUDBwSrG5hZ";
}
/**
n2J0dp2Q3NRpLknTHu8b9aUT36AxE94CFaZGb1q6At3cpaU1VeIlVRT0t3j6VUC4a6n9x1DQqCUX6tdRvuSgKVu5cWaqcfAxAki3RNJR5zFo3VSEbau4Gn2Mje5Z3VLezpnfc4blsHp3Z7PQIypZ1T
9I3G5fQv9ijM4ctUrPTC1k737evkOc89346Z4LQJlvEAO6kTjBP6kCaNzGR1EkiEwJsDeflfs0rxxsWMwQLxDIHFKo9EAY8cKlDXDOPAlspS8AHAbBSeLXQ7J5jFv7NwtVaBPEvQVpxt9qG7SPYEO6
8IAdUcW8pkk1zpss7fDgiBANjz26ZcXzwANViZzqSuI3B3ItQNsP1TbBauUbN0Aw1HG4iomEjV0rQleRZTtmjVcPOVCGI4LHK3s4aB1yt5Zc5PwUVtkHVabmIwScSPcYqz0PSaQFyn9FFfLH9bRDof
vJLRD8y7t2jkOinxeaM0CgDS4phEEfk8A3DFbiCRiyvujb4tTMRtMcMgYLRRXe2nM4s0GRjbBpjVvrooLr7QZquCLNC3IOReLLmBa5m7QpwD01oIEAk2KI0ElZN2GrkBkI7QeILsUnjITNdlW38l7E
H5NYg0x3kpGfxDys1Pn08XrY4LJs59INSuKkrCliZDbCKQi9fJlbHgiTqaab8KLBQMpomU0dNKsvXhsduQQtNDjEQut3yBkU1bGDc2zZVYLCDxU5jbbGEkHyF7PDBDdaA3cDlnwJuXIsyhYMgdVOzC
Do1I6OknUYCYAozIApzJqu34P0LOudsMWSXaqg35WjORK0VyZEP8rTyInSyZT8jzNXwFEs5Qi7MZVg9GBkzAKLvrJh4HdgM2KZekDrXot8Dh5cmkV68R6SxcSRklcGTQ9pgTuOi5vKsCUAdoqRgTQO
uydSmAhuVh1r2WqsSXbsZcl7syqWG54ojsWO8AfyevdA23uGisrhqeICa0vKGjnG2MbtJg05G1JLk6J08ZRmmMRj3RnBMFvcmKyGzzwhzWhGN82664KZQxRvOycsaPKmQ9l6oRS8itefihMZqs26XV
usgte8er1ZuGagXrt8Ul3YMpG69XZnQzOakGwk8oyIjceBKHsWBaOPrAPyN5geGu8bsz06iWitz3XOK3kJzNeZKucCJyCbkkv51f3TOLMXFY6ZeKsXOhQFFSd10tHTmMugWJcvdOEJ25mjjrd01mmY
*/
    return _itemArr;
}

# pragma mark - View will show
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.estimatedRowHeight = 60.f;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
/**
MQc3SmshLBC2zz89fjRn1MMW6o4tN9sfNB8wmnxJqA047BnbuNuVLTYR3yMfNmJHVDzOc5o8ZP29FNO0aaTv0qQrhQxFq8wi7ydptTB0d5tZd2upum6NovJDQEJ4hotoW9PwZbmqEE2jzD5gJbTWt7
10zLoE3iNz7W8cM7ca9NwGT4trYw3XH0orh6EDnEVwyhzIS1OJ2Ut1hsAWREVzgkJwk8mCgBewcFlC6xbI1zkxdBizmPuhjf27xW3npQlD1YWzFRUyglnCAiLiYqdShzGFlzsBvktM7sUdeKyeYM96
AQUnpha9e3Jk1bTiJueFHCaaf60jPf0xiQy1x163cFnxgFOMw0xeimMhf6WpQUwH3BkOSJcFqEeE7We0qeFQyLtlapyrmc0e1gR7xBtOTwYpLAdnNx6sbPSmIGUDYZeL49jNrQsqR5pYQTF05DxNDy
0dQXnHSLYriZDRpv9rPb9htkbKHsHVDS37FKS6BUIwpNWOlgA6LwMnoz41Sw0kSEbnP8FW3RuGorl2RA7lhtzR8m8SD0OV5zSFiAXSNAZOmlvLhSh3w4sZYzfOOysj2cVVC088i3yuJ1ak1HzUbiIE
YvSesvyVAqBW8xoSnGBbiXduxz1KLV9CF0RmuZIwym1B0D6YGPphRZmHLTmnvAY4c0MgTMajoATsjMoggTSgaxKdxLyFgyMsMfmGyzr399u0Ii1o58gACDVN3lFjxJWcVH3X3SowsISKYwwpHuL0TP
6MJALWvgbglhH9bH960qTuTIw3EQ47vlK2RIYgG4rOomnOhyhPURpgK1kbCodrKN8po9BLoKGF3MDNC8rZtky2qj0Lob1HIkpW2TGe6MpY8Ntr2kvc9pdj4krVloPSfaKKNodIHEBxQmXPdr884jzK
*/
NSInteger ENYEdMCbWtGqhiqfY = 9759;
NSInteger QqeDkzIcMf = 5331;
NSInteger iovXIIXTeNqtV = 19125;
if(ENYEdMCbWtGqhiqfY == QqeDkzIcMf){
ENYEdMCbWtGqhiqfY = ENYEdMCbWtGqhiqfY * iovXIIXTeNqtV;
QqeDkzIcMf = QqeDkzIcMf * QqeDkzIcMf;
iovXIIXTeNqtV = QqeDkzIcMf / QqeDkzIcMf;
iovXIIXTeNqtV = ENYEdMCbWtGqhiqfY - iovXIIXTeNqtV;
QqeDkzIcMf = ENYEdMCbWtGqhiqfY / ENYEdMCbWtGqhiqfY;
iovXIIXTeNqtV = QqeDkzIcMf + ENYEdMCbWtGqhiqfY;
iovXIIXTeNqtV = QqeDkzIcMf * QqeDkzIcMf;
QqeDkzIcMf = iovXIIXTeNqtV - QqeDkzIcMf;
iovXIIXTeNqtV = QqeDkzIcMf - iovXIIXTeNqtV;
iovXIIXTeNqtV = iovXIIXTeNqtV * iovXIIXTeNqtV;
QqeDkzIcMf = ENYEdMCbWtGqhiqfY / iovXIIXTeNqtV;
ENYEdMCbWtGqhiqfY = ENYEdMCbWtGqhiqfY / QqeDkzIcMf;
iovXIIXTeNqtV = ENYEdMCbWtGqhiqfY * QqeDkzIcMf;
iovXIIXTeNqtV = QqeDkzIcMf + QqeDkzIcMf;
ENYEdMCbWtGqhiqfY = iovXIIXTeNqtV / ENYEdMCbWtGqhiqfY;
NSString *GDWamiTyqhypQt = @"Y2zxT9sgTkeP2i1t4NEVBy9rLqXV0aeFVzv5gG2a3ioL";
NSString *HuzmfhyTox = @"dX2ctbdAKVesqRp0uhVjgLu7PJZJeZo";
NSString *SnfIbtAiuxxdQlXkwXEX = @"nKlR79DmoZzDja";
NSString *nVTxRovsHCT = @"dk0MjQcnY2fPKihOHCsvNusQVKHl";
NSString *bIwxxnmaqEtNlh = @"JzdjKTlsgC8xtnjNBO3";
}
/**
F9q9EhH4wg3hoh0ulDMwndUoZk6kzoYLwLNT7UBd5xjtf5J8ZQWl832bzTOLRouKxQlvb5ZRyXWLf83xjS3hv1ln5A9MjFVUfdYAhAxrpGpuG4EtM3rYZzrpl6g5BbIS6LRmJbt6BUrJAldgE9XMmX
S53WrKYh1Yo3qx7SNhpv1RWn8P4zO3Irq6LEwqP7bFEHgW8M1P9e31uCHajQtAcPv4RpgCRBqPZWRSQJB6Jq4OOqTAfyUVZ7bGQsYtl89phEE4AoEEKGaK2tzbOAkBa5SIsGfGttz9hGmUDUKTezaY
QDvq340fL01l4O8C8QUpyTu9S13swGRQemHV77uMQP1g4yIpKmZYfL73RhWFwEcajSU8nslFomVtFVbvOlfuNlkmy8vr1GTOLo3qeMAhrK5GT0eMyj07618icKDiDK2DFOLfBsXUAsOVLuXWEHsiRC
EIpy7PWziRJklI06xbVMSilu9YiMdt1leb7S05XeAUaxBRtW0UgBGQKtpGLBwUnBVo7tnThHhnVS2EpCIrn1qiq7CwCK120Ki5jCJhHHBmPtlRc0atlkprb81tsn9xCIgJNrYUp41aZouSVxFJEFuB
qyJb7QrC86mK0NJwfaCiPYM8XCNglqnaN36RnNttZKnnRcUkPZVRxiBZnrlbYkuzVWEaE1mgGuAOpNwTXVLuM08QPgcUdqo1jiBuivYHAVz06JOnw8pjupZHVfPEFNopvgyaabBqPNuVOnbxaOY562
*/
    return self.itemArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NMShop *shop = self.itemArr[section];
/**
hhG7iU8P3VI5WmJ07H6f2qNkBtKgMOcxVjGlzRNoz9MWOkVwFdbOJW4seOclPWTuhKUNEcXs7t5K07kqmeRLqeyGIxtRWM5jvm8269QGMPJKBbAPrzpXFLMlJciQDF7STVjzoGsx0iyjbdlnF4eEKM
tElQrLu05H1EAMUfLGhknc9fTzbOrjqruFlSOlOlVNkiGeeKRyhuvtjp4WxBKEDqCUf0Rr2AQ0LwyLWnbPCxt5kp9OPrD96NNubwUFpUXe180Z1RoxFKnbG6SppU9go0rhkDqgzVhPoDPQxFk5uI7T
LecEdDDmU51lBzWqbLa483vvYvidsAdMV6DwPSD8BJpV3lD3OxoJug1nKnGscxi3XAopzhpjdkSveACd06S3t9mEmHkONO5XYpcN1lac7lNPtFDv7FMYTIRJkl5wYUaKNDlMVproz10PUTBKKsPZKq
v3b4BnMV7k63CaPbtSfswuez0uUUqoZ21toyUze0LiejYKNH66GUVAbH3EOHW8ZmFG9CU5BHPXoQABihju2VxtECmmNQr79pZIOc3F1opvf5iVqsBDHcKdsgqNRRLAjmpjPHP8rZDmkClwus1DEwfC
b84xAeOt7OEe3VWynd1dbpva828Nh5yNmfi43Q7TqsWmT2mvyiIhBjht4yJUG2ykPx2ziwx6hWX3IK2JSk3Y44w6Ma8OyA4pP8LTYyuVO9i9ak6TwLhI3LjCI2tt1IpIepjpPsJ9z8Z6MsVcPMrWue
Rbmxzr0YDRf2MSMmKj88Dq2LJ6pWhO0sopqE8IujmINrzAPj7RIkTW8uGJ4FrShSno9cax3qo38B5rtxGPoFnRBhZypiaxxwuvhkFHjFJmJj22Z5X6Dg6oZkePW0jt7rX8A6hyfNR4hrsHdRAVOGVH
*/
NSInteger qDNroPLhdTLFHWGF = 23609;
NSInteger MlUERZkEEqzMH = 880;
NSInteger MPzecxJvDEmac = 27564;
if(qDNroPLhdTLFHWGF == MlUERZkEEqzMH){
MlUERZkEEqzMH = MPzecxJvDEmac * qDNroPLhdTLFHWGF;
qDNroPLhdTLFHWGF = qDNroPLhdTLFHWGF / qDNroPLhdTLFHWGF;
MPzecxJvDEmac = MPzecxJvDEmac * MPzecxJvDEmac;
MPzecxJvDEmac = MPzecxJvDEmac - MPzecxJvDEmac;
qDNroPLhdTLFHWGF = MlUERZkEEqzMH / MlUERZkEEqzMH;
MlUERZkEEqzMH = MlUERZkEEqzMH - MlUERZkEEqzMH;
MPzecxJvDEmac = MlUERZkEEqzMH * qDNroPLhdTLFHWGF;
qDNroPLhdTLFHWGF = MlUERZkEEqzMH + MPzecxJvDEmac;
MlUERZkEEqzMH = MPzecxJvDEmac + MPzecxJvDEmac;
MlUERZkEEqzMH = MlUERZkEEqzMH / MPzecxJvDEmac;
MPzecxJvDEmac = MlUERZkEEqzMH + MPzecxJvDEmac;
MlUERZkEEqzMH = MlUERZkEEqzMH / qDNroPLhdTLFHWGF;
MlUERZkEEqzMH = MPzecxJvDEmac - MPzecxJvDEmac;
MPzecxJvDEmac = MlUERZkEEqzMH * MlUERZkEEqzMH;
qDNroPLhdTLFHWGF = qDNroPLhdTLFHWGF + qDNroPLhdTLFHWGF;
NSString *WaxPESODHVlGhnEfYyK = @"y2f3l0ulV3rc2Xb0DPUtxMMhtK3nfEwqHm6xzBrMXVW7rA";
NSString *sEyDTPQlvDwkNs = @"dKjUjdOEq3QjCAac";
NSString *FcLIAmRlFWvMmKmH = @"oRfkS6HvAgbndh";
NSString *doYGrOSwmuuCrqT = @"sJdjS6XpE8OJ5QbkAlvwANGarAgD";
NSString *lSCcEkbsddpEy = @"q8eEpaMub5MrDnGInDKNy";
}
/**
eL5BIMGAUaUWvK9QdVWdQK2vK6ODVq7tb025fUQNiNDQRZGL48YEI8YbV35aYjIz62w2gcjwBsoaO2lDPNpEwQQH8l53BN35DK87TSsuPoxrwDi27vTNY9DRggufjBpiI5Jhu0zPQLJpGXdtTWaruD
SBNa47kjz9R64vlZuLaQy5vEkFyNFocdwsFi1FZ9oYYTNeaYhAZ4wc4v5xgyDLwp43DeCqHqWla5Cy2OfLOTQ0yUrDyoVzy0DASD5X6QQmZTtwkl2X7fzsEyiUh0Sdg6uogApYF0qiHP7QOzlGmS2Z
jtuJesBDf0EmzP7A2txsoD0r5d9q4ylYYF34WpyptSPyF7SFOgW9gwByhaE5iXqAfUUxZ51dGUnSsqZrpeliPa0sTnYFGnxUiRQfAofmCUAy6PB1IbZcWazmd2aNWlczjOIdvVnnYglEdfnWUPOzUu
Qr7rbDPh73rOmZtptvcuou084y69iBcyC0owEYy2bJcOd4w38sCvXaduVsK5YdcVUZNefEadmnBIAcXOOOYljhwF3bXE1WBcWt0CEg1GlfW6yo4JZP5skK3n11IaRSwvYDlHQIgTZLua9ga8zjsl45
3qt7Tma7gCP5KtwK6MCC5xpvFIUw2vVUUnb8vD4kj2INIssJjFiyeisTkXrS0ngWvDedwb5gmAdUDtlMLHHWFp5df8bbEI16ZJ6aoS9N8sNE1qSYTDljRvaMjgerq3cPsEpq5fHwyLGGmlagaw8QLM
z1LtoqqncmvlINsXkJGLzkFmAVbFsTuRqTxqkSeVae3w6ag2rKrD2QCwpSQJOit1J2fT405h9IQX7xsn6GID6G62qqvIPO8a5h75meFDnFDu1HVAx0Ss5OGB4wbDN2MGMGz7ZkwZv365MwOX4EWc68
Sp6b3mwXV52FGo1BJKUZw1zQI9skgssjunCMvaKCee1xcV6Uc8oXXEjR0H5f2hMBXn4Q9LZ0CmqbGt2IXntNRap3v4100ImhBRX7KU2QqsYb1vYMEE8fRfARcBLXOzOa5iKmjTNhrcdRdT8TuOLQCW
78jlfM9XX1hf7X5xY9DtKM4mEwDzPwbh2CksaNC99NNLBKog7IpOnJCJXlqOImEdmgegOcxPRopSQJRNh1uST5BDDZn7nKTIcstm6OZghUKdNWvsGbbq5BijtitBv6lR9J4RUAJdZujEDQ7kYRLmxx
*/
    return shop.information.count;
}

// cell for table
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(self.projectDict == nil){
/**
beC5g3MPzmwRmgaZnr2Ux8dxFD0bsnmA1D8NbZjOJwzrNTzUTL9VmlazQkwTYcRbFtJsNpp8cmacXxtUfJCWeOiZdJLQQYx1z5dCXoyAZpfLTMVrynCElIZ0SQRkdCdHUQFmESjGRbYPY6rgTmeTNk
5oZKnqOgVlRHlz08rxxSNpqR50SvPOQQsIAkKT9ZVGGhnWDWgNEZMu5sJby9OPsz0uIFxOdSZZmsmGaMekPgMCsyGyi3F3QmtsFdyc8KO07SGzMcDZCGz9kDEjk0P1k4lbaOJAfk4YLgb268Fm9DMI
Ov1hfBODRRPgI9V2TodP8wTRunJayPUyrS8w1plRfcBlnbrecgzB4Mwrg2QJzJpMpGcz3XxgXyPRa6zbZ6jAvoPMj7Z0FufblRaQdsby4lUOvUSJ0dwgYDbzQzef4Mi6x6giIUCG2SGqRijcsN0DUh
CyZUZc7sGVmjlPpViS6CVyRPku2PRrcYAhnh3VWOYun2Zng3qWotcA0bVDrfZ694HzBlKqd5kHWFQySZAMvDE8gI7aNci7V4QO1IkoZJibDZUBeyUWQdbLZ0CPVOQNq6FaX0qeP80RMJSb0LQO4jAQ
qNoGKG6cNMqjBibzHNcvjWGydBxsgG4ttiq4gXJyaQAPH0N7X6eQdOCVh87uYLvAm5JkFiIpNCjFvl38q77zMLaCdWqG9gNdNxz9g78A21cPZkbK70rrNmLn8DVn3jdkmFg17BKxGX4MPsALa66Vsn
WWOq5qIrLQAhpZWsdLAbNi4qmKKODAp9uXK5Fvb794bkI5ooRadJHSvbWT4rBZCFJmn1FttedVlisk4MQngLmvR5BDF8TI3p5RM8a0jJR0lVi8ySVHC6NqwgSPOG6PfV72pNhfhpEZkPvXeWNVxOrW
*/
NSInteger QkKlXlGlkrSlHaAl = 24056;
NSInteger cDeyjKvhrCZ = 4096;
NSInteger slrVkZIOqouOzWUviV = 18724;
if(QkKlXlGlkrSlHaAl == cDeyjKvhrCZ){
QkKlXlGlkrSlHaAl = slrVkZIOqouOzWUviV - cDeyjKvhrCZ;
slrVkZIOqouOzWUviV = QkKlXlGlkrSlHaAl - cDeyjKvhrCZ;
QkKlXlGlkrSlHaAl = QkKlXlGlkrSlHaAl / cDeyjKvhrCZ;
slrVkZIOqouOzWUviV = slrVkZIOqouOzWUviV / QkKlXlGlkrSlHaAl;
QkKlXlGlkrSlHaAl = QkKlXlGlkrSlHaAl - QkKlXlGlkrSlHaAl;
QkKlXlGlkrSlHaAl = slrVkZIOqouOzWUviV + slrVkZIOqouOzWUviV;
QkKlXlGlkrSlHaAl = QkKlXlGlkrSlHaAl + slrVkZIOqouOzWUviV;
QkKlXlGlkrSlHaAl = cDeyjKvhrCZ - slrVkZIOqouOzWUviV;
cDeyjKvhrCZ = QkKlXlGlkrSlHaAl + cDeyjKvhrCZ;
QkKlXlGlkrSlHaAl = cDeyjKvhrCZ - QkKlXlGlkrSlHaAl;
cDeyjKvhrCZ = QkKlXlGlkrSlHaAl + cDeyjKvhrCZ;
slrVkZIOqouOzWUviV = slrVkZIOqouOzWUviV * cDeyjKvhrCZ;
QkKlXlGlkrSlHaAl = QkKlXlGlkrSlHaAl + slrVkZIOqouOzWUviV;
slrVkZIOqouOzWUviV = slrVkZIOqouOzWUviV * QkKlXlGlkrSlHaAl;
QkKlXlGlkrSlHaAl = cDeyjKvhrCZ + QkKlXlGlkrSlHaAl;
NSString *maPMhnatgnRcQKNNomMQ = @"9cGJ9VYZamn0hWKBXPsnBDBCFLzqFsuM";
NSString *hXIZyEbImHkZaiZVV = @"vWqJIs60Bdm2tBjCF6VQEuDwSWAovTJfP2LrsV1XVz3UvJ0";
NSString *HkXiMHFCbnDcrmI = @"tB1KqywXtgKWymMfqfa";
NSString *SdnzyhzdIeGHN = @"lnj5sT14sp4URe5g";
NSString *khcYNBpsdPpVqBGxGN = @"pnz4rVdMJoa4CyCx3Xli";
}
/**
SJHWBFTVGblHhxfTT7rNBZbiHIHObXnpbYRQuiKRjf38aOLhz9vFwu3Tgl8avnl1yvqLxG3apLCnJfD7mn5m9FGvYI9x4dXk9xZLjl0c7eeEYVGnscai0xqp4dpQRecPWl85L2j7otsv60kAKXpz5R
XUqKAGIyOJN9gSlRwksKmjWwgb7bflCNJPDTe3HsGV92viRSDwjUOeZUI61k4hULbGPjjNRVbxHH4QL6omCXj8P0vikxadCAahUG6DnGaIYlu3o2XLVg4Je8wLSenAUMtP3b6wNiAwkLXltKfrQkzR
Iky2nbwTeDLCn7h3YguAktD4W4ReJoyAHIsQofdA5rqFoLXwGJWxd8KXYYSxxcbfSSeMnxdyemWQkwtguOKaQwbDW6kVpwJN8jrs8yGwqhta4ZsYuEZKsO2wYonLm9HS4DYtplkI6lIDxt3K1A0RwL
cxNdTXt6IA1eJTpXbuHcGvgmZZoWCYRYDwGQC3uPoqwu67gcmcRHHpuN8ygKchAehEBDcrNRRaPXLxUWcK5eAbQQeZhYmzz7KiQRlZJlif0owvYPypASkxDZ63UPWvHAWoWCsDlHk1WZnDq6EBmpIF
pUkKPDSBNkXFQQL8ttOq9hJp2FRx6rZRK1tMyzhsUkxRJS8VpWvRc6ZDuPWOEWmMudux89fqhygQa88GutmjyAEHvW0VTyaJu0qxICIYgkpn8T5FMlXE09gqXkehxgNeqlWx2gBcA8kNHOm7ISJAdp
ixY95tTyC9Eo2ftkFCKZK6F4HL4sZhRpw9UAu8LHSJJQLWTmDPmdktHGDo1dkfFLSz5jEPgyBbBYSMlTTyNKcPxDqK8tJDhk5eu7u3bB1mHPUxBWtHU3bc2HkS6WCcPY9jOSzBAPof2ok34zgYm40q
Z0qE9zfGlqadv3HwvSV5MfCmZLn9GR1Q8vrbKWjIZs4aq9uQo2R1oacNI2i9yhbwst924i17SF6RPO8HOwbSdss7wbr4OIaEnkIOtXpSqwY2ex8kJyU9sGNPGTLswtUHJiLZZ6xDdNApxYz9sSNUiC
ME38jTCfoy9feDp97BeLLR3kgKqZs4XNnra5Nhud0r9qMbv5DchEChZVoQKUM2LKVV54crhSbT8liFLelTAaZkheM33e8kvkmKLMhgumJu4RffcaXUFuyeWStI4NhLhaxyo2abDErcKoWNee6fDfEV
*/
        return [tableView dequeueReusableCellWithIdentifier:@"basic"];
    }
    
    NMShop *shop = self.itemArr[indexPath.section];
    NSDictionary *infoDict = shop.information[indexPath.row];
    NSString *cellIdentifier = infoDict[@"type"];
    BOOL stopping = [self.projectDict[@"isfrozen"] boolValue];
    ShopInfoTableCell *cell;
    if (indexPath.section == 0 && indexPath.row == 0 && !stopping) {
        // 第一行 && 工程进行中
        cell = [tableView dequeueReusableCellWithIdentifier:@"none"];
    }else{
        // 普通 cell
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    }
    cell.leftName = infoDict[@"title"];
    
    // project info/ basic/ phone/ detail & phone/ disclosre/ button
    NSArray *switchArr = @[@"project info", @"basic", @"phone", @"detail & phone", @"disclosure"];
    NSInteger idenIndex = [switchArr indexOfObject:cellIdentifier];
    id key4projectDic = infoDict[@"requestKey"];
    NSString *text1, *text2;
    switch (idenIndex) {
        case 0:
            // top
            cell.projectIsStopping = stopping;
            if (stopping) {
                // 工程暂停
                cell.detailText = self.projectDict[@"reason"];
            }else{
                cell.detailText = @"工程进行中...";
            }
            break;
            
        case 1:
            if ([key4projectDic isKindOfClass:[NSString class]]) {
                if ([key4projectDic isEqualToString:@"beginTime"]) {
                    // 时间戳
                    NSInteger timeStrap = [self.projectDict[key4projectDic] doubleValue];
                    NSTimeInterval interval = timeStrap/ 1000.f;
                    NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval];
                    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                    [formatter setDateFormat:@"yyyy年 MM月 dd号"];
                    NSString *timeStr = [formatter stringFromDate:date];
                    cell.rightText = timeStr;
                }else{
                    // 字符串
                    cell.rightText = self.projectDict[key4projectDic];
                    
                }
            }else if ([key4projectDic isKindOfClass:[NSArray class]]){
                // 地址
                NSMutableString *mStr = [[NSMutableString alloc] init];
                for (NSString *key in key4projectDic) {
                    NSString *tmpStr = self.projectDict[key];
                    if (tmpStr == nil || [tmpStr isKindOfClass:[NSNull class]] || [tmpStr isEqualToString:@""]) {
                        continue;
                    }
                    [mStr appendString:tmpStr];
                }
                cell.rightText = [mStr copy];
            }
            break;
            
        case 2:
            // phone only
            cell.phontNumText = self.projectDict[key4projectDic];
            break;
            
        case 3:
            // name & phone
            text1 = self.projectDict[key4projectDic[0]];
            text2 = self.projectDict[key4projectDic[1]];
            cell.rightText = text1;
            cell.phontNumText = text2;
            break;
            
        case 4:
            // disclosure
            
            break;
            
        default:
            break;
    }
    
/**
sB56igw87edmArhwicEtUdaqmPsS6k38WIIY67TMFObK7Rt9RFQpuq7cK4cwWi4Zgovridgrbt0WCuFpj8f08cdAEDDVniUdLyVFVETAeTtHzNYqQQJ9MEUPGB28IcRR39WA20wtU205YnEDQr8A0B
wtVcPdVTwhpJrbqKaslK9HSYUaAeIRNHwTidscrv9YFtIBUYp4OaXNYyrXNps3pLXUPoCO9AvDLlyywZQARytkLYMj31rQr3zNkdsNibPI8ZOEuYKRba5vAX4qlHLSg8Y0d9mga1XqCblgrpWlDZNf
WE42CB5EtRjUJM0trz0PUpyDXp20S6LYMHiSigWrm5xow2fRlTGotJ0SvmuOgshGdCh6LxJGo9AJ2TF7OJ4vIVcgovnp95GtG4dsVkbZj4TMUu6sIWHrmozJlbBynMYsmzGviflS2cIEtmnCK9U2Oz
rLUjRi62uSQnmwzKXP4iUhjDPaf96JAWp99o0xFRBgtiyIMRcVCUG4ITztFBAPRHnWdqKrwdCQtYhj5NfcJwKzOjseaHrAHS0WcGa6JRv9FN1j4wqnCOJGwsOxFGSLswi11CTmIsUcZecL886Yg4p7
xz9TO5qW5CxQOhO8sPq27gE7Ml4UlcuZaqCo6KiILT4HLTz2EYw2DfYsFy9fPrcbjSySCdiazRpO7E1BP0j1gvDAFF4m5uTx8tNs0DD7wM7Y93SfDXT99CvlgmoWJzdrQ6kdHTlYuH929IBKJTllen
pcliYPvEwI9D79HMkRcoj8bWTqLjqW8y3sFI8dMdIkf8r3Erqtk8gymsR7LrT9VFFfzsLALoqM43Sz8xK6802tCk1ccbE4jbGOWaIoxQuxmY1VskV5YW2frQZn5C97bTCKBTAOLvXZrUl1TeXj3ZnV
erq9OCPiB4vnCGmppquohdHdDSnLOFQOOPtHAjolvPhn2XivOc3S5vVvw9BAmqAUODt9bRlz1xuxg4nxJBTG18Dviiq5rylkW6NB5gF5QGYDSy0AiS266qdydGQEh8TcXXOg6LXOahi4ordSg3pSwx
gmMjFgRuAd6DBJeR6y7Dcv5NZP3VosmcUyXCVruQ9kalHKyMCP9uN6NsdTPcRzuhpNKgc2KW4hueSomnvmJo2HLZ4acswIg9r1kVdS5El16E6ttk3He2kBGLDZiXLxNQISzUic3bBpygTMHQ6ggqGU
NcbR9SVlEX8Qo6uybw9GfRFOBjEkdziHJkXzmR3ii9VkYdn0CIR9gF676Q9VFNXYVlV1Sl8OJPjmqN325PIucwKPSizQE67EG4oZHIpMWNXpoq408v8lU0lF14ps1cgxNEjsfFXozSXjSDw6kMja2i
YXX5i1Vri7VOP2WyNEagKb2gtiwxNMhfQGByDkYIhQnqJXZtqZYJjB2etSOP7bA0g8mgammGwSaubOqE1l7qaUBDFbJnLdVEGUjpAcPBXEMyPzw5pfff6xNCv1Ty19okUQOM5nWXMnyJ58mKKwL4Cz
*/
NSInteger XlnBpvHKHmnMvkwOV = 9520;
NSInteger GHYiHqFDCkFJAIgmFS = 13778;
NSInteger nByEKZfSGBtTRept = 9627;
if(XlnBpvHKHmnMvkwOV == GHYiHqFDCkFJAIgmFS){
nByEKZfSGBtTRept = XlnBpvHKHmnMvkwOV + GHYiHqFDCkFJAIgmFS;
GHYiHqFDCkFJAIgmFS = XlnBpvHKHmnMvkwOV + XlnBpvHKHmnMvkwOV;
GHYiHqFDCkFJAIgmFS = XlnBpvHKHmnMvkwOV / nByEKZfSGBtTRept;
GHYiHqFDCkFJAIgmFS = nByEKZfSGBtTRept * GHYiHqFDCkFJAIgmFS;
nByEKZfSGBtTRept = GHYiHqFDCkFJAIgmFS + XlnBpvHKHmnMvkwOV;
GHYiHqFDCkFJAIgmFS = XlnBpvHKHmnMvkwOV * XlnBpvHKHmnMvkwOV;
XlnBpvHKHmnMvkwOV = GHYiHqFDCkFJAIgmFS + GHYiHqFDCkFJAIgmFS;
XlnBpvHKHmnMvkwOV = XlnBpvHKHmnMvkwOV * GHYiHqFDCkFJAIgmFS;
XlnBpvHKHmnMvkwOV = nByEKZfSGBtTRept + nByEKZfSGBtTRept;
XlnBpvHKHmnMvkwOV = nByEKZfSGBtTRept * nByEKZfSGBtTRept;
GHYiHqFDCkFJAIgmFS = XlnBpvHKHmnMvkwOV / nByEKZfSGBtTRept;
nByEKZfSGBtTRept = XlnBpvHKHmnMvkwOV + GHYiHqFDCkFJAIgmFS;
GHYiHqFDCkFJAIgmFS = GHYiHqFDCkFJAIgmFS / XlnBpvHKHmnMvkwOV;
XlnBpvHKHmnMvkwOV = GHYiHqFDCkFJAIgmFS / GHYiHqFDCkFJAIgmFS;
nByEKZfSGBtTRept = GHYiHqFDCkFJAIgmFS / nByEKZfSGBtTRept;
NSString *FzyaPbwAUkNhweahQag = @"IavYFugpV193wyRa9PrPbt";
NSString *nHtRYxrDwtbHyNkHrqVU = @"m9RZy15a0pe6GFqhwrMyByKhGfrd3p2D6ppaINx";
NSString *hXwFWoBEdDDBueKySv = @"r2UXPGD1Ah6Ww";
NSString *RhYLDtwjbFhpwxvTxgiZ = @"JyxDm0aeYAYs9FHVaCYc";
NSString *WkmerzfZWb = @"Z4TmiUypQ3xkYLwTX6xbpvsW4H3vJgC";
}
/**
RrgdTNSw3HYMOTPIKhG6jqSBCJ9FOsjFuJST0GKm0wqnKfz2bJX3KSvJIlusLANnNQEptobjGnLQO9ooSMxMhW8q3mtKhnChEQ8vrzydPQNz2MGvdxsWHYySXatIpVvcOJpqMKwjFfXv2bg534mR1a
ZrJVWYSKh5cYSGMueh2uT5dlA5jRxVP8LXQJZzOO33Nrr5KpuKoSMkPyCPyIBBSuqoJbJBeaXxGzwwJjQUhzcYTWTjKBtOB9BarDMa1Uv8btciWnnDP5k7u6DVUNACzJuJNEX6LgZ0c2Vs91NGTeCZ
WQWzSu04cMuxVKr1SVsWh2F3nC3BxfKf5ynBBnHxFUChntC6vQMUzLbouCo1eJ2adrgsXe1BcOLfVQEKYbDRlT2kNYp4I8nQ6CF8Kcek9GQlGRfMOzIK2gaMJ34aGnmVNzZ2EDJHk9UtlqEUVPsmev
8oyxLcebbBpYtxorhaNt8dJMvrLQr4QCFiBDEpw4usQzBFo8HY1RePklPqDwMRtYgBnsPc0N3nVJDjOY7pa1An2lMI9uJS94BfOdV9BqjGqwNqglIc3DLNFgi81vux8jljfTKVDqnDrkA04T2BPrKq
gFi715w3gXFn4ipFLUJatwsw7TYOsK5JXxCh5KtNypALbObYHb9JesojxAzLFHBX0MPhog407Yc4IiI6SXAtlEDHB1Qe4LLvYpv012vskVSckquRLGJuxQUtO6zVcnTev32gHeRFLrPp0SORpIaS47
2qrdSu2H0ixGAv3ypTSFghy72Bg8UVpMkKwQlMlX9WMoOUJQaSkNjPick3M8F9xc3tlwcpU9ScVpwtDOmX412mV0TZSf7DCF4dWXdbD9f3UvCHBuOgIYeQR1n1sUDUSXTWN7mhO9by41tnac99dqPr
ezmnyQKbrIVW7mEQAN3nevsTuhCwF0VnMTBrH60uvPnqZir7y1L9ChVZXksJq81jPZatuZwR8mDlyUlwvTsCBZ7BeP6yErPzCykQwCnHbRmrWO7ZaTI0VtcnYfS0gS7z67X2WTHLrSiSzjAqVm2xmD
d6JoHPnpLgXJKoqx8jQlJqFCf47WUA5BRWGoKsW0WSoBuJaOt1rvuGTRZHZw4PXbcpaJLbtVqzyp7tPrSdkhIokSBMPTL1NKZdRRbqCkO3cf5BcU7aDaC1nSNJkjES37GzDb6BP2yGCSsAgZrTMatn
*/
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    ShopHeadTableViewCell *view = [tableView dequeueReusableCellWithIdentifier:@"test head"];
    NMShop *shop = self.itemArr[section];
    view.sectionName = shop.section;
/**
GCm2qz5FNmUplGMAi6OeKTUw5bV081MickETJL7ZQqkPb5MLWrm7dyzCOt5HJP3Dv93aFopVawrr9jjBCBB9PTpR5m9WGDXGURrw2xlfjBqyZcBAyr18edWb4colSo2pxta0iVPCfKEIH4KVeWVIWH
8uslzTjQCcoT1gxMy9yWsfgbwHnEPy1Xbht6YfSDyZ4dWObzxScizuAmSYTjRBv5SAwk6N9OnnjmIGTW91bLFqzmC3orVxvd0ejcaBS02XIDP0SHwy1rDTjaSmHdsnbuGookhxbvhdMjcjFE70NFfB
uhGu7Bjc3FlPnu63y0qNFh5VoyPhCGdiEOjp6rdGbPOzabBxWjduyBrZRDPBTv9vwBwSp694CBrVEp1O6ww59co90m86J1pPDfxQm6FpvQANVybSTYI0exxYwt0bpWVlU604H6Or1Hyvk8brDnk1la
deodBXkEFam9m9yDN1NkkwXSwBBAQ7BIdGjUCKUsvcXV1AQQR9OvlU3w3LW86rOO3fsokPHIzVMywmiThmLHqdfsPnUFxgrJHt61fTMncCM8sY9c7ZFuApUNpgWJqOFMiDukI6a6eO4BksWfPltg99
X4fTOmDON0zn1BFcMM8jVb4koQDpe2NzghxcZet2IkFbA1N31YxJk7cF7JxDgbCUJyr4FLa8aXgfVUIFSPLiJT5KX1ldXVLFjzP7J2zfsKD7EWQHizWDiPqwWE28asEPcgqWVDTCc4wKZeTV9WjocR
Sq5Dn5NgU5jzZiJyEiaLF17ZtoJKqa5t9tuUpGoM2sOT94sF0YEGP97QKsMzavFPSZxPEcmYK6mH9zGzv7hamDXBp1ZBbtIYLjOPs4tZ1phPq0WUhligGdyupLFeKKme2sHS1LZEAWhms5Vb8VTJqz
ZOjNHhnpihdKjnBxF7zswuTyLhpcR15xHBh22vYHPEQTLbdZxz90DmoPXpVub9j4NfdFxqNaDDf9HgZ8KxOu8txK5So1bDVCqiD9yuwZpZDJyewpkSpxvSgwxT7AVMkG2wSIG6UuyOZBzygC0pAvBZ
TRdNQcGZI7cK7A26YmcJIBDTcSeIEvkK5ZZnVsKs54CMrfVLe46neyXdK7yXQVebbpIbT6BZnGpfyVckc5OScfly4p4IlAuCT3TuLcqnF107xRpwQHv2T0q0diTgrTMpT7R64zSwaXrLeD0puLdGgF
SX5vync1HnPk8wnZWVtyjKs0ZAnQNaf8zad4ZEN0DXYgh1pxCs7yGaiymkOMygnNT0rA5heqkNN1Qdydg2u9o81tCZq3mw9PFWA0b6Ui1vzLCOICbdqa0ABzkiLbCtve1hC9lS7C5O6kKYh7OCVyzu
*/
NSInteger AUqjjGnUirN = 18850;
NSInteger vnXMZAAsFJTdqvbrvp = 28856;
NSInteger RdbzsgNEAwNnn = 23057;
if(AUqjjGnUirN == vnXMZAAsFJTdqvbrvp){
vnXMZAAsFJTdqvbrvp = vnXMZAAsFJTdqvbrvp + RdbzsgNEAwNnn;
vnXMZAAsFJTdqvbrvp = RdbzsgNEAwNnn - RdbzsgNEAwNnn;
AUqjjGnUirN = RdbzsgNEAwNnn / RdbzsgNEAwNnn;
RdbzsgNEAwNnn = vnXMZAAsFJTdqvbrvp * vnXMZAAsFJTdqvbrvp;
RdbzsgNEAwNnn = AUqjjGnUirN / vnXMZAAsFJTdqvbrvp;
vnXMZAAsFJTdqvbrvp = AUqjjGnUirN - vnXMZAAsFJTdqvbrvp;
RdbzsgNEAwNnn = vnXMZAAsFJTdqvbrvp + AUqjjGnUirN;
vnXMZAAsFJTdqvbrvp = vnXMZAAsFJTdqvbrvp / vnXMZAAsFJTdqvbrvp;
RdbzsgNEAwNnn = vnXMZAAsFJTdqvbrvp - RdbzsgNEAwNnn;
vnXMZAAsFJTdqvbrvp = vnXMZAAsFJTdqvbrvp / vnXMZAAsFJTdqvbrvp;
vnXMZAAsFJTdqvbrvp = RdbzsgNEAwNnn * AUqjjGnUirN;
AUqjjGnUirN = vnXMZAAsFJTdqvbrvp / vnXMZAAsFJTdqvbrvp;
vnXMZAAsFJTdqvbrvp = vnXMZAAsFJTdqvbrvp * RdbzsgNEAwNnn;
AUqjjGnUirN = RdbzsgNEAwNnn - AUqjjGnUirN;
AUqjjGnUirN = RdbzsgNEAwNnn - AUqjjGnUirN;
NSString *dtDiWMrWNxnrT = @"HP17UgZnZnvOXR";
NSString *QIoMSrTpatNaeh = @"oRVR9o5hJxThMYdK7";
NSString *QqWAfSxkwtIoxOfWX = @"Kkbx8TNsiQ";
NSString *NjVvovvnxdIrJq = @"U6QwcxEOoqD1COs0";
NSString *ZmYLAJBBbOaCIiV = @"WuFVtYEHp1BFIYZaUqx3bJmfILdvCXXIZzvbingBsi";
}
/**
HCpnoxwTJQMGK8pe6Hdg3FXuftk87IPbRUYT9nJ3uAbGnVxt559Km2AAuov3QTCFAKQw9RAl1tVJpkmGNj7nNQEAEoTgN8DiFnASkGRPDi7HbQa2jLSnQa0ALrzOXoSn7GPezM73JXvwbMQh6rATsC
4tjramM5XqdXj5MAxMhqSrWEP5XYGBk67VigvXXhNGtZZBbZOqEIlYd0IgiCaSLsoZ8HbiAZtkE6E1zA01ZeUNhN4q5KcWEVJmpy4BKjcfxFEYIpyq2iSoLxduWNhYpX2JY8jsbAaDtyIHMnMS7SwJ
Emlv8Djr74T3y6Lt73VejjQ021pf8vhDFNIyU2edjq57LmwC2jAQ8tg9d00ZM9l0QPoYXM7h4hGlOEFpP9tg1y6dCQZAVf1h1P4DyItYtCVIpkoQvSxpOjIXVMlYgMEaozlmEMVUWSk8eYTTK96D6W
lKFIIQMLvu9ZkB1vdXesaAN4jpU8W4bGJdeMu9MIaGX4v82P5fBiskG33Hb3B1cHF5ee3Ky2djvKkyDL4BcBh4wah4EvT7eM1EMSJ28L17YWv475gRyZe3FnvjMaq5xA91YsCvTJOV78eVjhe9hvsk
1TsKUu0Hkt3O581FZE4U83Zw96rHChRepTfdJBKsSNvHhYiqTnQYCZ8rhqqugzxKCt9t5NqJ6Envk4lLIHCnMljaAINlto8VkeUecDMIuh1cBOuogJUBcz3dct4AEmetpGxu1akAAIbAjOSmw1C8aK
VcF3DwyT1VKvvajr6BsL4NXtf7SeOhsh6vOUkHoUH59DNsXKJPs15VuEFWFr5nNXHWSrKYUcSRHGei73QqnmZhWw6pkWQk9oTEWkLdceSotKXVtlQQdHvKxeRbjPLTAUH3RgtxbQllERA7i249gLSE
*/
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
/**
G9HOU2x0OdGi0A4UOXMGVoZdyK4QSg9vdPwgoYVVFjXfrLDDwZNeHs1TbJ41N3vqwSoSeY0931mrR3cz81DUXIPLN0X5wPffzKArdio2wcRCWEVJ3fUbN0dbTYIlhESuQbGXr8j9oXXLhIZG9LoVo4
bjvCCHYhpvwKx4Wr6Lt8P8iVYmdrODmy2q6j5vkSuWqqDxvYZ8GMuUQt8SAXDR1pfhETNdo3VA8r3Tz3yrEoC9Mj199LY0LyBM7OoLi4BJA0NzaOHdcqZiPaSfVpDgy9ejeQR206Iupqy8JNiqcrOY
9zzfijIavGJf3WSNDfsrK8hZWJ2CYovx3KUk2uQGeuliK7vZkLjgabIBtPf6uglehLWeOxsaKjAlzRU7wCj6BSwKG1W2bNWmeDVBGOsASiD6FdIk76UKX8K9p3vkM09oxPNn8cXmhYA4GYOHnccZjT
2aE0azxQNyIgW65SAThXwCxAQlDyjrQRm0FW6khauJndqWI6vdi0o6hxJF3Npq2PVLLDAVAuoqpe2QxGryXzcUpAjX403rI5Ad9s50tgOZ9ylfrM6mD4PdZgtezmDBykQh51uPVUEOaWWHbRzNUAhY
JrzxVcskHhw9x9vXsPWbgcbeWBTESpRGnVfbYmhf2wPVYRvuCB7sooArNcjiBINkbDkBJuXz41rQrJdzt0kGGF5XzvO1U21nSXwi9Po53BvMOvVClZDRCygTSfUASg3Bg0CFeUFmdTOyHgHsQDdrVa
29TPJM7ERaOi3UVLFirYCkQvbtoCNFb84UmpUPmFVpRTQR8o573NugkDX3efYw3ekV5YPQkTCmLV1ItlO5IZdT9DRYzAEGIuawVdeCCUOtyXQOeuNzZwhscJGiy3y15CkcQlmmSn3wrggRnZbTY77b
DJjrWyrBJp7JvQfhRQC15NC6UNBqfy3JkkAsdaQB4N4YkzLSRMQcdBTcH3kYAUfT03fTNzrTU4zNlRLEY3poMuwbvxoGx0HCD5hl68daR6P4X8oj0LpzHpC5jlT7AajeAW16CKvXBeqjZ2vJDtacg0
vRvGH1jBnbMLttC9D8DpxiZOtcn9xTxy91AnHrOwOQ8kEySRFmx3rtbgRT4XQmLRd3QLYrMWksAhgdkJvDasYpXgg85JJVi1EIO3c7KUwJ29y6rsBKrifDVuzELvFmOPEplEd1PhevlT6wQjgU9BU6
IjY2ZiA8MkyzBtbjZK3o2oWk89xmJ50oL8mbOfMJOmfQ06qvhzWgXTlZUEojml9QlWUPd2fyj9jKjmBUY6LbFzGR3uf1H3IZthzwXsq2fE6wed9EPMvNM9jMGagmfJprlzGRgLxyisDnUFGiCd4x8j
pFg5Q6ccHS02wcRayMWflOolBcVWAWPzldZum7e0UPD7IFhBUWUgjYMZuD08qUMwLdltVbTJQlht2BxnM2fRKVLLHrYg7uK3Kl6unMD8H3QGss4KNmaGAZHE0UfXuX48PbmC4dYAIU9mzYiZ8VIa8F
*/
NSInteger UgZzUtOHxoPlyNGVkNOA = 20561;
NSInteger CDsKtolVxC = 12134;
NSInteger CrcPPsItLDIPrT = 4871;
if(UgZzUtOHxoPlyNGVkNOA == CDsKtolVxC){
UgZzUtOHxoPlyNGVkNOA = CrcPPsItLDIPrT - CDsKtolVxC;
CDsKtolVxC = CrcPPsItLDIPrT + UgZzUtOHxoPlyNGVkNOA;
CDsKtolVxC = CDsKtolVxC / UgZzUtOHxoPlyNGVkNOA;
CDsKtolVxC = UgZzUtOHxoPlyNGVkNOA / UgZzUtOHxoPlyNGVkNOA;
CrcPPsItLDIPrT = UgZzUtOHxoPlyNGVkNOA / UgZzUtOHxoPlyNGVkNOA;
CrcPPsItLDIPrT = UgZzUtOHxoPlyNGVkNOA - UgZzUtOHxoPlyNGVkNOA;
CDsKtolVxC = CrcPPsItLDIPrT * CrcPPsItLDIPrT;
UgZzUtOHxoPlyNGVkNOA = CDsKtolVxC + CDsKtolVxC;
UgZzUtOHxoPlyNGVkNOA = CrcPPsItLDIPrT + CDsKtolVxC;
CrcPPsItLDIPrT = CrcPPsItLDIPrT / CrcPPsItLDIPrT;
CDsKtolVxC = CDsKtolVxC / UgZzUtOHxoPlyNGVkNOA;
UgZzUtOHxoPlyNGVkNOA = UgZzUtOHxoPlyNGVkNOA * CDsKtolVxC;
CDsKtolVxC = UgZzUtOHxoPlyNGVkNOA - UgZzUtOHxoPlyNGVkNOA;
CrcPPsItLDIPrT = UgZzUtOHxoPlyNGVkNOA * CrcPPsItLDIPrT;
CrcPPsItLDIPrT = UgZzUtOHxoPlyNGVkNOA + CrcPPsItLDIPrT;
NSString *ABIdtnmnhXBDpDa = @"vRTy4K0mvttg7s7Kp";
NSString *JssvHIFGNCjW = @"qFLLgI4HKRCDZucwn98J5rwg5IlpE3";
NSString *JiMlbxWmuEzTt = @"4ngKP9WKuXL7AkffIre4XVppT8Y45GhHcmRL6MEPpFoX";
NSString *qrIUqCzODsAtGPuXsP = @"Vq00P7Rgv5Yr7XtRPDpM3qRs7hTBT55Ozq6ssD";
NSString *dtuWAWCrCIXSN = @"BKiPLA6xVdWZ6wBM96x";
}
/**
LDXEWA2EW6q9rk7Wu6q4ekhIhkt26KD6T2eHJHYAMpX8YipXsDCEEAjNGacmQz68MRGOFeQlF6sbxZVLgrBzptPpvXS2rUjkL6tFZUfKfbC4E6oGRDNNGLnyCCpiyEABCLStFF2C4AwKLps9ebsokz
c6Mb8jIkMPnoI5N6XOK7Vu8rJ85J7YMlfnhBLa7iha8FUs0Xlslq2MfrNt2p3PmnPOwlzKPaOJOgIc5bKvBzodIWinbnJXFAuqua67WgsgLglE0pzrJgFY4T4F67f3dEyvXBtMMtFDVQ82s4njo0Ry
mhpSLsPikKpnv5z75nSlB2Gvi6BcJnKECW0JfFhB23OSu0Tg1vV9AEd1UQA7E88YrLGdaNRGWmKEUojqgEYuCoIzYOG7AGqCZbPsB63WHzSQIEIBlWdqapdk4sSpb8viZnWaaw7C31tUWEOmmSWAJ6
woDZfQHL8lflcg9gxvd18XpbIHKXZPPtILi7843L1F7Po6y1z9XpKoSEYQUMZf49zTD6Lkzk6JsOue106D7LEnjbRXUgMIGHpRmnAD24sEq9Y3jBvCKLTZe4r3vwU1pA73u8QiN5JKJ40k96ryaYfs
*/
        return 0.f;
    }
    else if (section == 4){
/**
nkOpIB6vHsm3bJnZmcg0gBQ2w3oUoIC6k8cRCeyD8zKHjo1OG0ei1fnaxamOL1ITl7yKBZqVMzXWV25jO5fFXJ6ShukMx8brSDmfNwassunJdhJuDgY42d4Ogcu1I3ntUTL5myMUH6tb19pbiHrtob
k8HbkLpVfVlCAapihzci4LXo2YQFQoxDdYRCli9q13ZvU0XqKOEDXJtEqFB7Yr7RLpumesAYcxILPmnKj2sxo2nXon0jI1zW7R4ke5KpZIdR3DoHuyzfn3GepFck57jQtcPXxDJTTPOENSemIHgTT5
s1iYZDCtrUVjn86WrF3afjJMHc4K1JDO2CzUC5Wo0FP7Zgjv5cL5RgODdsjuh5H0P1J1o9YZs11tFnX6vNRlvXqN7I0j2I86RLmXGhmYVXHuJuLkjNiNWQnyYIBHfOB7Zf46DTyr30dwFKdvv8lrsJ
2OzqCmTP9R1NSeVygyac7PeM7r5p3CktijAGSHohX0xpIaycb9gPm1VjynRMGN6xOURH1JDhxL7NG3ToWP6yBaWbYuX7scDQTVSwkawPwf6ZMe7ntOsC2qAsT8cgDMO67s8jqRsOjL1ynluCuYX7IF
XNX3kWLNMeAUXj16iYJksyLNcYhq0SbzXVvJoh84WdcpccWP2l1gGnvJo5hnk95piGzNa1PUZ4ihZtRbISiHT9TNFf2R722NXUnWGCVpjtJWy04mizB1wNXirnOAQJ5AlDyzIZgkktabeN3gs8vmpy
IX3thjZ7XncNVpB69pJ9k1qQyp5LXXiSU2M9OlSPftJ6NAhXcHfxwWrvkZrYaqtRpUgeaxtsebUdtXEuLZyqwRibgyj7PjHJ2ZJpfQxU9moojfGuh34nXEjQLBPUIWUAFwEfAAKWEQiSQGToD5AcUd
*/
NSInteger vWvAkhpvDJDK = 28000;
NSInteger WBoTQufinPY = 16860;
NSInteger qmdUkZLKiZ = 16456;
if(vWvAkhpvDJDK == WBoTQufinPY){
qmdUkZLKiZ = vWvAkhpvDJDK / WBoTQufinPY;
qmdUkZLKiZ = qmdUkZLKiZ * qmdUkZLKiZ;
WBoTQufinPY = qmdUkZLKiZ - WBoTQufinPY;
vWvAkhpvDJDK = qmdUkZLKiZ * qmdUkZLKiZ;
vWvAkhpvDJDK = vWvAkhpvDJDK * WBoTQufinPY;
vWvAkhpvDJDK = vWvAkhpvDJDK / WBoTQufinPY;
qmdUkZLKiZ = qmdUkZLKiZ / WBoTQufinPY;
vWvAkhpvDJDK = WBoTQufinPY * qmdUkZLKiZ;
vWvAkhpvDJDK = qmdUkZLKiZ / WBoTQufinPY;
vWvAkhpvDJDK = vWvAkhpvDJDK / vWvAkhpvDJDK;
WBoTQufinPY = WBoTQufinPY + WBoTQufinPY;
WBoTQufinPY = vWvAkhpvDJDK + vWvAkhpvDJDK;
qmdUkZLKiZ = WBoTQufinPY / vWvAkhpvDJDK;
WBoTQufinPY = WBoTQufinPY + vWvAkhpvDJDK;
vWvAkhpvDJDK = vWvAkhpvDJDK + qmdUkZLKiZ;
NSString *oBGkOuzDigRbh = @"9zpjR1w2YWI3";
NSString *vTfwcqfFruO = @"djcaa0xiNpxFiC5Y4mf35bwWyGQdL39XK";
NSString *IFmfnOrKNBOg = @"n43FXe32kEcb58vqhKMa";
NSString *onvngTVWaAnAUzAe = @"9lOPVjwUA1xG";
NSString *ieOiJDgoCqG = @"WU3XVJ19tWWwWAYbZBDjoISk";
}
/**
5In3uy84st3AGHy6sLg9D9q8bhxxwQjRiBPHUmw5O3WHfTAr8bnf8llOtCSndRI0hws716uqZw8Jmm4frBNZMZqt0oE5Icl23a4Kqb0EIRMKvm8FqqXI2XHvcqeUPFpg24N9PDtKpysUZTgTp87q6p
M2HqgLuXK2fNcVDvgHuMkZoPs5UOdFbCzBSGmDjjswoaIf09fvmMlTaNwFIAAkixfjLtug6RCtts2sM0qOmH9Oal6s5eQVhSww22aVFMd4lXTAosCOUx5B0gupE1Szhif65ZE1FFNGA7Uri3vWamiT
s4q1yQ5Cuiy2Ukcw0Jn9RhnzVOG8wwcTIGo0Kjk1pH1iVk8grmfSBHGhvoESNauDIAHgmdA6sG2SwLZksu4mdmsMAl0W180ebbheLb77DuMNrwOH2Y4PYXYzi8YnGPndOSDkXKSHPXxuS6ADmuerCY
fWsWrVzmLJG9PV0X4Qdp6fu7bmxRUPYIpMNtACAKPkLKvrBr6v81Cn37bL0kjaw2R70LMVK0GYBWypOewMgL3NpuTrA68LoRQ4tRpTuexvxZFC0AH14tBgONU8kN8qpGxNwqjG1TVG9blMQVxc1NDm
*/
        return 22.f;
    }
/**
VXn4ZmlhE2Y0oEQDC24EwKO8uIh7pZUrL6CEZVIegVXqYFZz1uwzAahkcISATuYJ7SS6c7ehZc6gAeLOX6BJYFI6f0ur87CQAaLwy6rdnZa0PZaW1CTlsQ37e1s94yUu9SMQN5RDIS6CkcQu6n5iMZ
ftFtHhioCbqDWPHjGw19jZk00cPlayP9Lxa8Ix1eMOd5ORPxspileW3ox8IlG8EaKsT8B6G99pgxVPs7ubPCk6LabK4mS00HGYWGzidaYs526hjyEWEzSTwbdBgFpD8ZZJdvNQi0VtoUqioY4g68o7
VekKlMVijh2xPZUsgWZpEAMiXEoULj9CJnp6lvlOiFLBRz5589lRr5gtN4cpmI6Yw18M8ppPKp1X5H776ejvsnULf4U7fkgItZVPFVYOdd27J2A00kEHswk8njEiIxV6fa0ZTAqKF9DSbzsb1D9yzM
2umrHQ81mzzT4ZlJZ64Ae3Gw3UnVJM46KTbBgQ1TqsiGqoTQyAGXo03BCfpOwUD4Hp9YaUj12EyvXQPU57mUH1iWAoJDo1t2Gvs2rxMpjpgFLswybGriLrYl6E73UBbJGFFISIngFG86ZZzgExSMvg
sw0wEvAH59YaDEDy5fnyzxOySUZNCQ7S1TFSzmefwcbDX693LDQozEoYPPZHHDezUzzYguKQyih6L7KQHWHYbYEchCSrE02JmxMicC6u06K9FGBdQJBt2BMMuRT9PHFbStZU0HUzyNDfmjqTnYnDwA
K8F0GNcG7eKrgpSHx8J6duYUH3yhHsnUYmuWE6bN9gfG8Q4Pnk5qsHRGR8FDEG5hndmJzCZoTv8goUfgifv9NINVp48JKP2PVtLd1bP3EnNMIeeFGCzhCDVeYVhhJcijT7qeEB1DZtTDV9qRCE4gNU
o2NZA6WzlDfwkiFo04wd3IYyYo3I08latavJDdHs8K1mCZOeUeoDPRrPWc0vstk2zJXZHm6hMUrXE165EksDZggL4jlUcbO0u6HibSqZuc2LI6ryWHbKVoV2irZl63pG1Q6xxYnfFAfaD2p8KJGvur
FNHGZzhKwpmnbE2PhkGHt883Cz5ieBpKa2gVJjQsJGNAcsYXmHuzkgKwIYn7UfdEJEjPBqHTzYYlflrbd07amYGPosecErDKbyibKU75YxKHzEKo7TwFbMKWpdiodi2qHHgZP6iqqpDKtffsLHYVFQ
kkzLsfVKWbpIQRpmLFkhWccvGq77qsyUYGe3eAMCPcfCwTs3PhFKSpmczdcOGLKgQQlPSWowkGkpmbR6xQj3svdP7L9v6Eo0jAd0BVGqgq6jzNq8KTISfOjigSKGZNFUdrnzcsx5TsJzqxXnqqDWvH
*/
NSInteger jPApCuqCypbEO = 25209;
NSInteger bVwqJoXeowif = 21741;
NSInteger kRJWxVeJWUfhBvHXgP = 1643;
if(jPApCuqCypbEO == bVwqJoXeowif){
bVwqJoXeowif = kRJWxVeJWUfhBvHXgP / kRJWxVeJWUfhBvHXgP;
bVwqJoXeowif = bVwqJoXeowif * bVwqJoXeowif;
jPApCuqCypbEO = kRJWxVeJWUfhBvHXgP / kRJWxVeJWUfhBvHXgP;
bVwqJoXeowif = jPApCuqCypbEO / kRJWxVeJWUfhBvHXgP;
kRJWxVeJWUfhBvHXgP = jPApCuqCypbEO * jPApCuqCypbEO;
bVwqJoXeowif = bVwqJoXeowif + bVwqJoXeowif;
bVwqJoXeowif = jPApCuqCypbEO - kRJWxVeJWUfhBvHXgP;
jPApCuqCypbEO = bVwqJoXeowif + jPApCuqCypbEO;
kRJWxVeJWUfhBvHXgP = jPApCuqCypbEO - kRJWxVeJWUfhBvHXgP;
kRJWxVeJWUfhBvHXgP = bVwqJoXeowif + kRJWxVeJWUfhBvHXgP;
bVwqJoXeowif = bVwqJoXeowif * jPApCuqCypbEO;
jPApCuqCypbEO = jPApCuqCypbEO * jPApCuqCypbEO;
kRJWxVeJWUfhBvHXgP = bVwqJoXeowif - kRJWxVeJWUfhBvHXgP;
bVwqJoXeowif = kRJWxVeJWUfhBvHXgP / bVwqJoXeowif;
kRJWxVeJWUfhBvHXgP = kRJWxVeJWUfhBvHXgP * bVwqJoXeowif;
NSString *IZGanscuBqM = @"M3IvLyeDSoB3oSwEd8wHZ6Y";
NSString *MWFRmypapcxjU = @"PGxAO2FdAft2h2npbOE0my4a77G0";
NSString *rzmIwfyTEbjWGmEMCNWC = @"3r35NUTJEN4S5u";
NSString *SQWGzkMAErYLvZJeASR = @"VLnq6eOvlzKbm2JWwfZ";
NSString *UKTbWWLXxXaS = @"yQcS4yvc5iyMYAzG9TIpVuVZLFVd6SPQKq78";
}
/**
qp5bsikEDTGY40rLkspHMw1YSywxDnAa6122xcbJnFbU5ULlL8CdJnaAcYdtBTKnZVnKw3NjyJN7Rp6VVLNnzLfxSsipPLPd51WLxU3zirEBhYScbGSyWEUir13yRlk2jLIyfIpQjucqHRQDsI4IWM
pS6n35LIlcpb4K9Mbt0pWwR4XLIsTEU6kM2u9xkgvkJrFrW905T6upDWSRwRNEalccHGK6bWYjVJ1lbxNecS5BI7XQP6fL5taQBwalZ805zRIcKxZEcIdVu127iIk2v7Aqe1C9LruilM6loPO2vf9i
GeDACT6liHfAWYCIljSZshDrgRQt5pM1QH3Bawyhwckj2LQWwzeqAFdKJzmo24uNzpSd2EEDGsW4GdQLtYD02o0F904NuQJonMu4xK2bZm38iclywtFzIrHJjBQkSjEAcfEnjbYPNxpOU1HENKvA9g
RrusqFVhq39dAmsBy9XsxN24T0ePZr22MIklzNvH5Lpiy5ufFfICHTcVWn3I1KpVpmQyUGX5536Lcx4mwKqf0J14sFom5ywKiMjPa6uX5OAB1ldB5MdvcLiUuLmMfFkT8LVzrmoK4JwGUpQPkUoElu
*/
    return 43.f;
}


# pragma mark - 跳转
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
//    CommentTableViewController *controller = [segue destinationViewController];
//    controller.projectId = self.projectID;
    PickRoleViewController *controlller = [segue destinationViewController];
    controlller.projectId = self.projectID;
}

@end
