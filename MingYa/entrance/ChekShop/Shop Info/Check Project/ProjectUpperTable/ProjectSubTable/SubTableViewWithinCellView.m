//
//  SubTableViewWithinCellView.m
//  MingYa
//
//  Created by 镓洲 王 on 10/16/17.
//  Copyright © 2017 镓洲 王. All rights reserved.
//

#import "SubTableViewWithinCellView.h"


#define NMUsedWidth4Status          221
#define NMSubTableSpecialHeight     63
#define NMSubTableNormallHeight     41

@interface SubTableViewWithinCellView()
@property (nonatomic,strong) NSMutableArray *specialHeight4IndexPathArr;
@property (nonatomic,strong) NSDateFormatter *timeFM;
// true 表示本 section 是 active（蓝色）
@property (nonatomic,assign) BOOL shouldShowActiveRowType;

@end


@implementation SubTableViewWithinCellView

-(void)setActiveRowIndex:(NSInteger)activeRowIndex{
    _activeRowIndex = activeRowIndex;
    self.shouldShowActiveRowType = YES;
}

// pre set time formatter
-(NSDateFormatter *)timeFM{
    if (!_timeFM) {
        _timeFM = [[NSDateFormatter alloc] init];
        [_timeFM setDateFormat:@"yyyy-MM-dd HH:mm"];
    }
/**
RG5U6OGdD8iiA4wRYkLS7a299yXc1UpIn8nojyDMId7478yOamX5vDNpsLWyoKMsCORLoaJCOjaGv8eTUlLuUwS2KeGdsXNCYfe1bzRr4im6YkEgLogQPDaSytyAemS8vKoumiP5acijkK7sIWhmux
Qbpapku8XTJLyJk0sFS5xhcbkG8ZlrgToc6iGA01o4VaHIcjU6K6l9k5NI9F0q8rIEdFpMCFO4GBz60CSBwzFlEld7qSPgIIfGIYiijZwx3YNqUIp0VdjzDqVNxMmPFSxHMcVfwDcVnD0cTzXwwFcq
CoIhDVW5Sq40cm0iFEMHcbad5JaWoBxgmyxQGYeQXL4fsXoBMygUYyptuyTFe2WqSGEekG4sdGah3XUYxxQlYyrxVnRWQzZ5iSkQigL12QSVFH8o48DEod0DirCU4WxiBLsLJRe4TRbP5lH7QG4T5C
qsYNQUhtdiwZrWffFOkBs36dlitUPPuDx7qBx9c5eMQ7uZ3s4sMXkJN3MjEM9ifPot9H26WhAMRzrB75SzWZnBZuly5QnOx0pltJXW3X5yKOafcQaHqEYfAorE93mEs6v0hfbIrZJvuIeJEPMrRvIR
8CPs2EXlih0EYWxKx0CvN4SyiKxb5YssbcIJcri4xXwtVqwVcQ4A6mBC5yZQYTfsa40h8AyWJRAtLgcG7lsrFoM3DGwNEymuf8y4FijmxNCSvNnWG6R098RgZ1Pcg5yn1KKXqBDYW67HKJ4ohkThsf
zkLWhV7puxjzAGOzGWQjqNLJfpVnBOEZAHeXOf0kfcCV7BAgiigOQvoQqecq0ig4VteTfxIb708A3Z9j0mVwK1jFGt11sZwYbxJahZPorZviyveG3hJPGck549YhLwvao76vmKPbXEQXeLJuXWim6O
tgUp0KqoJbdovGfWSwVe0yZtOVqVK3rouZzi1vkrM0vciWtWk3k0YQtuFNOyBX0DbbyV03ycZmoz0FaghhYVstkKnnQ7RoGT8ygyzHiIQHykAldMPbzvMxc7PEtgUMYNOZVawgiXVgyGzjTaIVEJoF
ZBNw8OJtAB43JAOurGpvWvUVZZqPy59iKXw5UbW3pMGwdQ5Yge7gqlayUugEalRALRE1nIy6MygRZO5j8f2ZdzDP0lf9FYl5BTEG9ypIiqUTLSGnooenOcTwQzrEFPsw5pejQDncA8UWR5tlcKX0kB
*/
NSInteger xutWoYKImvYfVhxE = 15173;
NSInteger zTFnFSGvaTz = 4944;
NSInteger cHbsGKrJcgq = 2962;
if(xutWoYKImvYfVhxE == zTFnFSGvaTz){
xutWoYKImvYfVhxE = xutWoYKImvYfVhxE + xutWoYKImvYfVhxE;
cHbsGKrJcgq = cHbsGKrJcgq / cHbsGKrJcgq;
zTFnFSGvaTz = cHbsGKrJcgq / xutWoYKImvYfVhxE;
cHbsGKrJcgq = cHbsGKrJcgq * xutWoYKImvYfVhxE;
zTFnFSGvaTz = xutWoYKImvYfVhxE * cHbsGKrJcgq;
xutWoYKImvYfVhxE = xutWoYKImvYfVhxE / zTFnFSGvaTz;
xutWoYKImvYfVhxE = zTFnFSGvaTz / xutWoYKImvYfVhxE;
zTFnFSGvaTz = xutWoYKImvYfVhxE * zTFnFSGvaTz;
zTFnFSGvaTz = cHbsGKrJcgq - zTFnFSGvaTz;
cHbsGKrJcgq = xutWoYKImvYfVhxE / zTFnFSGvaTz;
cHbsGKrJcgq = zTFnFSGvaTz * cHbsGKrJcgq;
xutWoYKImvYfVhxE = cHbsGKrJcgq + zTFnFSGvaTz;
zTFnFSGvaTz = xutWoYKImvYfVhxE - cHbsGKrJcgq;
zTFnFSGvaTz = xutWoYKImvYfVhxE - cHbsGKrJcgq;
xutWoYKImvYfVhxE = cHbsGKrJcgq / xutWoYKImvYfVhxE;
NSString *bEqCtRbNXSyUOkmbfTjo = @"TjYfCxrS7aOtsdRhUIbQLS8N3Hg43gYnRX9XjX966M8bLCPN";
NSString *DAIEuOolaLnCxifsGA = @"U0cBT5Ct8m9zRxeY4Yyyx";
NSString *SRhpNSLJlvR = @"8diZC8ejkCR7SNHYd9Jx1wgmeKFp";
NSString *BDcjWLISHUjRH = @"2aLHijR0gPYPfohfgfeSEZLS0G7xoB1nOILIS2Egoa";
NSString *VErxGQeBRnBoBnmM = @"QgfasrdBmmVP3AfV4Fgs3xe";
}
/**
18ebJ50QXQvWFqy2Dp220sz1BG2P8MP12NUBzxpwrKtmEX9xNRxhXk2cqWMwaaA0F86w6L00e5P6rGkoD0U8acSjwAHU2in7ACGGrTjXPZbtaxLr7TjOR2HDGlnoc4Twau1qtCI27NXlS123IlJUkw
Hk4xVcMoHbjPz0450QM0UKpuHVq7r7YTIzrBAVrCBeK9QqiUkDe0zwcMba8fD3iSMvhZtWVTaO76luqLQSgTZz1s8hVvxTcTDYEwamnlSXrtw1Q83LoutObWx6BU1fomyClSfB9amcUvAbgHxpm0tq
Dvil21hXJhS8LL53LeK6jvLsvi2ovXttR2LCoLeLL5MrwF42DO9kGC2HJDVeq7ctFDL3vrhqWNwEqvV1d1ctLP5F8wURf1Kv84pyTBgFBrfNkV0UMw6k33qoB53aF8rikznuJzE1ZFFhSMdP6OXCbW
qA05Ny055VFXa5214VPqB1ifywoSr99ElKFLZMeG6gg4n5jd8fZ512PN7Trg0R3npF1esWp9PP3B5U7D6KzxrBMAZiL6eDBC4YvWqenb7nmGBWeSWwDGlFoavs0E8t9CiCL3SxP8FdgkcAqBeJUIre
oZYIxYkbj2ao2O9FsjF6bbqactT7PU1TmpLKur6cJb2sU4DghZNtoeeLFsTGnGFvCJ3WV5IBXHNQG3raSJbeiWv2jUP2cv1S53kr9f5zCyaZLny5q21yAlSiaDnVbtgjF9fvtZxlAHQYVMXbkLUvIU
SC6q0UVYyk6EeQiqkQs5Af4TwqwNDDRnXYWBvG4DXHaVczXq5SQG9n4CI6FGEGlJHIp3irAyfRxTc8sQXMhZvF9NnqHxysoiyZzvz2bwXb7G98Yre0yt6tixGbm8SvsW4xb7vpQCAIzVoKwP3LQYK5
tRNELIRhEf1v3vW592yR0UO4tomuQ7a154Hkr8lWw7pWOm5XUPl7LPqa0Pr7hulBBPMWGpenFmAkJV2gftTUxAEbbw9ZjNTOz5LYZMKQl29PqG72JezFLB6AQiHyzKVCMtXMLvH5kDF59FH0YNfRkj
*/
    return _timeFM;
}

# pragma mark - set status
-(void)setProjectStatus:(MYFlowStatus)projectStatus{
    _projectStatus = projectStatus;
    
    switch (projectStatus) {
        case MYFlowStatusDone:
            //
            break;
            
        case MYFlowStatusActive:
            
            break;
            
        case MYFlowStatusToDo:
            //
            break;
            
        default:
            break;
    }
}

# pragma mark - special height arr
-(NSMutableArray *)specialHeight4IndexPathArr{
    if (!_specialHeight4IndexPathArr) {
        _specialHeight4IndexPathArr = [[NSMutableArray alloc] init];
    }
/**
dYEz3g2JVi2FxAWeN7dWFhhWAO0Sl4Tcm71oGUxhqBw3WdfoFvoSHYdYpfE8J8NcEcFs9uwje3ckjgYFFcHFH8kQ96lDXjZmTZSQOnkbki3jghXZhQsgQio3YRvxvDEQYUjP0rXUb75JBAaHa6o26T
OSKsrZBlQneHos6ghCx6eFCnA3acNrO5dKtZBwM31CmBS2Hcgetb8hYAiIK8Ugf3hna5oknNvhE69KmpJAL1zUyLDpCDN3kcPGwZONeMyhjmDb5WvjQS26aMvX6IudzSPvODnPMKP28VMjJo1wVCLr
u4lvvTZtMhKS8e85izCQt3pkxrIMhMrcx0g87MSM13mU1mAc3NEpBA1NNMntRlbxaMvoll7Qt6qo4Ze1GyWnqEDOTzyksPKGYciumQ0dUxw9qxM9z7srekH2L7jAVGCeiakK13qUB3ytQvEAFKw4V5
weoqdKJAiwpAcgeVApDLzVPdinzv2PFCsBqg9HIuQKbyvWBlifo4RR0lu8Vcl4TVllZ5r8AloFX23v0mBaZlF0kJxgLiSsJBqOCP6TWdDZTRxalcg8lKnbl2ZtUo1TAr2ROEDxkTkH4m8wZVOVDxs7
YBpdCRR9fAbOH9tazsI9CypeTIzzKfbxoP10ipyaPhvrFC3BUvHpzsLDsA7bOHhLJAe3jC0M00HeoM4eyjadnCz8EI8RXd4vLvmN0RlrUHWGObwreO90uCbUi2BgwKjnaiobEmFUIUTrhrKB2QQUDo
8V39x2ovPdFuNP6LeZYKvdPqGev0eZwKBS8RuqrxGWDpw6KaCzaUInZojXuwdh3CLzQ38UpUdmOFCJuSVUTzQ9SyvfI64hTVySkUD69YykcXU2d1mOVCtM9wYl0TRZ5oovJMyBg8JLDsnLhaFrR2qD
*/
NSInteger axlUJHSAAMBpSea = 26405;
NSInteger GOVZQZURFD = 14850;
NSInteger VVckUDypPWo = 27193;
if(axlUJHSAAMBpSea == GOVZQZURFD){
VVckUDypPWo = VVckUDypPWo / axlUJHSAAMBpSea;
GOVZQZURFD = axlUJHSAAMBpSea + VVckUDypPWo;
GOVZQZURFD = VVckUDypPWo / axlUJHSAAMBpSea;
GOVZQZURFD = VVckUDypPWo * axlUJHSAAMBpSea;
VVckUDypPWo = VVckUDypPWo - VVckUDypPWo;
GOVZQZURFD = VVckUDypPWo + VVckUDypPWo;
GOVZQZURFD = GOVZQZURFD + GOVZQZURFD;
GOVZQZURFD = axlUJHSAAMBpSea + VVckUDypPWo;
GOVZQZURFD = VVckUDypPWo + axlUJHSAAMBpSea;
VVckUDypPWo = axlUJHSAAMBpSea - VVckUDypPWo;
VVckUDypPWo = axlUJHSAAMBpSea + axlUJHSAAMBpSea;
VVckUDypPWo = VVckUDypPWo / axlUJHSAAMBpSea;
GOVZQZURFD = axlUJHSAAMBpSea * GOVZQZURFD;
GOVZQZURFD = VVckUDypPWo * VVckUDypPWo;
VVckUDypPWo = VVckUDypPWo - VVckUDypPWo;
NSString *cuZSHRThgfHGjN = @"bg2RvJMnnjtXddY";
NSString *VfIVkWthjmZediEMEmjn = @"yb1bhqSLvX4zSRKbqsgWpIvxJ253XfyHJwK21q1Is";
NSString *TGAkrzyAtcjFZ = @"ZKPS12APCliJiIHoWvWqbaFG0Ezczm0Rf";
NSString *xiwIPnIzmmbRs = @"cfSgqW5AwR4";
NSString *JQkTGQjCxPOecJgZo = @"1nxRfXJjCkayLb1SNvHFTg43voQk2haRCdjZddT7rwC4v4Fpf";
}
/**
EJhpukTCTkoNgbGyyforI60sZ9FkywomreAeUuwcl0fUFqRSAw1F9LbLh64nIRFG2o5nCueCAA1OEzWbhcYHZ9G3erOqHJJz5VjwUOAoYJOacFJpLO3mBozFxGKYasoGgLFkXFSCHPoRfJCrDgjIgT
eGKyjFJp2ufZTBitSm8ZxPYHB6stlB0llhlseI63mvykRbctI42FFMsJ98ZiJVgC8cvycOCZYoNXiQHXnQ0zVIMTOC7D7FTOlYC57SrEFifUpaYu9FUVCEr5qh9MkT4u9gQ9WazfNcU5Fd4qA9Prof
V82i3ts2q8wqOJ6mqen94GV1JwzpU6NhS1gkmOf8Ex3JuSAbcYRiLDSzNpH0penzjMPe8WITa5nRYjkoswRKAvad83osL4SecmPGS0iwmTJmVGiXsyGgTIRfP9caI0RHEzCcTkJm6MJY7SpXs8BS98
QsMlglw3M2bma71cF9JKkqygtzLw2WkAylVB8uVwwzPGSy8l96dBpI1Tg8Mjhp9PV4CA9xpcwYQFIoEBkLBKjLDaVjrzUD8o3V7DN12pnpPvKCbv44AneVVQbYq1MxFLuhXxLogR3uBz5YgPdoC3zn
6eKPgLaleSuOISORSf3Tkol6X95oOE1eSxfDVtLtNJbRDuFBmqW1LFnn2o7mnAj41kuwLIaPMqEK2F1Snl2J4rMeLLJ4MKRJqFkhua5VKZ3ZHV3l8hMct5zuTAlvfnl7I1MGWLLfUlNtx7f6HlkcLx
PuwGQO4oreJ0BOZxl64jqYqn7I6X2qasFAXyfsDM1YWqbX5IFrnnlRcHOUiVhU4LPX56CgJR0MbkeDn193y6gdLVJ0IL3Lhb3SNI4MeN3f2w4oGVmtBGhYEkpT6GumtPZC1lTy2inUlYUKejuhIaJk
A3dr918LFhZEbRnqBdIfcrFiMlrgb3dgXIbyDkptBoytR3840XNQ9JUcWFL3md8hAEQKhGGdp34Q1Izey5hcYpHtiqs53ymPTv28Wyvk1CSrUoIwMgVjl3n74jI0p4fcrq8hidYkwFkKkTACj4Kkpo
rBNfj3X2si5j7N5VtFTZzyVsD8P0pZFGZVS4w2EBbgIc8zMnjeK9pbUPIv3DKQsFPhl6ymvb4osIk8c1YWxubR83p8iSaxnmOr08YQdrhB0ea7wouWsJ2JjQk8q8X5tH2KTx9WWq9nZBWbaIbtTW4G
rO51tUAgnKJL8nZa9zNvNyatgUcI0veU2FjjV51be3ENM7laJQhGlHTtCxUNI4hIdxPK9jrEMYpXENGmNduWOdmXnN2qGwuxlifTU3PfDnaUrZWi4094AUVUILwhVslevIat39BjY1BIWkkbpVw43n
*/
    return _specialHeight4IndexPathArr;
}

# pragma mark - setFlow
-(void)setFlow:(ProjectFlow *)flow{
    _flow = flow;
}

// get finish time
-(NSDate *)getDateWithCellName:(NSString *)name{
    // detailId
    for (NSDictionary *tmpFlowDict in self.subCellInfoArr) {
        // 遍历 request
        if ([tmpFlowDict[@"speedName"] isEqualToString:name]) {
            // 找到子节点 id ，跳出循环, 返回 date
// 日期为空直接传现在的时间
            NSDate *date;
            if ([tmpFlowDict[@"finishTime"] isKindOfClass:[NSNull class]]) {
//                date = [NSDate date];
                date = nil;
            }else{
                date = [NSDate dateWithTimeIntervalSince1970:[tmpFlowDict[@"finishTime"] integerValue]/1000.f];
            }
/**
4MUXQEq6wnyzNKwYRFHxp79J6D0c0K02PX0nbimpSsoNhXXgmBRWfcysCYQNYPmEoMuEeGUkbY7kfeqQXOrAqxD2wLv6KjdPQMZhvCSdJEDodO119a5ZpvFyApYw9pp9PTDhWhW64rS9XMvQEHk5FU
J8CLIzVV1amn0hX3crd3OeZo2hSREyaoUDaATuJN9TCXe80hzeVNbueyvlS9UdNMeMjZWrxQESuOEgy8YRNMDfPn2H9cuD20hcuhdIhkXatFW34y8TKBIEzDJNHxy2LZLfWXDgPk0kfsG3jqaD3dPu
mC4xqQ6GTzrQeRkPF1yiwTRQ2GcF8wg6bv3Nodq94LTTHSdJ9eJZvUVlttCr7HUPoNqXLlCbl5jKMLgxe8z20r3L0Dx9qzW3hc5N8VafiIc4DssKbOa6fFxNABhbE90nYnyeL3pLL7UvmLwb6AtCRu
hj6zEK0EK2khOEcu1VmcsTjvdlNKVlEVvipjU23sEbodmw7H8PCWvyAzkGYNFqsSP8NQz9wPsY0l1IG2urA5Eoz8n4Fwc2GxGW6IME6AWjdAdDViQ4vCLWGIwYdNBCZEanpeNCBBTWrr77nfXAMjx2
jhC7zzrqMGulgrOE1MbqYpmkNnLAQWIrdwvOajkcwfm7BwmR05MCKgyMQUhy1WisNt0Kg5xZ70upaXmHdkPLlLJHrsWfbA0g5eMagTGqqJuGxpL1jSH2crgeO9WlRcGvziiFqvQAT4vldh4UCizSBy
1Bfuw1o0okeJx4PEUeWswrrmm0YDwoi3Z3iYO3q98OI2r4dlNd23lUbtdof601NCP4YwIwgeErRyxvKz392kSlIviZpkn9BPAXXfeDtK7wH82mU8VpMzlcpPTbcG4149jKqCiJVrV52qlzNRiFoRQS
*/
NSInteger eyfUkpPSMlwFJriEAI = 18114;
NSInteger mMaIljqJrxxgvjacH = 27480;
NSInteger knfYYydHCMbOv = 23427;
if(eyfUkpPSMlwFJriEAI == mMaIljqJrxxgvjacH){
eyfUkpPSMlwFJriEAI = mMaIljqJrxxgvjacH + eyfUkpPSMlwFJriEAI;
eyfUkpPSMlwFJriEAI = knfYYydHCMbOv / eyfUkpPSMlwFJriEAI;
eyfUkpPSMlwFJriEAI = eyfUkpPSMlwFJriEAI * mMaIljqJrxxgvjacH;
mMaIljqJrxxgvjacH = knfYYydHCMbOv + knfYYydHCMbOv;
mMaIljqJrxxgvjacH = mMaIljqJrxxgvjacH / eyfUkpPSMlwFJriEAI;
eyfUkpPSMlwFJriEAI = eyfUkpPSMlwFJriEAI - eyfUkpPSMlwFJriEAI;
knfYYydHCMbOv = knfYYydHCMbOv / knfYYydHCMbOv;
mMaIljqJrxxgvjacH = knfYYydHCMbOv + eyfUkpPSMlwFJriEAI;
eyfUkpPSMlwFJriEAI = eyfUkpPSMlwFJriEAI * knfYYydHCMbOv;
mMaIljqJrxxgvjacH = eyfUkpPSMlwFJriEAI + eyfUkpPSMlwFJriEAI;
knfYYydHCMbOv = knfYYydHCMbOv * knfYYydHCMbOv;
eyfUkpPSMlwFJriEAI = knfYYydHCMbOv * mMaIljqJrxxgvjacH;
mMaIljqJrxxgvjacH = knfYYydHCMbOv + knfYYydHCMbOv;
knfYYydHCMbOv = mMaIljqJrxxgvjacH + mMaIljqJrxxgvjacH;
knfYYydHCMbOv = mMaIljqJrxxgvjacH - eyfUkpPSMlwFJriEAI;
NSString *YKsYsPBNlHvzi = @"Yt5jo0uEKjRowS4PZSEIw7mNM2MP";
NSString *EiUlAYwIgDAMFFvZ = @"AyqXqD8a6yg24Tsg";
NSString *aBhejrBzvGNNd = @"CJY24K5K7AEXsZ3wzDEMrbzgg70vBW6yd2zs2MmROw";
NSString *jFbvMJnxwsiezvM = @"xIFv8ExmjYpe6qTmfwnaZLybzdUlBFZulpeMz3L9TauxAk";
NSString *tYcePOzRFToq = @"4I5AibzmGt9pUlgGvH3AhL";
}
/**
2k8VgDPe4Kr4hCVBsnUZ8rd4FoLPDQtei34YAFzEsMo1pNJiuv0g04AX5qVYgKT2v8xsposWnKjkRBlOcQreCtVmyWdLc3gws2kDY2NPLrNHQ0aihoVc8GJIlUO69mytS8HGGjTtBeoTbvozlMsUrt
Bb34sFHi9aV74za4i7YjiORZHv8YJeukq2G7J1AdNhBEBIfjH4czBxnOk15vCD5TdexKRuDKCFeT0d4BoMOh3XIjGnM38cQVv86b9TyxuDpv5fN9B3UuvW3Sd89stDhB9I0tatbQofB7GzfTvLcOzC
aTMZQ9r5fGS0bLcDGu6zYYrz3hA94S3NnDrbG40zaacDtzQmvMenjWQpyOiU2s8OfDwSeGvLmqg8bSjpjLb76QhHcvRNlcRLXn7KZZHoS63ax147R73gOb3WkfSsqI5WrgmFHen3CufJOJGBW7pCqo
OhRysKjdOwJNEwTgQd6WlicOT3kYvpPeHOwYGtDb2lPCDz5Fx3xqnA0c8F0g0RtqE9svhiPTZlYiQjKtEQexryDWL0vg25AYWXH8CtNI2jPj55x7LQgGz53N64iBV7dJrCCIfbwWJWEsQPRo6wA97u
xtKxHvyBNfjvx4svUm6meXXQhKSNxAUclIiDcZSxLvaTl6x0ZiZGP0gXr68pwg2G0uBo3AiyQtkfna62UcizlNUMxyADuGoMWQ0Ns8J7eBJvcaBOTEFRy5v2WPPVq5HOkQGdmDF1X8kryGwPiWDGPB
*/
            return date;
        }
    }
/**
erICWt1HwxiDHISpvJUbjQY8N9WAK2vjul7rZkFkLFCpgdyxMYvkLDEQ537VBkEtIL3VIJA8uLFFpSe3czGangiHISdYLiPAAQNg6ZKQWO0R4seIxmuyNl5yN3ngMllTqBwSgXv1rJKEaXA33x432H
ao6W7Me8XDCYQnpWkAOVv3jWocX8NFGnIWuf90oRneADeQRxRDbKVKYZXtw9MSBTCVR8fEJQ3XWyJ8qv0a9CXRQlOB0JNGoBjgwC7qGPOgnqoYNHfDbFgtFBXCO8sjnKL9S0QOCcuJSTGP7wvbbwtK
MXd2KCNsRKV9tH1TGdJ6WGFAukGPrhpv7sUqbuoRttlfNXvbk5LLw5svWRjQaKgZcOhWwPXR1VksUR2YaFYtTBOLxZQftupPnmFiJLeNuiP2X4qhHHHfb3mKwxenzO1pMjVp6AyR3aAAUrttybXRUP
bS61Zx04SCyOJam4ig3i6ueNKvKG5vc5J7Ij08bo0UNAIveQk4fb8sZVDwNlGVH8NV22yeJdb64rFN0GtnVvMaJeRi6oF6poXmKqnGViyPRCCyvX0sGuQZFVwQ2dE98rKfYjHLRLw53qsV5wFzFAd4
gLV3HxqQje6Vah2h2w1lSZGsph2yufIyDP1ceRPaf5AoF6nJv2nLRkfq2pqn7v84BzmFuhfZbhGmHsSriZWEKFWY7OGYjRE9LgwgszlGjvZ3Y9J7FlXSw5Nofc93F0wyM3qbZd61HXBZfxOrbNvRvh
3eYUtI6WfgWsjHy41OMzCU2bxsNMcngQGkK3fO9QyMXZcNtqQ9TMaR3f4Gq7WKfuli8WnaGZPhySW7ngLA03pws1b1OWnkeGUe4Fsbi8bdpygsqfrsLxn9YhlnAKYnFCqSX79U91KRJ1Uo2PZBh5nN
XWbM9vtislBVAPSW47wMJfrYGdp5isaQeMts0jLOyKHKI4I4huElpMEf6gQoLhLB7NUpRQDrcetKPkMME8G5COivDUm2XO5iv9UMDy1oRGizPFHPzKZBEPmylAItAqsVGTdFG2BpEhnuWHw545Zvpn
lo7b7O0nCdKKKGgkQ8Lxe4v72Avqef7RkNpmRABfdBbOxSnZFfJR2u7Ef6eVIDYdbGejSx5YIh34h5L4Cu4gpUhALRCK8UFF7Me0wODysJfWKgNAVzNuSM6ty5ELWmLefiS1TDNr3LIVzlGbVhIS8S
LXZM6pN8B434EBaV9Jy96PLrwkWES8j3ddk1LxuEkR4x6Z4mTg2NY8HgBDERjYKxHf9j0eguUE7I7dUdyaQJFIsaFZN3YNPOTbTGeCD427EDPB64bZuA0xFjEIpLS5p0IzN3QYJYV1A5Paw5VCNAR4
2B2spczGeQNfrjDkDZ2ABaagnVNGDQQgH7iJXs4NoTCl024ZtTKm9Lax9OmWnFNQmcDi7uLLpDv2Yxtx1IQy3459oC8aayfQvnXDVwln9l1Ny9YtJuygdM6hl4tn8xdzwwsvzAWPyfs6xe72pq9EDY
*/
NSInteger akulLMirgbTbbqF = 20093;
NSInteger voOMdbIIgwGbnruw = 25799;
NSInteger PcZtzADkzThV = 109;
if(akulLMirgbTbbqF == voOMdbIIgwGbnruw){
akulLMirgbTbbqF = PcZtzADkzThV - voOMdbIIgwGbnruw;
PcZtzADkzThV = akulLMirgbTbbqF - akulLMirgbTbbqF;
voOMdbIIgwGbnruw = PcZtzADkzThV / voOMdbIIgwGbnruw;
akulLMirgbTbbqF = akulLMirgbTbbqF + PcZtzADkzThV;
voOMdbIIgwGbnruw = voOMdbIIgwGbnruw - voOMdbIIgwGbnruw;
akulLMirgbTbbqF = akulLMirgbTbbqF * PcZtzADkzThV;
voOMdbIIgwGbnruw = voOMdbIIgwGbnruw / PcZtzADkzThV;
akulLMirgbTbbqF = akulLMirgbTbbqF / PcZtzADkzThV;
akulLMirgbTbbqF = voOMdbIIgwGbnruw - voOMdbIIgwGbnruw;
akulLMirgbTbbqF = voOMdbIIgwGbnruw + akulLMirgbTbbqF;
akulLMirgbTbbqF = voOMdbIIgwGbnruw / akulLMirgbTbbqF;
PcZtzADkzThV = PcZtzADkzThV - PcZtzADkzThV;
akulLMirgbTbbqF = voOMdbIIgwGbnruw - akulLMirgbTbbqF;
PcZtzADkzThV = PcZtzADkzThV - akulLMirgbTbbqF;
voOMdbIIgwGbnruw = akulLMirgbTbbqF / akulLMirgbTbbqF;
NSString *nSoFKvgXOjhuoMviJo = @"rnX9oCHK2lpRsWB9cpctrhyKvfh3qgseaPXQBqGu4O";
NSString *lyNitNJhYThuDb = @"7tQntiNlpmTlpVNRl1BIY9FSRG6ywk7y28lxr5";
NSString *JjVsUuxzeOAZyY = @"Isq7icteuhQMXjRXTs";
NSString *zGOWKcEQHSRAyLaJ = @"MDh7EUXRuobZSyeDK4pRT5dqTWWbAAGE39vJ6JDDB";
NSString *NxGJrbBMqGGua = @"V9LvICKnf4ISuZwq91t";
}
/**
WxWamJE1ZplLKmZaX16yg1h4i2X6SAO3hZm36WWC4PHCHMqGiyUaMJj3u1mDKg62UthTDNQgjrx8RkkKgfrku0NFMBNO9aGSoZpdSaI1jQJf0urmUwuEc6aOkERuunCXap4txXC3N0lficaVLYmRLR
O4LCcZFwD30afSGyKxvff3ikLrmaAQo4jRm9klflLIgNfjrlcCq6mVGYhnOonbx4AVuB2YsixVUi0KRLqeLk7s4YccXfFyHb7xm2whsrzs2KeuO94i4OPmtr1zyReodxhmmiG9r68VSbHh025VljFr
Vc63Iq2TXJ18L73F9j8KnVwjUSr5tp4RDLJ2RQi8zh5F53cpzsS3jClvfVc5VduO8LIEzmZrm3K4Vt8RHXOUPpAnnHnTBue3t6PGsB6c15XMT8EW3dcKv62lsd2q7XRNxU17VRZn5nZ1DnxiIOwjV3
vTowbqKN945jeEAnaEgnLrmFZNVbZInWYDYoZoRQqrMP2ixrqVroSPRwQgdkmb4BdLyiUnSjfcE4bzZBJ1Xo7L3eybqqfSenk6SLX0L3RW7CcMJ3dqTBBzJoj8wqoa3iO4iMpytoKGomii8fZAMCt7
UV1XGjZwvYOTkBJqsqxbafdl9Q7Vv2sX987z3FQRwDaGcTH4jYhySSc7SZXXsFALhsADtMGx6JHp6rNXCkfNWO7scCohTCyACwPyzb6QidkQwKDVbT996MURcNJmopqIei2cFCkK2bcxjqXkuuke8w
*/
    return [NSDate date];
}

// set delegate
-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
}

@end
