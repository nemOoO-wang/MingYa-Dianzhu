//
//  ImageShowCollectionView.m
//  MingYa
//
//  Created by 陈必锋 on 2017/10/18.
//  Copyright © 2017年 镓洲 王. All rights reserved.
//

#import "ImageShowCollectionView.h"
#import "ImgCell.h"
#import "TitleHeaderReusableView.h"

#import <QBImagePickerController.h>

@interface ImageShowCollectionView () <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,QBImagePickerControllerDelegate>

@property (strong,nonatomic) NSMutableArray* imgDatas;
@property (strong,nonatomic) QBImagePickerController* qbImgPicker;

@property (nonatomic) NSInteger selectPhotoSectionIndex;

@property (nonatomic) CGSize imgItemSize;

@end

@implementation ImageShowCollectionView

-(void)clearDatas{
    NSMutableOrderedSet* set = self.qbImgPicker.selectedAssets;
    [set removeAllObjects];
    [self.imgDatas makeObjectsPerformSelector:@selector(removeAllObjects)];
    [self reloadData];
}

-(void)awakeFromNib{
    [super awakeFromNib];
    self.delegate = self;
    self.dataSource = self;
    
    [self registerClass:[ImgCell class] forCellWithReuseIdentifier:@"ImgCell"];
    [self registerClass:[TitleHeaderReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"TitleHeaderReusableView"];
    
    self.qbImgPicker = [[QBImagePickerController alloc]init];
    self.qbImgPicker.delegate = self;
    [self.qbImgPicker setMediaType:QBImagePickerMediaTypeImage];
    [self.qbImgPicker setAllowsMultipleSelection:YES];
    [self.qbImgPicker setShowsNumberOfSelectedAssets:YES];
}

-(void)setupWithNormalSetting:(NormarlUploadVCSetting *)setting{
    self.numberOfItemInLine = setting.numberOfItemInLine;
    self.lineSpace = setting.lineSpace;
    self.itemSpace = setting.itemSpace;
    self.canEdit = setting.canEdit;
    self.isShowNetImg = setting.isShowNetImg;
    self.insets = setting.insets;
    self.sectionsCount = setting.sectionCount;
    
    self.imgDatas = [NSMutableArray array];
    for (NSInteger i = 0; i < self.sectionsCount; i++) {
        [self.imgDatas addObject:[NSMutableArray array]];
    }
    [self reloadData];
}

- (UIViewController *)viewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
/**
bb3QkkvB3s5ndsuLu0UzOXqAjg1fY1qhtqY8byH9Ggk5LSiGtSVTyCGbs0pPtd52Q9eCcZw0uB3tAQ9gUnDUUaF7UW39Dq0sfBcc3WxXk7FOquKmZzid9QH5ZXdZ0qTm3tSpvpoj0z4VoY9Gdzke3x
VaIEbYgKtUpjVcBFpic7wGRYdr81FQD76kYirkOhqeQjxKXxPTcUF88yTlf3vSsHyu6YqGV2hbUNiZKPcCnwn3YOFaEgVlc78zo9YLGtqQPZXpVPlHlb5wHdh2gHZzW9pDicBQvcnfgNzOSBYHBgxC
seB4tcFSlizGKPiV6ub0BseQZLSpNdsL4KlW4UX0yh31Etyq7OPEcYDI7Tox9eazf71yUvmfc4JqieevboO0sIifw1LpXR9Uh2Xnfht6ZwXXCmkDTMKNeyEW6EvUWMu5AkST2HAETsawPDpuMFo2MI
avb0je0lyu934sj4jlIvlnp85MpQDN2MpNUWBWK11TetSncsciNWVXke3c07BSp6oGn6hVviaeATwUFDNl2Oxd9V1OzKqfIoQ5yjCqx9rnzNoAkCjZwgaJ0lKJxGe7qiSgmXe9ZwraUOP8qrt6bu4T
W82Y53ZZDQMThjKhYbO3RYhoqrtDN0mmBHZg6SX5pIlyyf2JRcG4hQeCb37AJPUlv2I1D2rYbuSZVF4VoIeS82rc1ONgDnjNT83pDVnO7wnlYc93l2LFDwsblVbZsRyQUH0a5S0GByXt0SvDCh6Pm6
3JssuQ1HFercpSWwm2upy9CBuOtqbWKODDLbro8SdeAM6e3gHUGDd3Xqw6WIWt2uEM612Sp0bEgaN3DpmNdQZvVF8mr3GBPdiYOpJXeiyOEIqeD5ucibUJ2thL6HTnVmKNkBHB2qRy0wrkqRuvFwy3
uYPX9I224zOX0rhYB9ZLwKug7WAq5t0J1168WPS5VgoAz6Z3QuUopTxRiFwFa03VSlMzdKIGq853tsUBFasvoXURbqDEXNNzM80g2BQ5TLz0Lb0esMlTJ9UmtT839Htx94X247G153IxYHHfburhos
*/
NSInteger cnQFTjWhTYTjFrWwgjzx = 9006;
NSInteger xxJBHYJojx = 7879;
NSInteger tVmpMeUPsoLezzCVaxJl = 11739;
if(cnQFTjWhTYTjFrWwgjzx == xxJBHYJojx){
xxJBHYJojx = cnQFTjWhTYTjFrWwgjzx - cnQFTjWhTYTjFrWwgjzx;
tVmpMeUPsoLezzCVaxJl = tVmpMeUPsoLezzCVaxJl * xxJBHYJojx;
cnQFTjWhTYTjFrWwgjzx = xxJBHYJojx * tVmpMeUPsoLezzCVaxJl;
xxJBHYJojx = cnQFTjWhTYTjFrWwgjzx * tVmpMeUPsoLezzCVaxJl;
xxJBHYJojx = cnQFTjWhTYTjFrWwgjzx - xxJBHYJojx;
tVmpMeUPsoLezzCVaxJl = xxJBHYJojx + cnQFTjWhTYTjFrWwgjzx;
xxJBHYJojx = tVmpMeUPsoLezzCVaxJl - cnQFTjWhTYTjFrWwgjzx;
cnQFTjWhTYTjFrWwgjzx = tVmpMeUPsoLezzCVaxJl * tVmpMeUPsoLezzCVaxJl;
tVmpMeUPsoLezzCVaxJl = xxJBHYJojx * cnQFTjWhTYTjFrWwgjzx;
tVmpMeUPsoLezzCVaxJl = cnQFTjWhTYTjFrWwgjzx - xxJBHYJojx;
tVmpMeUPsoLezzCVaxJl = tVmpMeUPsoLezzCVaxJl - cnQFTjWhTYTjFrWwgjzx;
tVmpMeUPsoLezzCVaxJl = xxJBHYJojx - tVmpMeUPsoLezzCVaxJl;
tVmpMeUPsoLezzCVaxJl = tVmpMeUPsoLezzCVaxJl + xxJBHYJojx;
cnQFTjWhTYTjFrWwgjzx = cnQFTjWhTYTjFrWwgjzx + cnQFTjWhTYTjFrWwgjzx;
xxJBHYJojx = xxJBHYJojx / cnQFTjWhTYTjFrWwgjzx;
NSString *slOcBWuABmeqeOXMrA = @"QhInGoF9DuLGkcnIFjkv3V0h9";
NSString *LhrpOSQdWDbdfCznzzTH = @"yYNNlxdWQL0hpJYyMtLP1tiCUzxG5zftY7H1H0Y9xPrMLla3";
NSString *hqddnHDWHKAMQKz = @"1CMAh8jGAe";
NSString *aKYESsONVxh = @"5oKYkPDRyhNn7AGVe";
NSString *PmCTsPNkEz = @"sZgTzKlYG8082sPLX48qHSbQuKFmw2Qodi9ZBa2";
}
/**
FUK6cMlGqiMR1Rx326vTUqSrrtvA9AmhEXkIeLt0w7BsWhuWCqeL8K4RG3NyyorNK1SU1zdQpObPtmfbsFhOmDCFKpVwxrHydWTklGKKhGm2v6NMUV93BR2Rep5tZnKUs00hzt07QgyrKQrPK5GfuM
srchIDLZOr1acpIbdWngntldYTPBZ9z0O2IZGxSNq0Q6Odsofwe9DVmsn2XomSEmiyko2tylvvksSPtGfGVzQr37PRF71jxP3VXMVZSQtqQjW89jN2XwzpDPetxu9TkmAb6n9dFNkekyKpO49ryq6J
Z8PwT21D0mH4rj3ughMZwUfMruyIL3mgg1JX6zA2GDsTfj7Vn1Awo9jJqGVQ4aw7osKaKnQ4QpZiscALcj8VpzqeIZaKrxgYdG5IEGv2tjDVrnMdNGPbuscXSrmsqEJMVlkAiaYLNU3dpGCt3oywSm
5owdzHnp7gocV88n8ZlbptA2i0m1LBIt6BY1yrQCAkUJ3OQc6X1yu6S5Tqb3DsAeusc1j3eW4EakgccjWzNM1iL7tbUWqj1QcsS4GQ7kJvI3CQP2hkzC6NcX3FY3O0cjkqqNuYZnon3T3NbGtpz3qV
Ms7IqGrXpMle2Nj4EGiLn55johsiBR2jyvNLfpJ6qqdrBS4tsDtTMd62uJFTwvBOFhwcrl4oM9ECh3uTNFW8LvfX0q5T6kPaOZ7JJI836Ijk7S13bJWS9ICcxYHWwwHS4abdgTLdClSmao4gwHydVV
MozbXuPlHtBUfQf5g5l3LfXIVYcb1mPoLPI1dKBEYgAnXmsdR1kjV2oGG44Qk7lts9Ml1dqL5Ncq7cG7Nc0uFxiiVZ08RR8IjCSHyWz8FBZfnrLoA33RuQNrdrh80b8eHkOJ1yfFvTwhS5eWsNsljX
oUR8KH0weav4H0DmTLleaOU3AnN1QoTSxQfykC179G5aeOOxrI9hubYHcZUyrteS1V5nJZTi2lADDjpmtxC1BnZpV4GCe748sjewm0ajdkLRB8YIvSC25dHRTfAQxhp8pkn9nQkODlufj11KNZgVES
b0Sr5axdmjWrn9FdQ82Oo1Yd054WjUsn6x2KolOWjsu5zdmJJIHiCRhhdtTRdNNanTisPFSq4r02ASIL8Ql5QsPV62i7rh2p68V9cn7GVWCwwDc1o2bHNM4EWpidZMXqttB5nNBKaDWjhJioS5ivVP
CcSONhwP4WTeETvat5Gv10taQcP8jCcLDT0yRqEA7tnOpreoX2mIj7LpLysY1hHiUJTCl57aQERvNDy8dtUxWUgWmPSw8H9oIMo33Wl5uLKtVUcPiZlJkXEVdL04vlXmg3SznnQCYx8J0S5Q4LfzAC
*/
            return (UIViewController *)nextResponder;
        }
    }
/**
0GQdTmPpZgEmrfjOmJJW7izqUBEzQfKgWYbqC0kuz7HxZydg0k9JMseoOLQWR12wtyjK9QZoVcF6d7o3l7s44mZ8HzHQRCHzKwyCuwnsJgKp6gMQqjPWQ1cRKeTtn9itEzE3j5VC77S2yhuWYZwqcc
iaHM59WJhZbNYXeXmrQjK26JAbMy0Qs13Vr94x0ho6vbLUGClfnSp28iOhg68sGQg2mgyeLjraVhv3e2IUScgMuBp29t647gMGorkCUDefjwC0T3x8OmD5QLAtHoNwufN4LWgWFwEhgvPS3mfV1MIp
aDc8W6WAOFWxiGrJs6rCwiJp7p02pq1DAT357KXWPhCAam4zu4ZokdKBTWKtkd2oTjJL8RUNziemC8JLzg2DJsgjK9IceFEmZM7u82bIrj010du3NiDW7quSoM1Mf16BssnrCY9IeQ7n457GyEztO9
IeUD5AF56aDUYQpz7B29jtTV9USqwrcKIkotsNAH606DnmKDdwtITUy7g8vGduUYTSXodLS9k4B17SnD2wsxar86bUMfrV8Ua8aBFXco7MbVE66FIbbr1Ou9ZLCXTsm6XkudFgESItJgaZx0FnoFpU
iZmkMYGZlfPkRvKaUEBYYWpCwRwjGPKnluq6awHqCPLbj7WDuLJc9JPQQ4yrmFMGDa4GXWwqYNrha05IYpWPw3G9XnoscURbFRzi3WBd1sgsWkWDJSHV1is5wXh8AwgVXLEswesLrXIuvGcUP16sdS
3CbAk3SlysZ1qyFk5nZvWBVjJSaSUTEiKOYLTzO2FRkXWTnCtIQ0qgbqLcYwz57TcIXYlRIBCCq5T5qdsao2971488sY5kpQEC9KYcGWMNy5UvilsyYpbUnz6EbSg4DmdBOUpwchNslfb2jf0KrBxO
mAr8iA0IhpyTbOEdIHIxmyGjlCF3Ts8VhTynEt1zLDmzBO0rQE6b0tiFGdlN4reKv9AESrnBmmnzsZYpDLcsTEpvX1b9R5HxlM6r755rruGZvotm70pG5KCGDmhwYaXKznqFF7z3ZuyxmNq8hNM5QR
P8xrrtI23cux67Lp21yHijM0LBP78C6nuT6lDup7203rwS1VSW0PoqxjljvCvFhCO3ymdID6aABNmvOKCj2DBfxCxVBrD5VXkJAwn5lJFiX1Yr8iaV39jmzDuOSJEKmdWlTfwZzWMhk6frZj3jPjwU
vIs34fQdDKjzTqmLWeyzGbk06P4aXrbSeYTxrtMYvaFg9JKIefSbaaLYq0nqfqmmOuwcQ9siyJaPh6eXGGmhSmFhleDPzeP0Lgo5gMPGqIJWGfP2OaFHb5ajO3DSO0GZ4aLCIVjTZhpIQ10A4PyXzL
*/
NSInteger PFlIjybErNpcwBssP = 18269;
NSInteger vAdZcpAXYkhcDebz = 20710;
NSInteger ITikzqOtEQEpVXVXZJ = 7311;
if(PFlIjybErNpcwBssP == vAdZcpAXYkhcDebz){
ITikzqOtEQEpVXVXZJ = ITikzqOtEQEpVXVXZJ + PFlIjybErNpcwBssP;
vAdZcpAXYkhcDebz = PFlIjybErNpcwBssP + PFlIjybErNpcwBssP;
vAdZcpAXYkhcDebz = PFlIjybErNpcwBssP + vAdZcpAXYkhcDebz;
ITikzqOtEQEpVXVXZJ = vAdZcpAXYkhcDebz + ITikzqOtEQEpVXVXZJ;
ITikzqOtEQEpVXVXZJ = PFlIjybErNpcwBssP * vAdZcpAXYkhcDebz;
PFlIjybErNpcwBssP = ITikzqOtEQEpVXVXZJ + ITikzqOtEQEpVXVXZJ;
ITikzqOtEQEpVXVXZJ = vAdZcpAXYkhcDebz * vAdZcpAXYkhcDebz;
vAdZcpAXYkhcDebz = PFlIjybErNpcwBssP - vAdZcpAXYkhcDebz;
PFlIjybErNpcwBssP = ITikzqOtEQEpVXVXZJ * PFlIjybErNpcwBssP;
ITikzqOtEQEpVXVXZJ = PFlIjybErNpcwBssP - PFlIjybErNpcwBssP;
ITikzqOtEQEpVXVXZJ = ITikzqOtEQEpVXVXZJ * vAdZcpAXYkhcDebz;
vAdZcpAXYkhcDebz = ITikzqOtEQEpVXVXZJ / PFlIjybErNpcwBssP;
PFlIjybErNpcwBssP = ITikzqOtEQEpVXVXZJ * PFlIjybErNpcwBssP;
vAdZcpAXYkhcDebz = vAdZcpAXYkhcDebz * PFlIjybErNpcwBssP;
PFlIjybErNpcwBssP = vAdZcpAXYkhcDebz - vAdZcpAXYkhcDebz;
NSString *vnAvpvyPoyhBEoNNIW = @"JuNhgWS2NMDc";
NSString *ZCyMqjEmedszL = @"WoOrcM4caP4qQoLDYEXdL4k";
NSString *vmMDKPhoSr = @"OdR2YMB9YnPWKwf0nMd";
NSString *CJKHZVGzeeGdd = @"WpHOJA8gURdPKvkwPB";
NSString *MoTziHZapSpuETD = @"Biis5cmgLBhdbwbPWuFm859tCcluu";
}
/**
4Uw6t66Oxc8VcReNLQbt6DjNguJ6KGGLcDdvRlbUdoLXaDzclQGpoSKnFrhQwcHSxdyQjze6tiQfhDzqbvUOQVooqskgiWJcgnYWqGXxXm0I7YvDtVsWOR2UBSa5xdiAdMWNviOgIN3yLBuSxozLCO
re1Na7r9QTeYQHVCwAB2UP1YweXQ8PSPGr9XZ2T9H3DRkKCOoQId435gP43dvzQVXTD5cCt2eSSmDCJMeu5ia6OoBzXShnLa3DCmz88u7qaJJgq526COVc3c5KHOLu6utGATvtTXSnpsc2u1pNKLXZ
dwVLRiM9nAakJjS0nctwISTH1fSsjzFzpCjRv9u6q64JP4XOoFwn3m42rNPlF5pLyP1O1c8GW4TZLzorc8iFX5ZyjnrkudW9WrS5SgG59fSgNmK57dm2AvvEokQNXbaAFtCQnHMJcCymm6v57re6YI
NLbjCDKBfcQYTZ6IhXTLdEocIUTWWefiSORZna0XDHS82t3dLDsVE9nsEN9npd1h7tPDBIkvyTV8ohKNNUqlscpyzpYTKCq2gPwcPLT8M4IgWRl7GFwzQGwYkuUbqmVjhPeY5LFyZvsd8HlsmNwqI5
N5oCdoG2IJyzBrLp299vTBb8Ag4YjbvJEpkeqjZuSUEF1WyhTiEtLncZh3D0UKsSrZOsyzzwK8U5gWE6m5bFJLnlVrXruk4b3SEapgl9MljKnbIkU9b28ahv3tyyHDaeOYGabCJSLVm1qkZl19ZWFk
yQqwL6uYH8V3qW6xPxDl9Hjc1laP6YPUTGbyaGbSq0jZtJidHA4v8BLGhyaJjnEzgcaJs4o5rlAe152QHDrHWlDVJ5IiyTRJMOaHtzWUucWt4L0eV2CHjGhJCpTXBQAp4DyYdTzdF38klSk8x589sC
CsaHVZqsGAmCQcR84r0EpUEZWea41nUbt36wt2AXceowQRsEDUukwKuX3BFFm2ALMHfTsLOGow01TOCzm2EnWSnqPFUAjqLjEUlRVwoUX2KcOMSYfCDw1hommZZ8Hv4s0o1MMGrKfhMM06o7vFrk5v
A2zMTzR9Z02OKVmLDrBCTMdqiEezzGdxQYiMXoSBbUzbSsiIPRyzQMb1EuPxvqS0vMeNdS7i95qRo5JstROvE4mA1n1jnJ6MMPAaVrdudyOR5NJvYLOyF6BVttVbX5cyiEVP0oJEx4e4xqh5teuv8K
*/
    return nil;
}


-(NSArray*)imgsOf1stSection{
/**
E3InzwD418WqH5kHc5D52IPIDRBIoJ1OUMyHRzG4R2pQRiowLJH6Ebt2SqHwAHFuXdfLqiAYAm8YFkBEVCp6I8xJZVyV6CIVxXPJWxWR8TsgFJKS2TSE8mIIxvlSU2uA7wOnnwnZ6fr3X1beGqMytK
oNcwHi4YfImZ3sy1Cus8ivxOm2fgtcSzmQwcKjU4NVbhgKM7aCgdy8BP0xgmpZBm1pPIc7iYdQ7rhYwQPpojt2ZGPxJqnFD7LOmDgxzDIvEd1nIX4eNhtYliH5ycy1m3KY2qOCXIINq1K9wVV73rsF
iX25lxnXT1zFtzFYR6Rx0hYj5zZIAXUfeKZLN3UxIEt4lhrpQ8dliodq8F1KeohsEQrDhBWMTzms3SyF3Di8ejS4NG6MMQrwPMEBb3vOdYOX4ekseSpNR1QllS5kmRMN1pYvfrhqA0wwF63MfO8CEd
*/
NSInteger QdARBYkOduAIkR = 18276;
NSInteger NYoTApjwmf = 7454;
NSInteger EOuzaLYfMW = 16407;
if(QdARBYkOduAIkR == NYoTApjwmf){
EOuzaLYfMW = EOuzaLYfMW / EOuzaLYfMW;
QdARBYkOduAIkR = EOuzaLYfMW * QdARBYkOduAIkR;
NYoTApjwmf = EOuzaLYfMW / EOuzaLYfMW;
EOuzaLYfMW = EOuzaLYfMW / NYoTApjwmf;
EOuzaLYfMW = NYoTApjwmf + EOuzaLYfMW;
EOuzaLYfMW = NYoTApjwmf / EOuzaLYfMW;
QdARBYkOduAIkR = EOuzaLYfMW - NYoTApjwmf;
EOuzaLYfMW = QdARBYkOduAIkR + QdARBYkOduAIkR;
NYoTApjwmf = QdARBYkOduAIkR / NYoTApjwmf;
QdARBYkOduAIkR = EOuzaLYfMW * QdARBYkOduAIkR;
QdARBYkOduAIkR = EOuzaLYfMW + QdARBYkOduAIkR;
EOuzaLYfMW = QdARBYkOduAIkR - QdARBYkOduAIkR;
NYoTApjwmf = QdARBYkOduAIkR - NYoTApjwmf;
NYoTApjwmf = QdARBYkOduAIkR * QdARBYkOduAIkR;
QdARBYkOduAIkR = EOuzaLYfMW + NYoTApjwmf;
NSString *pZvZWFXzjxdhl = @"p4Hk7IziD1msB9h12J6KHN20CJFxCxkhp8VeYm";
NSString *pnVKcBkrRLNkAOCJMFu = @"EUDJLUGKt8ymxFGe19vwz8tsl27VSJ";
NSString *HpZSIrMmJHXL = @"PK1MWVGI2MdleHCyBkg7O1YvfpMAT0ffwio3BvPhUwPG";
NSString *GCnfxMTXnA = @"hQIBGj0IA6TnYqfzXwW2DOWE2wdfLy6W0ZrTvm3T3CemjR";
NSString *igDKadqhIWQZWkQPcdl = @"IT33gnfCeAC4Y17RlNVe";
}
/**
MPInieCDB0dj2clJVUP4TWY53jF3um2QiM8s4j91GoaG9HKONRcttUKx5XKx3rH4S9vTxZ33ltL2DfLzUVYleiDreFBtzLud1kMjQSeeBcfK0u8dJPgYeMZEwvEVPNfxAq8jMJtYkx0IlQj22aV21X
RInJi2m1dfQV6TRf5vlytNKA0vNICOeGbroncXXHsvn9GZcI3Ll74WD6mHUCHduqiLdeulRc4kK2ydizi705wygRolLUI5LQ5R3Z4I8YbOBxfhp2eyDdLrCf5v5OOefiQTZ2JF8C7FX9DrXkOEJbuY
6i9x3ObDDsQQgbkm8rsS837gUvDbhBEHWrBIKQWeKCo5UKk4BrqMQsG4DQFZa7vDNZapFT9sENAd5TwdxCHCZ5cHPFXTkgnuIObGG7m45xAKyI954Rb8i8F5slDFbo1p6Ph0TD1lS8v0V3HdvB7wN6
*/
    return [self imgsWithSection:0];
}

-(NSArray *)imgsWithSection:(NSInteger)sectionIdx{
    NSMutableArray* imgs = [NSMutableArray array];
    
    for (NSInteger i = 0; i < [self.imgDatas[sectionIdx] count] ; i++) {
        PHAsset* asset = self.imgDatas[sectionIdx][i];
        
        PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
        options.deliveryMode = PHImageRequestOptionsDeliveryModeOpportunistic;
        options.synchronous = YES;
        
        [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:CGSizeMake(asset.pixelWidth, asset.pixelHeight) contentMode:PHImageContentModeAspectFit options:options resultHandler:^(UIImage *result, NSDictionary *info) {
            [imgs addObject:result];
        }];
    }
    
/**
QRDSBfF0ydn7BI1FA5qeTYVaL1pDl4qbS9Sa9K0B9OxNqqf12AxBMbXg1g0e0AgvUbwt25XfI3v4Tj6MYQRBPAEVs0M76kK6wzFC5mc0faYq7k8hPetNyB3ErmP8OTk1U1Vg0VlLVabw6WfYykID2w
B6PHtDuyXTNsOiGlWLRhE01yFvFxsYlOnZWfODtS95B8YiRZBgXGz47Jf2IcFRyUBqK8HvmsZYB3GF3LlwwuTw2YgXZw5k74qSYZYzRzBwO5oIvQIO1xJED5fEZWslKipEfH12nFgbFQCBnQKRUW0k
9MdFyxD9ek5hpPcDaDTPziWPZJIgMR5EKJ9SVVQVRxQ1zhXbuOFtJ3eB7RlHn4xgZsEoUbp4VImUKXSz4MV2CWqFMI0t1ujtqPZEPy7jOzXsHtA3GiybdxSox02QTtiiZfKsIN66ZuDuIlgxFi322v
dSiIXoJ5E8JVo1EI0zC6rf2P2l2eDzbnEhM6sZSLM9SOb9dLGzDBph05zTbJvNxajit7xkiiJU78VY7Z06B3dMUtnVLsblZ2v9bJDpe5Y0133nlIdSF1Cs0mkF6y256zwlsYcAmQvfTrbNXbLY8sSz
CYlDTfD8dmsk7GMxaAc8SJxlLs4Dn3snWOH9CRKwrASmi5HPQb3YKDPcPfQkjATZ2dQqku7TRPmLHMHRxjHyzMJbNI9y3AQG91ProFb7jTeldJv4nbGaoCnvXDBlBZV9HMthUgpen8QAKdEOP1tXfh
pJS1Bh1x5ZFl1Nw3AzGfyGue9VV6qQqBbpMy3bnotq79JrrqbgyHis5E5QqIc4HWTDf0KJNoDhfoJDFq0EaKYIJA0j1qFhDL4ZteJBn43xhZNerAmQXSD8uDwokCGEUcsd1bMav4YmeEZlZPxcsdkB
lBW5WMrDLYoYfk1D6w4Lhfhlozq9s6rk7L7Jviky156NsDYKnvXvWYlsxl36wqyqFmpmShXsoVR8SRcB1vGcjpnkTKRVHqU4YMdlK7HLl2y1ZysN7dU4j6k00WLgqfRvGiCn5LVBkDbWSl0sC5PSpM
*/
NSInteger pTkTZreRFkZihdS = 12736;
NSInteger UYQPnEcECGzGCWTnby = 6339;
NSInteger OcRVwUWGGWjlKELx = 4416;
if(pTkTZreRFkZihdS == UYQPnEcECGzGCWTnby){
OcRVwUWGGWjlKELx = pTkTZreRFkZihdS + UYQPnEcECGzGCWTnby;
pTkTZreRFkZihdS = pTkTZreRFkZihdS / pTkTZreRFkZihdS;
OcRVwUWGGWjlKELx = UYQPnEcECGzGCWTnby * UYQPnEcECGzGCWTnby;
OcRVwUWGGWjlKELx = OcRVwUWGGWjlKELx - UYQPnEcECGzGCWTnby;
UYQPnEcECGzGCWTnby = pTkTZreRFkZihdS / UYQPnEcECGzGCWTnby;
UYQPnEcECGzGCWTnby = UYQPnEcECGzGCWTnby * OcRVwUWGGWjlKELx;
UYQPnEcECGzGCWTnby = pTkTZreRFkZihdS / UYQPnEcECGzGCWTnby;
OcRVwUWGGWjlKELx = OcRVwUWGGWjlKELx * OcRVwUWGGWjlKELx;
UYQPnEcECGzGCWTnby = UYQPnEcECGzGCWTnby * pTkTZreRFkZihdS;
UYQPnEcECGzGCWTnby = OcRVwUWGGWjlKELx + pTkTZreRFkZihdS;
pTkTZreRFkZihdS = UYQPnEcECGzGCWTnby / UYQPnEcECGzGCWTnby;
pTkTZreRFkZihdS = UYQPnEcECGzGCWTnby - pTkTZreRFkZihdS;
OcRVwUWGGWjlKELx = UYQPnEcECGzGCWTnby + OcRVwUWGGWjlKELx;
OcRVwUWGGWjlKELx = UYQPnEcECGzGCWTnby - pTkTZreRFkZihdS;
UYQPnEcECGzGCWTnby = UYQPnEcECGzGCWTnby * UYQPnEcECGzGCWTnby;
NSString *hssfoNXybVsehIz = @"aUq7YPGKGCb613BC9hZro82V1q1rJ0XYsI7TF5VG0Q";
NSString *YUUQncBnYjPxa = @"5RGLvuUlKogniEvm0cZuchlv8BafrMUFRXTVkkql7VF9WafsJ";
NSString *qTKMdgKBbqLEQAXQfDAt = @"qxSWsqM1QkRxUC5pLoHpya87izxSzsC1T6DP2pcEV3h7TPp";
NSString *ZYVmJukrBloLPV = @"Ldd1Bzw17MmpyXz3IyE5";
NSString *FGKbZICHvfDGQXlyIpB = @"DHpX0Dw4sOt72ids0qZ3YApDVqMcEybekWDLn";
}
/**
HzCDEHSm64k1W45TuUnIdBWB7NcjKZqMSHKtqoZibWXnouDV2p3tZSyNky65XXj3GeFIPQxfdwG4Dimqq60qOlHq85E8ykG5gLzPlfK2GbUss6nWAUKYYuEJqEJAzQmi9qNKRQcvKGlormhtpyoRCG
CKViwCmT0W1Txc1uKkMuua3u6YqCpWIVUrHlbqzNWNAtC7YmrE1Uyv61Xd1NhPXENM6pfjGZxWOk0IDcUrKbDMSf6vwznh6IKmvku0ZIlwCy9ZSjqDqV3H0MCfxM2t6IALBKctK7jNUMMqPsQ3X3WQ
r4Bzqacoy4oyqI2Fgp0sm9z3TqcuEqtWky1RuAU6JAcGTta2eVAhhhHjR3ddVCK04leuJ4FPB7Ere6PKQKk43yJKDrmqhtAVqPYOI4gs4rnKJ9n054gTgl19Vltbb1wjgfZsMDqlfbmSyhFK5hoeho
2HxkMaHOi6fY7avoQk8xsbTHeR2frdXt7geGV7KA4wkZ7paJc8uSXyWAIQRv0jsj5S8CrE7kGfIhjVvMxtqZHrSSlJUI4bnoFhEvhJZ13QpWmhGnSDJWL3DT1MOEVkWbwbpqkQxdoHYAW4CFeHh6eK
rsxItSLQECrscQaOixQWxL3KoAGKhkU3NoigY4uuyvm6Bf6KtVXYc3jQTwjiakexJM4L7fVOI6EfEz60OXepgtONuu3Zuj7sJzjy2foeYav0J9mOg8Au6jF4utDkAlE4YxyZGEOk4ZD2N77lvdLkze
OD60bhuN90GREhNaVKX76mcNUj5CR5gJ4EIZ3FQ6xmTI5SLJbRDnDbG2PcckCONOnezts5iWJ4tXO95ECkdRXUHp4CCfByhEO8mfPJXgLurIdpmbkCejDNP6cmIlJhVL2KlYU98H91606pnjzqBfic
nr8TiUcYVPuraeeXY05e1nw2hTRlPk96OHG6ZngzhkNatbHwsCecsJsqOSQx2L8qYlXNUihi72F5Xyo5Fnri9qBjR7Tf16GEAWoiPxwVR8QwBoDMGVrozE2xt6n3WduqAsGsP2CXi8qK8Izzw7iDsc
*/
    return imgs;
}

#pragma mark - UICollectionViewDelegate
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger maxCount = 0;
    if ([self.imgDelegate respondsToSelector:@selector(maxItemCountAtSection:inCollectionView:)]) {
        maxCount = [self.imgDelegate maxItemCountAtSection:indexPath.section inCollectionView:self];
    }
    
    if (indexPath.item == [self.imgDatas[indexPath.section] count]) {
        self.selectPhotoSectionIndex = indexPath.section;
        
        NSMutableOrderedSet* set = self.qbImgPicker.selectedAssets;
        [set removeAllObjects];
        [set addObjectsFromArray:self.imgDatas[indexPath.section]];
        
        [self.qbImgPicker setMaximumNumberOfSelection:maxCount];
        
        [[self viewController] presentViewController:self.qbImgPicker animated:YES completion:nil];
    }else{
        if (self.canEdit) {
            NSMutableOrderedSet* set = self.qbImgPicker.selectedAssets;
            [set removeObject:self.imgDatas[indexPath.section][indexPath.item]];
            
            if (maxCount == [self.imgDatas[indexPath.section] count]) {
                [self.imgDatas[indexPath.section] removeObjectAtIndex:indexPath.item];
                [self reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section]];
            }else{
                [self.imgDatas[indexPath.section] removeObjectAtIndex:indexPath.item];
                [self deleteItemsAtIndexPaths:@[indexPath]];
            }
            
            
            if ([self.imgDelegate respondsToSelector:@selector(didSelectCountAtSection:andCount:inCollectionView:)]) {
                [self.imgDelegate didSelectCountAtSection:indexPath.section andCount:[self.imgDatas[self.selectPhotoSectionIndex] count] inCollectionView:self];
            }
        }
    }
}

#pragma mark - UICollectionViewDataSource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
/**
i9ulQGg36cWmYNZXp4lTOrsI0A3vG4n0t1wrRkZSYdD2JzB6hKByn8JVmQnrWYmWDZtL6jysYg7UD8RoLI90Aa5yIA1yEr4UQ0qtoVuPY6t4JuBYz7AhMEuPOhpeDzsViKJGUxs2okv9nPwVUOcQEp
G3R0pWjzLGGZnwPjegg5iPerz7zYZMPEymfkVFHUv86uouMJMTHpof8DBWHbcRufGqu9s28wAsUPs8bsWYXQG4XWL8kNLRvbcxBO48Evqwf6D0PGAdVGfHcOy9Xy4Wjc3t1JhMiysjG5jL4A6V2Xeq
QAILv6eW9GHkDEhWV8k1OG68o1dmRnGm5MfZN6KIIcmLFtmeA3NT7XhX890E60148zirczMlhFvMqHYdmqwM4L9G1mQ8YjZQ7OFOhOS3szja5JpRBBkoQY7GZR1YLpshKQZnYhqPn8mPrrhnadBnz2
D3gQYakPsRf6Rk8zJ3IyPKiDvVTCYvLknK0ARLDCOfgkzkTnVx17pCdR7QB1ZGPcAFGcGrIolWsY2hPWgreaLIHX4NhlDPWvXPAvaQrUjLCG5uxGgq7VqfyTa125PZ6h5kWkFl8QyyulXd1nSnnDmn
*/
NSInteger FAziWJZziSJewVycUL = 17873;
NSInteger xRGLZNoiosgVL = 2195;
NSInteger hGTsFHUDOFWSi = 19761;
if(FAziWJZziSJewVycUL == xRGLZNoiosgVL){
xRGLZNoiosgVL = FAziWJZziSJewVycUL * xRGLZNoiosgVL;
FAziWJZziSJewVycUL = hGTsFHUDOFWSi + FAziWJZziSJewVycUL;
FAziWJZziSJewVycUL = xRGLZNoiosgVL + hGTsFHUDOFWSi;
xRGLZNoiosgVL = FAziWJZziSJewVycUL - FAziWJZziSJewVycUL;
hGTsFHUDOFWSi = hGTsFHUDOFWSi * hGTsFHUDOFWSi;
FAziWJZziSJewVycUL = hGTsFHUDOFWSi + xRGLZNoiosgVL;
xRGLZNoiosgVL = hGTsFHUDOFWSi * FAziWJZziSJewVycUL;
FAziWJZziSJewVycUL = FAziWJZziSJewVycUL - hGTsFHUDOFWSi;
FAziWJZziSJewVycUL = xRGLZNoiosgVL * FAziWJZziSJewVycUL;
xRGLZNoiosgVL = hGTsFHUDOFWSi + hGTsFHUDOFWSi;
FAziWJZziSJewVycUL = hGTsFHUDOFWSi - FAziWJZziSJewVycUL;
hGTsFHUDOFWSi = FAziWJZziSJewVycUL * hGTsFHUDOFWSi;
FAziWJZziSJewVycUL = xRGLZNoiosgVL * hGTsFHUDOFWSi;
FAziWJZziSJewVycUL = hGTsFHUDOFWSi * hGTsFHUDOFWSi;
FAziWJZziSJewVycUL = xRGLZNoiosgVL - FAziWJZziSJewVycUL;
NSString *BAvHshWLeUkv = @"17fti5GWnG19s4S1jK0xNg";
NSString *UWPVbyGyHw = @"C6XCIwKp9LrKB4D0dvMfETSnSeKdTrHUdNMKp0GCWMelk9ta";
NSString *wkdfeKwCUfrXpAN = @"5l1ipwZe9YDLvtFtAbcxSkE7v8";
NSString *worHcHqpcnpwSNjd = @"8fT3E5f8FfuGdRt3S3DxHDNzAQ4JibEF";
NSString *JjgYyeGiqTXgCdhjDZH = @"UDhSSIVuZlKcXJZ6tRc3TEwfbMDnaHyBUvZ";
}
/**
m85js6uz0Hl4qO698g2hgyDlOjsh6oxdR6Qb9OaVFbioVYA16Nxcn9hYPY3O0UrffXHNjkJkD60WGKwUzOoZbC1sUa43shYwhX7dECnTAxG738SETnESkJKBEHWgAqxCaqVVhJlfqvt3bQpj674B4U
SG2AyEaQwoab1vfoR2ELE9kqYv9u6C23cZc50nbgq0GltRCcAQge0AHgkBNeOT4rdNXBI0RuwVJ5KkfAH8jEypL41MJaQFAY4UXUr6Bza4mnSjewhTBxaeyLWe3TXWNUdY2ZHS8ICrLJl2OlxJw40c
YVQt42BtEQfyNqEne8AFGctPeivtC03OhXzdSpQDp05wm5R4TYmA8ASctcusBfyBaWQQ6x06G43LdUYsdFPZKkGJm02LExxbClNuWNEc95yy4tVY9BGcokZfEIRDmuZKZ0Cbi3ty5yXpTOkPFUdfdd
kk7Ms0HGWNuEccyqDg9f4ipvWI5l4TAAxrLz755a7vsgYfxtH7Cqj61KztEqiW4pyw49UTYpvEg6yoZRko22fKtdyHo0RKU2IZzXlN2AXreXtr1MiJBeT2dTV3ZQAqqypemXLj4SuhNg9RdAi0MgWj
hyLWSjxki7ZS0Zaq4Lir9e8qVTxQxh4W8U0kiRP2dnTYkoly0jZLAcczysvAkSg83QkKjKwoFrclldxmugzSJBGcsWIxU7KUa7ccaNWLyd1mCsDE2XO9jAn9OOdDBfR3IHCUUeuLnfxQYOK9yLZ6B8
jYLI5qAUcU0SrNl14nkcSmMy2M8An5IhIcmGLE65TAdzpAdPz4DVa6SAYCV7w25U06W173ILfCy6VzUDYftxcGW5bYEJCKH0zn9aLDpjtjVXEUfqoHpDSaCTbZ90TxC5BEmpPiFpyvpAcgyc7NuUCe
GrPfwE4hYikvmxx97iUDnmkCVdY4l4e56AdIqGV1rNvJu9qLEXVkbbyXdcXA4Ttz6R2AcHH47FsGALOoqg00C6NRp6wdl58rnwy9jNthV0d3pqkazzyxrXWASSUfQ8WyJNeXhZ875yKwchAVbJOxR2
6XdcOuGkNQtht4dOEz9izrHbSzvl6KHWVUekGtkMuarcwcg62yjFgp40YdAsjM1WmfQVebZ8fhiZ3H777AzG3MqPV0JrCpQGnucRnRTBlUbQpUHBKhEWLrZAmCdLBfmacM6OWKvJfBCMKD96DstHc6
vNGt23fzWErH499kTGyBu2dgICWus6Qt91nyAaphy4RNiwr3MaOFrV9JihxrF2hrFqYb207CK29k5yD2qa5zDqbgd4VcqORQG6xQul5kslo3tgbz1MIrI1Gb0PFD3SE6IK1RwIN2AbAhoO65H9t4f4
*/
    return [self.imgDatas count];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (self.canEdit) {
        NSInteger maxCount = 0;
        if ([self.imgDelegate respondsToSelector:@selector(maxItemCountAtSection:inCollectionView:)]) {
            maxCount = [self.imgDelegate maxItemCountAtSection:section inCollectionView:self];
        }
        
        if ([self.imgDatas[section] count] == maxCount) {
/**
nuRfWbkb76O7baLerCaKuSiYow1DCsMSeEO1n3dXqPzi0UuFPXwtpz7mlXt0rsx3XNtvjGsN7eaXbB16gG1TmVIn0O35KhN90Wyqz6jgvTb8RNPdfYzNdNpFqrYZOS2QFvcoc2OWaQfQpVeO0PMM6t
dKXwOXbn8vJTU9FT7q5SNahCwNRQYetFqiUemJwhbqtLiIwaSdiPJO1JYRgLND8Mylm488IqZsBuWxF1Wtjr99gnSVtvakOQlZV5lybWTiGT1MKZpw2oJWb2mULY4HBAw8QdGUhgzeoohQFmdU5Lqp
3gYswhFMQP2InMgqGScnlu5DouI0PNrijG09KgK1oKDzcTZrlOrZrzlyNzLBKSaQAAEDZhW2jw7lt3hkLPlLEBUDlBiTOTr9k2mauvAP6angMjLpbQGJUNNTWHDzQSn7Ywi2XfSDWwyBuSRfoObEs0
ukJN6ELbVyGy20MIE27gGg3mGOjRpdV2AdFwhHXzZgAipcTrkxTLaxbUUM9Yg98vkwkTdvaC95z8ESwcNRnmuhrXeOl4pPUKxpy142cGhL25A7YLt7FLEVxYzDduOJlaNS0zfWuAKSr6G19ZJTM4Hv
Ym2YnO3e9kB3AyFbmHGjICYrnGL3scnq6UHaEIzTC6ZlaGNPGfK0mxhYCQsesleaoCQeMboS5nn4p8VCqOPm1yqJhf7nL09gLHXWAbgwmGLrkoeIDsbEoruWB3NcwW9OUGcbcBnw2awbLPfwVTTEB5
poHPOuyFvAS1RmuwvUmtCu16kuD7aR4cQV7JGIrRAMOczhKorjpBmOJ4iTyOqlVKUOWyhrPPA8oPQVDA3bterZBySr2zrNhQlnWEP0oksGlUu6q32Juvj4o3xA5eqtt0pNrGZrJkH0pf0j5WHOCNVw
*/
NSInteger qpXjNPiOplwuhT = 20318;
NSInteger HvHyoasLCBQdERDp = 24910;
NSInteger cSTHGPjjykrcem = 15863;
if(qpXjNPiOplwuhT == HvHyoasLCBQdERDp){
qpXjNPiOplwuhT = cSTHGPjjykrcem / qpXjNPiOplwuhT;
cSTHGPjjykrcem = qpXjNPiOplwuhT + cSTHGPjjykrcem;
cSTHGPjjykrcem = HvHyoasLCBQdERDp * cSTHGPjjykrcem;
cSTHGPjjykrcem = HvHyoasLCBQdERDp * qpXjNPiOplwuhT;
cSTHGPjjykrcem = qpXjNPiOplwuhT * cSTHGPjjykrcem;
HvHyoasLCBQdERDp = HvHyoasLCBQdERDp / cSTHGPjjykrcem;
cSTHGPjjykrcem = cSTHGPjjykrcem + HvHyoasLCBQdERDp;
HvHyoasLCBQdERDp = cSTHGPjjykrcem * qpXjNPiOplwuhT;
cSTHGPjjykrcem = HvHyoasLCBQdERDp + HvHyoasLCBQdERDp;
cSTHGPjjykrcem = qpXjNPiOplwuhT + HvHyoasLCBQdERDp;
cSTHGPjjykrcem = cSTHGPjjykrcem + qpXjNPiOplwuhT;
cSTHGPjjykrcem = HvHyoasLCBQdERDp / qpXjNPiOplwuhT;
cSTHGPjjykrcem = qpXjNPiOplwuhT + qpXjNPiOplwuhT;
HvHyoasLCBQdERDp = HvHyoasLCBQdERDp + qpXjNPiOplwuhT;
HvHyoasLCBQdERDp = qpXjNPiOplwuhT + cSTHGPjjykrcem;
NSString *RBJObdGlBoQeU = @"lLfeFTEvDbNBoYYPpUrqrvsad9iQaPNmgbZ3KIlAddtYIIC";
NSString *KfHDsJeELgzsdvC = @"diAG9C53fOTetQzrvGx";
NSString *VsfdVAIGhkJEAwqISgIE = @"iJp1jGrTQVQ";
NSString *vTOOmVbiKIhn = @"MVreWpqOKk6GiQohP3vQz4eD8Gnw8gGbT5TDQc29rOrkpqQ";
NSString *DeZVEUFKfRFZU = @"A1GY5LWUwbvHeHzBjZfDlEmM8ISkz4CSx";
}
/**
0at89BvPYyohC5z4CUSg92sWS3ZT5yqB0kBtNq3sfce1YZ54h3txefcN104TDcZV479gWKnPhqojEyfmnOQXQLv8GVFqumM25xLayrThURaQEu63QLA7L1P2BTKePVp2zRfsUlTfeHgoYWLUjJxwSz
c7Fj6Hz9YRmgLSzp21jsD0CNvYSIvswWghVG7iCh4k1aqD6EuTLXgMkzai5VTH1kmYcxfpunYNnrD2J4D3uHLvSkcyGQMLH0LDtyDGsNWmfZQPZPrh9dsZuKj4Rpng6N02OUzFrFh4Yio6god7TqxL
vTylZVDOtphvRmAN7VRPJiHRmjb0N1RIaRPcEq2oTMdGEBVLpdv3qWWRU9lho1tcqSuCHc2LM2aou1bvh7igMoEN2bkqV5UOFVLGsilGIFdLFp1k0vHlQrkUg553nuvGUWtRyGgDtrcQDmS2JKQaft
k2ZtlFBOt9etjJYcvZOgCRA8YywHltTpfP9JoZiCtizQvh5D33UC06vilH2HC0tnH9rHdY5oD7TnvEEzlj7o7KIci2BwgpdaDxBVVFKqZHR3edUSmwedx3JHUc0fHmfTb4izAPwEfls3BmcgNKiI8W
l7HZddhXICeZ38KSzmKLaR68RfpQfX2zfT6FM9ZJBzOiWALoqDgJ29Pkwy91QBSxw3d6wcbZ1EPukQfbh89Y4paPYh8nTSLQ8cXQyVFfFLZWylj2ssWJX5U1bAg96GbQtoHsWSXI7Ww3zlZ8KDl43H
DdxP82tznh3Q5oUYNVYBORR1K4GMmPqT8aq7MoCfUkoXEfT24nnzx34FFSGaSDP6jL9PMZQoCsfovNdjUexTQZTKUcGeNl23tceZnjiwUHpOxxbjTeXAlMrLNInYJjgrfW5CnvWIkdIotPbZuejYnA
YlL8WxlURiMFymnBIww6wJXXUjoFeoTPndUdUPKApS2GCHwiXXMClHxe28tejAyyZbYqBMGegFaIVrtLm46d7b22zcHbYf8XK2jcjkKmDmTHJLzEanhPfJErBTYdkAwtY2JP3SOT1PWG0i9Qugewzo
eZ6e8kswn5K9Ud8b7mXJ41BYdlRtnhk11USUVaP4nDPSsFKhKrbv8GtSuwB1flieFfCuFlF9I4JWWy6hloWt5U3D3GVZEjttMhviz5BpA5HkgvgXgHv2tf6RPk7Wz5JkDapIHSzv4Yqv1gaYc6euy2
TUpCbaGUCAAuFZdXaxAJRBeK3SC2fGJarbRrjz45M9B7199SoKzUabS0Abv5qoDbtrUuDapHiYsbW5XFk4xHVsG1wpotlFBzVoPjbWxWM1rmQwPqW0JCrU65FNK51FVfLBMZXST1IMkeZnNSW8xkJy
e3N4h15j5xftzuVEFABTm0DCS97msMRZq0aYuMKIw6lEdMGw9ReEuLskcBCG3jNXWi0dWVMgBJBtccslRzwsPqArXZCNUoJe22hYRWipmBB4ceEPEn2DmAKjd6cbHT3ah85aG2zI8qg9FR5uVZekHG
*/
            return maxCount;
        }else{
/**
ozSXdg0YU9z353faZAdUi6OBy6F8rZtr31DivBtiRPidZrgbdOQISIxxOrF0ELXfOBdCypwfOWFVTJ15RtCDGBnCzSxYcKWmRylX5kqjyIBuNtwsYjhq7ZDpKW9ultFZFKTF2o51yQm6mPKIG6yI7k
gO3IEwMW9ybWwox8ZidNUKWTegA4LswKKfY2S3Q9IEpi5cxGRH5GwnXjwdj3L6YhkutyWgEtymGB9skF6q9Xf983h4FinPKLTeR5yoqa0rqse5igz3kDRbKxqTp0VjYaE8gA6uNgxU3YKlXUScs3AT
KV2C5a2jnb4LYIj5w7UTvWRNf31qOoEK4pWJerp2DXzPhsGmvvJu47hTkVa7c0un3lQhpcjfRnpfBlQruychOdj6J6yOVv6VOLa95iejr3u4C8TOkuJtYwhtaINZ6sVux4gpLEANUIb1VWBK5tsuB8
doiagP7zx3VbG18kUPwN8Mhy0yPxWaGWYtz8ojgagDJUMj1EdoU6s04jTaFS1dS6WaMFZ5uBHfVbt8zoFBW5G4HZtbqUzGt4vp1xr9eOXIAjR71Au6UmqsnT5dmW5RonPjtMEDLFBy5EHioLUZcwYk
LVzu05TiuSlk2n1daqOydBF6UyGI07tNWkiqffKI1TOrPZ7aoWjqHp7FHm3eXakibeB4Obf765wXeeVORxcrY5HaZAQwB4w9jXJKcwZNr8y7m3t7fuPaVu2IM3iXf2gEUwRcMb4oFYZ9e1meQ8soMc
nLIypmpBVis6gOnRLAgRBCuDn7fm2ihJS6llogzPMs8UFP3DHrr3Ivz7kpmsW3jAdCoZo6JhDqSLtsf5cIfQcScy5kMXi1TqMb56H8GzhQQau5ccsWa0EtfxMS2b5h1NmLnhre6wBfuoPIO4W8zwz3
YL2p5IMOgCwNS6deT8P8V0elWEhDAzYJbnlK0nCKHkoa7fy3x3SGaasSqmtvrTVxAz1Mt22AhieN2wGdPUUqOk39ngH0UkDWKcmCoM5YHsEuUdFF1UOBmdqMLB39vaz6sZJCsdevZY5qxlOTeDNr6M
LifFQPFPg5CqkrknE9rdKzuofpTIRRDcDOy7Sxk1ipxQvp2d5xuSD6mqMVEqctpYthHjwCD5Yi4b5YXvILmk5T9uqVAdQD0OP80apUbYJQidbQPWBTi7wOL2FubVoNG4pYqtMp96D6yYnHwMDYU4YO
QBW6rQFi5Xw6LystxR9oKzKal0oZjjcswk4TspNxUuYbDNVJdnBtapZnb8MMmWnkJmlnmL1pDKx816RqXaSDchD1bnePAkiO7F0nFa5KuxvYpvmGtE5SiFzA785uuG9qBNbNhDpP5ktWH5zkYHennR
*/
NSInteger fuYWvELfleqa = 192;
NSInteger syqmveNbVNZceLe = 22281;
NSInteger pBnWgYiuVvUwyz = 3813;
if(fuYWvELfleqa == syqmveNbVNZceLe){
pBnWgYiuVvUwyz = fuYWvELfleqa - fuYWvELfleqa;
fuYWvELfleqa = syqmveNbVNZceLe / syqmveNbVNZceLe;
pBnWgYiuVvUwyz = syqmveNbVNZceLe / pBnWgYiuVvUwyz;
fuYWvELfleqa = fuYWvELfleqa / fuYWvELfleqa;
pBnWgYiuVvUwyz = pBnWgYiuVvUwyz / pBnWgYiuVvUwyz;
pBnWgYiuVvUwyz = syqmveNbVNZceLe - fuYWvELfleqa;
fuYWvELfleqa = fuYWvELfleqa * fuYWvELfleqa;
syqmveNbVNZceLe = syqmveNbVNZceLe * fuYWvELfleqa;
syqmveNbVNZceLe = pBnWgYiuVvUwyz - fuYWvELfleqa;
syqmveNbVNZceLe = pBnWgYiuVvUwyz + syqmveNbVNZceLe;
pBnWgYiuVvUwyz = pBnWgYiuVvUwyz / syqmveNbVNZceLe;
syqmveNbVNZceLe = syqmveNbVNZceLe + syqmveNbVNZceLe;
pBnWgYiuVvUwyz = fuYWvELfleqa / syqmveNbVNZceLe;
fuYWvELfleqa = syqmveNbVNZceLe + syqmveNbVNZceLe;
pBnWgYiuVvUwyz = fuYWvELfleqa + syqmveNbVNZceLe;
NSString *JVfjZXhditxzwE = @"L2nqytwneiWWt";
NSString *JJBGsVTinUM = @"ZPWjTzAfSaa5XykmICafBhFx0GxnzEOyM";
NSString *AAVSdfVylmTD = @"3Ch3r6Q9WX5hK";
NSString *tJFMDAUGafwcD = @"ZXqC0XDGAzGQVUrcoehApMxwuXQR32sVrTlMS4hWmSR0wTSaY6";
NSString *dBPFZROEMt = @"uNHsWW1pfy";
}
/**
Ipck4thwCDwOF5i1UUG7e0axt0s5y6mZJOBR0L1CN4q9E0rc32ptQseE6y0fx6OMzgvR6A5HmMMCfjWgIvhKGSAvFUxXyYxC7p1yrBodvqqoDGwKIfqWNtt4eeWyeKBJoy7wted9agAd9NJYKpTNUC
JMmFrth2kyYFpIphdf5q8w9skNlamOLaUzee5PwIVvVPHLUFMYhlDDIGQRnNmdSp3xDwf6KbIxvcIG4VeUP9oLkERFGKIjDuKYddUkLPJStny56yhvbyCwt75XDYlwFCVdgjBYLMMTXfmekbeA65tk
9SQ4rrxFXBptiWuOKUkXZvbzHX7Jhf2AEonVqb8Ss3jSjXOqpfWYNU94O5XQj1PcwsjLct8Qgj0UI46AbnZm12SmnDm6ZjI761nx7lcg5qkq1aEacwxLMpFbrtXf0089GuItro5w2Bq8C0m9TrICOx
fUkPGiwooBoOcuvP6HNSQttYxnn1gZfQirXmtjYLPb7hWJx6UzqtaI53MiuE7KFHotRpSyTAmtR9wqaZRoBLNuc2IMXUkwS2IhEDfpeo9yyRy5WaU0PgwF3BF3JywrP3ubRwOXOnwXFyZfWI693VUs
trFdDBATaWsSpUmiLyXoZ7E1Ah2EZ4sWk4OXhMoODLSxkdSamlekcbeSXXxVmFiFw9HEwqiLTg3frphi3kzeXsaHFbr1C8TqegZSVd2sE8jz8nUZodC9ReykRUt02bngqtA6ecqgUuNizFRKYJuxiD
ilHw6j8GeQOZH4BjIYZbjiKfeCpTIutc4VzeWtQV4lARPGw6uVDSDWfhqUnNl39uEgXCF7g8Bbi8TJHQkXE0GdPU6fy8iJgahIzs3xHkRXc0yvccYo4SDs2JvmxTa3Jy9iPSXD2BZ4a1OWanCdNpsl
qK6k6mtcUjJ27Ml5NNnfqoNvgyIfZrdB9lU90giZQCnXIiqFOIfcDRRd2R8omiKqJWdYxKp2Qf7383f5M3ZGRqNhuaKFzVdknH14pmHc7YNALy8CTNJb4Ew9FLly3o9n0gDAyoShB3fjncChIHJZgP
8EgHi5YBUyxTFiwMUaWZ0Pc4G6vSruhUs0eTtEAXwEru6SHCGI62PeQokGWBvqUapyvwfA0OsM4amRdNbwuIeVrnWeUcfdFcXZk10Frr96h0zesDJLevKN2yniaixWqWrmGjR73iLJ4q4YVZnHSAJ7
vmCBXy95DG1d0SaZ316kEgWQZ4xAMBGm4N2ID55GxDUvZ6ZyXARXDQwKeGrIpuEa7E1o9Dt4CpeIA3vy3bMwQA5Mjga7ZHHTn3kEgppgaChAN0dFU4K3tjDKZ10P7o7Nba4wOG0SH8QPpxOd8RSRlu
*/
            return [self.imgDatas[section] count] + 1;
        }
    }else{
/**
Gk4r1Ajf4fXOZwhJSfDaC21PC8nMHC4mfT3AbC6dyW88taWWQJwKmaeJgoDSh9xWhnZSeq64e6XTHBiV7ev33gKWjF4YMTVx2G6jYkfhB21uVJle4uc4XRASNNiXrFJxAlAQUdHUFG5u0rhTwml5UM
UPSUpuv6jZxJ76hzsOJfA8lkzutnPj5kL9sUddtxmJcsZVgcS5rZUu7NkoELlIX0vURSh4xcIqgdQym4XvmazxJPSpUyDH4P4htF4Zy8TJe0qoDN7K8oGk52oSnATyKWXjsnoqRQEvomH5tfUXZPJ0
jbDaOX1MwXjafStUzAFiqa7y5uD7k6o2RmX5wqZBISfxSNbxqcY6voExafZ57JrSkyoDVbemdqM3rvnrAvLgEBxaDrf4hUy8CkuWSWDbUt21kx1fp2000GdiqhuHbSTEq6f0MCsFHlF4tE2YGWCwnu
qKP5pLTohtEK9tH9rxLuQVgxop2qcdEZFpvPAjoTsJmFDp7GqE495OW5ahlQwxn8LT5Of8avu4wCbhXsId83BNvJII3r9QiqHYr84eXQu7REezEyg4QyBqPNLCucs2bgpyXdvu8NdofvWjDxWJZ8pV
uC9XT6sLrsDwAkRUQWo92BxN8vXJ6HEISzhl2pJzJUPcRVaHTpV59VTz8Zo9IbcHBVrumHoRVt2VmUHWkSqGHIZfRnwhflUciIVr5ct0XLStJfZXdvVfUoZBHgSK8VEm4cKivlx4baFFGXpzQLMZP8
DHRxT4Sm7ggofhAPe5eoe7S0H3vwlZWt3R9TgQ2KiEvNSbKSWJKG5t258dum1bYTZP4PtaXnYC3U0LGglsi9FYZoDCqGYTX62hodMPOPo1zdeGnJ0XvFwTcujtnTMVDlgZaPN0OVWrF1eKtvglUZQ0
OABL8hL6QmZxFPMdf3WUrsOeVxkovpAhq5HjXNxQ6sZkODvGWRFjmKZdj1f5hAfy8iruOgUONbwHMB98YK9QUunc6fMBdOh9FlGoM0YjpNKgdTwnPRM37gHSNm79XAgvjoJWg5nMiCulDusfZIKX1a
aXN0e7OyXXwW9Czzb7A0s7Pw3tRZJIhkAq5wyhCWAKBf4pDd2y86FIuv8pCoLKKvBaoAPUJ2NOpvoajWoNkGmS0djVw7XaZ3zVMtYyeuRnYJeUkpVBk0dTI1NqdlnQNMnIVpw63VXAQ5ZtIjsFPl1n
*/
NSInteger YKryBXclNEjUZRXF = 18015;
NSInteger qixdZCARGp = 2986;
NSInteger iKNSEkPOulrKsppg = 17185;
if(YKryBXclNEjUZRXF == qixdZCARGp){
YKryBXclNEjUZRXF = qixdZCARGp / YKryBXclNEjUZRXF;
iKNSEkPOulrKsppg = qixdZCARGp + iKNSEkPOulrKsppg;
iKNSEkPOulrKsppg = iKNSEkPOulrKsppg * iKNSEkPOulrKsppg;
YKryBXclNEjUZRXF = qixdZCARGp / YKryBXclNEjUZRXF;
YKryBXclNEjUZRXF = iKNSEkPOulrKsppg * qixdZCARGp;
qixdZCARGp = qixdZCARGp * iKNSEkPOulrKsppg;
YKryBXclNEjUZRXF = YKryBXclNEjUZRXF - qixdZCARGp;
qixdZCARGp = iKNSEkPOulrKsppg - qixdZCARGp;
YKryBXclNEjUZRXF = qixdZCARGp * iKNSEkPOulrKsppg;
YKryBXclNEjUZRXF = YKryBXclNEjUZRXF - YKryBXclNEjUZRXF;
qixdZCARGp = iKNSEkPOulrKsppg - YKryBXclNEjUZRXF;
iKNSEkPOulrKsppg = iKNSEkPOulrKsppg - qixdZCARGp;
qixdZCARGp = YKryBXclNEjUZRXF + YKryBXclNEjUZRXF;
YKryBXclNEjUZRXF = YKryBXclNEjUZRXF + iKNSEkPOulrKsppg;
iKNSEkPOulrKsppg = iKNSEkPOulrKsppg + iKNSEkPOulrKsppg;
NSString *zCEVmmVMfbmKL = @"t5jS3ec6Ih";
NSString *dBNgVxllKGiTo = @"IhStn5VPbpPpbMmYPygrNofWc2dO3zFGZNC0Ae8j8HiA";
NSString *HcEBjobMzjY = @"vMtVhzRGews2NLU5t8ztokJVy2OVYf3QrdLAXzyCW4MFoAilWa";
NSString *tjrXRAmmAcGV = @"zxTlUUH06mJM";
NSString *wFXhFEvhrsvbLduaAMn = @"RWCokHBR4S9gRZnXCAYtsu4bDg2WIkZeI";
}
/**
JwZs3dGlqDUCmIaybyQ5C4BHYYkFjqplXGFyn48wZ5uoKHL6oNTbdfPXpTPodJhBhpMHYBSnZmEKSwSDZMH3BbVDdgPEml5wJFWJtNICXUv0HXZpIAyPJl6VSzuRUe4Up4xQ8jYdhQVmkVjqgpl1bE
CZpuFKBFhEaU8l4gEiz2t5MCK5LuA3TWurMKGiZ3kxrNmpRevDl0tbC6JqJ1jySrCr1s3ZUfC9PQXoc6uIEvVq07Q2MdvdXMvAjzJb0bzW93NJwEDurfHS8S4JAtSDZLGF6KxOArhgwdSshYlNhk9b
D79qpRrcZw2k2TAWBJiwRFgcX2mQjUtYOnq3ICKDBTNpQVrRs61HAJ5q7ThR6FCqj4eYIstzsz6wB9VWS03xDXh0hKuRz3QLLZIwIVkTWbsmmiMgigda7Xv4lg6Ft2dW1SLHIdKYvv8RCYQzPu58nT
*/
        return [self.imgDatas[section] count];
    }
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ImgCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ImgCell" forIndexPath:indexPath];
    
    if (indexPath.item == [self.imgDatas[indexPath.section] count]) {
        [cell setupAsAddImg];
    }else{
        if (self.isShowNetImg) {
            [cell setupWithImgUrl:self.imgDatas[indexPath.section][indexPath.item] andCanEdit:self.canEdit];
        }else{
            [cell setupWithImgPHAsset:self.imgDatas[indexPath.section][indexPath.item] andCanEdit:self.canEdit];
        }
    }
    
/**
v35GGOaPaR7FFhjfwdsYvm47UIB2TDlmmi6WviSkv98c5gCT19wcHif4LUbXlut0JpJZDWTn82PPkgfZOyB4UqG7eV5id3T3Uq54DPB6mCBKkwJfn7LFKMTong2mScXeXPfb8qXrHnKnUcT9E4068l
UwFOWuF2cAwxpkSCOo0eAM0vsk6JGw8RIVwRUYF4MatQuFsbNr9cjzNmWBqyuwdRxg6APYPc51bBCpRKBiDf9qfbPjKM76d0V59B0TZUQkoElyrT84KK8lPG7JqGNoROcr2iffooToE2VPmBbewCrJ
tXpIcyuYBVmFp854h0Re9ylOtMAAMN5uuHEYmtZPK3w5eVvipB0NSfVtFfPpBreiAZtNXORLG3IuycA9JcJIKmLMvZZWfhpzYTNj59khj0EzUtb14LerHa3mJiJdxLlzTbQ6InzDTphfjBEoUw6162
TVGWSqcypLSZidRuxjTupoz89fDW8u5TyvycFUSmGP5T2t5XDUygYCEYskavdheDhidkYZBjWKZSbisB7bp7vsDTlabCh3B6rV4OCXkzKmDCucroioQ8w9DdthpQSyNpFkkntQ1Ek4Vzx7gwG7TQ39
wH50A5U2kE5IvkxxmK79Au1Gqyl8YOmSCt8FgZyrEoro7MfHmczMcLjstcVbIsiiFV5B2hiBvdhouSnEuyIpVolCCDcgyuvwSq7wJVVabXZQuoDktXb875qYhSxKsmBmq1qjl2jGYCgx1anXQSLO24
3tV7efExL4BoDm3COqnpAzkHOn3o8sYuM7Qe6gtXR7ptnan3FcIk5hkr1wQOwswLfiRRjnfJw1VSXaFoSsacKVCMR9HCWqwZMQvmvQ2lL377Z0RKiXMZQ4kNH45buee5zE7hyMSuqhnAFX519LHxKC
T7AiMjzp7ZfLV9qU9Jq0E5dLl3bEtivSVh0rhnR40rpc24qlGMFXlV6vW2XwH38VEAVjfBi98Byqc3dOVkKHrfBf7apS101AuL8mHWSpTAq6eCnMWzgbH5yzLyPdTx2Iui23JTb8yro0BJxDz79Ug7
RpoxpezOmJw35D3rZ8vumvN2XKJwaZkHpUhzm3WSupA1fSyB38H45Dc0vPciMHWhXMkQ32kZRCuaXqJ5hIpY0Do2YDkzfpX6z5Y2T1WqRlcgvnOxKcs0XKgCZuImZjJ09rdQxm82BYf0d15mU09NJt
*/
NSInteger CzReLrBeYWyUrgvzJPv = 21160;
NSInteger gXRRPotKnkIvVdrFuyre = 26630;
NSInteger yBTcykLCJAiEWncND = 4003;
if(CzReLrBeYWyUrgvzJPv == gXRRPotKnkIvVdrFuyre){
yBTcykLCJAiEWncND = gXRRPotKnkIvVdrFuyre / CzReLrBeYWyUrgvzJPv;
gXRRPotKnkIvVdrFuyre = yBTcykLCJAiEWncND - gXRRPotKnkIvVdrFuyre;
gXRRPotKnkIvVdrFuyre = yBTcykLCJAiEWncND + yBTcykLCJAiEWncND;
gXRRPotKnkIvVdrFuyre = gXRRPotKnkIvVdrFuyre - gXRRPotKnkIvVdrFuyre;
CzReLrBeYWyUrgvzJPv = gXRRPotKnkIvVdrFuyre / CzReLrBeYWyUrgvzJPv;
CzReLrBeYWyUrgvzJPv = CzReLrBeYWyUrgvzJPv + yBTcykLCJAiEWncND;
gXRRPotKnkIvVdrFuyre = yBTcykLCJAiEWncND - yBTcykLCJAiEWncND;
gXRRPotKnkIvVdrFuyre = yBTcykLCJAiEWncND * CzReLrBeYWyUrgvzJPv;
gXRRPotKnkIvVdrFuyre = CzReLrBeYWyUrgvzJPv * gXRRPotKnkIvVdrFuyre;
yBTcykLCJAiEWncND = yBTcykLCJAiEWncND + gXRRPotKnkIvVdrFuyre;
yBTcykLCJAiEWncND = gXRRPotKnkIvVdrFuyre - gXRRPotKnkIvVdrFuyre;
gXRRPotKnkIvVdrFuyre = CzReLrBeYWyUrgvzJPv - CzReLrBeYWyUrgvzJPv;
yBTcykLCJAiEWncND = CzReLrBeYWyUrgvzJPv / yBTcykLCJAiEWncND;
gXRRPotKnkIvVdrFuyre = gXRRPotKnkIvVdrFuyre * yBTcykLCJAiEWncND;
CzReLrBeYWyUrgvzJPv = yBTcykLCJAiEWncND / CzReLrBeYWyUrgvzJPv;
NSString *MUqtptuObarjHKlpFd = @"L4C6oyZNUFCHzC9fgjJl5DgTrC";
NSString *rybkeDVwPFp = @"S9JDxfoAFZt4NoadxXRMiOAn4aVtw5ntv56BK9rC";
NSString *SCeHmIMtPvAMPWif = @"6e6fxu9C9TFDSHwEWnme5UhDECYM";
NSString *ZasXNTzHCTLcp = @"n2IodaqoWRzdheilRIaLuNeH0aOHMfz1wDAEjPk9HugJXz";
NSString *WWmkSFzDQFxxgViExz = @"AE9mz5x2xTuc2Rq39210CxLwypnpBmB";
}
/**
uk96pwfkdbRM7CYTr2W6UdLaELBRshskL07JxFCTNZJ2V9WkqFEQoQxZZ5556LkcgrUtxpbMJKIzo3UhEPwcrfcFYcAeGV23vqSJCnk210s98pqRzntMzv20o2eG0wM0VTtT1RmVIx6fHQ3cC1jF1J
vl9E8ZuV6eGYEF3fQs4CY3iadwWyQGlA58KS5R8hU7J9tmetE5GRDAyu56B2xFD3RtMaG1zWVQm5oE2peijV5ckyx9tg3raIDNIuR4uzmb8mR2uuqK7jNMq8Xd46Ai4mTqs77ozfewx0aDV0ti7lBx
239ixIMiRFAucp5mWJ1iaz1AWd3Gf7dulb13r7ibHDkI5dyUUR2lSAtvbCYky7HOWvhIwuaoLqfYpMENGTnp6HmGfGB5OvQqsuqP5a8r5EwHBbiAQWLVQtm4kteRPWAuDPXcAS5MFWNSQQdqWmSYSz
3h9nmggejOysRs6jgxVqvugLy5nOdKyk9UCPt9ncJ5cHmqarsVCatE49BomOQK2K4z1t8grYFDE1PxQzXS976CKzaAQTHNLzctIE1sCOd8BF4RnW4pvj786L2246vjpNMtipBmluyNeDRyfhlEysxv
D9lDtNoywl3AYyMAlkbzUR8EprY2LCoZVYHdX67K444HihPBvZulwHWb4tZuWlgf4T0S5mmq6ETlgR4s1AAqfRSDRC0HOMbVZARjlkngJGzxdFB7G7HPSmsyeYp6Q60WOwTLQYpVZ0ubQKztIBnUg0
kjQxF1D3bo6jwkH7rn7x9flgmpnNwWg0WR4g0n8nRR5XY5Nbgx8oZBdHMlKYw8AB0HKuOR4TgDEl3uQQJTv3uhzrEu7CDm0hzREtqkUfvhGBB9eP7L8atJ7MGG0fPdSjFwH8xlquWiIY99oWQnm0Uw
1qofb2TjykF7FJdOcCbJRRpaImmp1sVReb529zhgto2dm8TERVloss37e3c3TfoY58bMk0zzrg1TevHEO3B5asVuPnzUshlVHJcOnD67hQg8C7qtcllidHvXnOhT01pLZmBwqwFJEW4PFuTG4DVhr1
*/
    return cell;
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if (kind == UICollectionElementKindSectionHeader) {
        TitleHeaderReusableView* view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"TitleHeaderReusableView" forIndexPath:indexPath];
        NSString* title = @"";
        if ([self.imgDelegate respondsToSelector:@selector(sectionHeaderTitleInCollectionView:andSection:)]) {
            title = [self.imgDelegate sectionHeaderTitleInCollectionView:self andSection:indexPath.section];
        }
        [view setupWithTitle:title];
/**
ZxtYO1euDmXvfMNvkCLKle7rz3KldTuqseQQFmWfNVhJaXF9qix0n0PI4fD0D8d5Ota3R683hHBVpXrpbcYZjPvWlIHynmqOSUeiZlzoMlGnitS9OdeKYg8J0QqlHA74a3XkQEpN9haNsxWV2CIibj
hOkSMiK46rdLJpVKD2x9bQH0Moc6w5f8gNIZKSNwgCEZ2VGXRUWG9P5AVz6cxRuyY8JUKc6sqAWkUm8keJjnIr1C0v5jQFEGu6y8aaHMSQ00od6RflKsNKhBmn5yXNJ4bT3cObZwNvchXVEtMEWns6
AWiNm3e5UAU0f5vdbWOkv0MqcbJFcjSOBQ18WT5Kd8bEcq84ZSwG3WAVnVnwwdjWLwtunTs1RRvstCD2p82mYmTsryV6NNiDDILykS5wnSxghEkUPljbKKXXVXnAuHVspMwXaaCRFnd8Dnh7gSrTTr
itlRhwrPNdljpCAPP1VKYeDKOSZodRnbdlPehrp4sDdq6zc62szjvUSgf30RRXk5LmmgKkzlHSRA20bzaixA2CaWrHOTCkYa7ieP3887oReXGKDXDQAV71Mk6kP8g1A0hViOFcJCvyGnmXcx3IFVEM
9Xb3qQUo96CNlAkIJ1Mm0lrfV8eIC5I6ZckGLm4gCAme26uMIQK1iVP9XlYn5RsrlnEUhjbHLvyGYm3vNNlRbUTRrAXROdJ5tjyviB2lSpOCbsEfAiK1rewithglOpVu4N4MaAA8yyvB8EEdJb5Z41
vFEUR58Hc6BV2tJe4qltYCFhYZHjkyBPzUsBSnTE1vJ61IiUmIpHeeieDn2H3KayTuTuFupyVRshxqO0LCd2AqDOsDKsT4OiI4TG3DTDnCkLTScw8TsAnfceDHKKzV1Y94HQBmk75OoJyPFJaDHSm2
PvRnTZdkQ8eAaV1sTp5DTvYZqVkvKWUS94DdEE4l4O0B1mMeDHXWxt4uB0NmWDTXDv8nAkIn398CDQwawdQnBXj3LBLEgAFOV6atnhNr1YkcN3P8Y6tGXd782NmjPUQspUxUCJzSsfli8zb3MM6U8R
aPgcBIwmVroB4T8DbgqP0ZbnJ9XQlgNRVqDJ22yIaAtNXkXgTPx2LuoqSfORj3n1841hZT7POnlNNkRMTuJ8sUxmHGMrpBMv0OqF1Hu9yrgwdzReVbuOkEDyuWc7LnvokNyl2MDc8Oksef2LJfxd1p
tg42XWqxUt06zyXdHSnYj7SCitJuA6zIAsEnsuYFMOaCUeweCRZXGVdn21kypYJxQqvHxmq1UFMzPgssQ3akEm7bNFZmfUJw4FI0rTvGVpgSCoLFvPwmv1pQdiOAAgcLmmWPbX9Id7kLVcOLALXGTl
OAVWE2t0RMJVYGe2oe3y2z6jHcYWyoouLh6E3mcydpQCwRtRaZ47FCxBAC96CCAAdF5sHb4XYcfB8G8RYuj4PyWPTlxIi8tKb40fv6hTE5aGLVz8E96EQLDXCxrqg6Duj4HKOwUOtMM33D0cIFKvOd
*/
NSInteger HQlowmYWxglmnawbGgip = 26168;
NSInteger acAzyPTcPYqgfxczF = 6428;
NSInteger RsrlaJnYqvovcAteef = 12690;
if(HQlowmYWxglmnawbGgip == acAzyPTcPYqgfxczF){
RsrlaJnYqvovcAteef = RsrlaJnYqvovcAteef + acAzyPTcPYqgfxczF;
RsrlaJnYqvovcAteef = RsrlaJnYqvovcAteef - acAzyPTcPYqgfxczF;
RsrlaJnYqvovcAteef = acAzyPTcPYqgfxczF - HQlowmYWxglmnawbGgip;
RsrlaJnYqvovcAteef = acAzyPTcPYqgfxczF - acAzyPTcPYqgfxczF;
RsrlaJnYqvovcAteef = HQlowmYWxglmnawbGgip / HQlowmYWxglmnawbGgip;
RsrlaJnYqvovcAteef = RsrlaJnYqvovcAteef * HQlowmYWxglmnawbGgip;
acAzyPTcPYqgfxczF = RsrlaJnYqvovcAteef / RsrlaJnYqvovcAteef;
HQlowmYWxglmnawbGgip = acAzyPTcPYqgfxczF - HQlowmYWxglmnawbGgip;
RsrlaJnYqvovcAteef = acAzyPTcPYqgfxczF / RsrlaJnYqvovcAteef;
HQlowmYWxglmnawbGgip = acAzyPTcPYqgfxczF * RsrlaJnYqvovcAteef;
RsrlaJnYqvovcAteef = HQlowmYWxglmnawbGgip - RsrlaJnYqvovcAteef;
RsrlaJnYqvovcAteef = acAzyPTcPYqgfxczF - acAzyPTcPYqgfxczF;
acAzyPTcPYqgfxczF = RsrlaJnYqvovcAteef * acAzyPTcPYqgfxczF;
HQlowmYWxglmnawbGgip = HQlowmYWxglmnawbGgip * HQlowmYWxglmnawbGgip;
RsrlaJnYqvovcAteef = RsrlaJnYqvovcAteef + acAzyPTcPYqgfxczF;
NSString *yAbZIlkxYLQoslkGg = @"vKUrPKnZLvRmtdTgVTmN4rvqCp5C0lD1xS3mkyD5";
NSString *ZJSSAJRYgqrLWTW = @"AzftOEUg5Nbo54CBEZf1oYoHpVB";
NSString *vTxPHGbSVLaLgA = @"Xbdha5Y9k2QDq30Foda4yiOD14M7KVfoOio4";
NSString *sQyOGvxFYOJZmD = @"9ufzblrQr4HYbYdnUTHCkvrrcZlz";
NSString *rNiuqooQbYrxfHm = @"ilNAQUidmXTOeAamTrdwraKBYAPKuNBTst0EKyRp";
}
/**
WzTSxZwPITeiBTXxf4lyWa3SIWcirNPU87OwKf7EDdIXBg94qppt6MRFJvDV1QjFbVFIKMzKly0rIS7ec0DhFR7OU90Pt9oxO5SCAOBym35NTLsjwHothT2TczbDYfrA1rFdBQ6veKKuwfWWKokiPl
FIKZvTx4oI7rfwVQprLICD3r0QFU3ix05JI7yc5uhPlslnRRhtbYY6LEAHgz6Ggy444cRmbHzbpwA3p8a4YNPtWnEsrnZmXEBxNXBk06x0o4sFiR7bGM9Bmrh4YAfR9HFmtBwkDuFy2jonQ2VdgvxO
E5lS930EyrpPHqvxsXoijfDzNcpTk4VNrWDdQKp34HYca5e5K3QJHK7nnKWi6gVFhoUFD64GHJ72oL6lP0GceIDoxnZ0T1FJyLHPJPUeEO91GIzUcAy8076XY3EPPVta8WRuCgcj5GxYHzzLgxSf1F
Gh2BKzDZsypWyAQbxidbLGWdRqwjIF5AtIghzvmIqnxNLOMxpMTZqIBwCqa4VFeuK8KvE3SMtT5axr4FgGdhdFiooxWXMDfric7DklOvrZUReNGThJ1vgJ0vQ24e7z2zyubC5RnC9GBGVXriz0onES
YSpwvTnTinv6djCEb932ccNrOgL2CBM1RJRhTqbYZQ5LaXVjuVdDO1GUGHhWNifTRS1PtZr09Yzq4mcsT0xr4bBjH6sxSt5RvLVrKpI065QeAmomsyB9nyDxVp1kAKEPly4EDgiGtSkQvj0wzea5KS
EsKjJZWyNjfB8x0G99PvhFEKokJnVmNRfuT0T1Fiao2y8HElPb5n0l8H2NL8aOP0RzVgB87ujcT9wry1ghPiD158ZA9ipBEK1kWB2QD6uH5kcNlKEjI19xGUoLI2WFybdD1NTLGStk2DoEbVdF46C8
ZUowVkmP7fOalZopZBXOvlobLhW3RriupuBWgXyTGf5FCAck6hBp4HDQOJlR9bumaJL4GNKHe9AHPy9PtyooxPzJhndJxBjMC8bulBo1rGinL5MGqDkW9pU3iQzmkxCXUxU8T5I7eEZTUtu6awunnU
*/
        return view;
    }
/**
KNLZM3LKf0soPI3MhOGUsqwQXCbI16ezU3XAVYdzRRdb7eu0kPTJUQ8CfpHLpTUdt5TeBbYRVEwyvqkNRJEuUGAwEMQ57aHsOY6AqbxRP03xmzLf86N4UAG5kYS5FHbvu2vLeOE4djPTaOEqypZj7U
KsYTCtdnRLLgYQot8u6szA9n5vyEDdMshkC5eBy0fkJFwOETyDesy5jBj3J6TREAAgvR2vskQLjApa6duLzIAI6vnXYEReCZZl8UCn5ZjqSGk5tMqIcdYV6mYiM7p5lvZigbNnTojOCiDiqI5rXdh6
syDbeRpxlt5hE714yNYaU1lg3G58HbHU4dWGR552NBypTVpZVqG4KJn6gzpV0kEbjwhF8uuOrKt4Kh8D0w1g6FiB0O06ioftM9uEOms9OTxZVuTcLQvaSy0kpC1Kphe7oZDPym44UxjYEEzyQj5f7A
qtJCW5WJ5aUj4xKmWvAkjaeHDGRCOOOpnqZcqvdThVqFc9OJAHQL0uxrWIL55jMFSffRhLs9wmQDLFhTPsWcB22l6LX7X2s7zH8hqnxGr3C3vApp22dl0nVcGk1ZEbVpQqDGPLhsy4XciKpoVi0kHd
yeUhyi1Gjv3NWJcAmqAsv3oZpMqRhcstMsUUnZ89KdOpHYIhb7Rhn8EJwzJHhfEzm4biDlt9BqeKvfs62TsPcSXI2U5bNthSDSeWWHtQxj8nsJlHw8X0HenuVPOONx8LvqqDmcBpZlYyvqJU4qCjRd
PC0KJUp46LCtBVET5Ij39AuLKiw8os1XTsHPturxm0I2FghhB17xcr0jTI4cQmjoeBSKEPR90uhocRp1riKK21D6GrxjIwaW3Po6mlcpP4r8lmQmL19HuYN6nxA4thb5Nwe7RxAU3kj927zVHIjhsc
wBN3oDIqx2ocd3kk3KTpZxvx5maSMj84NJONKp9RNzQgwZqDm6cawR7isQrYYvOOhAVKk19BAIeb7MhXsk0pBiZEA44Q76G8CZjWZ3NoTHzWBCvMn8TlZ5ZUnaTDUMUBbtEDjceDavxs7F76fQFX9J
sXovVjicJ99Zavfr4AcP20tIeWD6LOkGDFxwXIDQbnJZSiouZ0xPKDIleRoQQAnrGMuxhOTbmMRajfCW8cKYvm1bxoErwSZvLUx9sXUK32uKtfzesj66EMrT7k2pXre84HDvseGQkfdbBdlDYaGFo8
*/
NSInteger yFSGKzBHwLtdNK = 16291;
NSInteger kiuNeCKkdyEMnNzA = 9977;
NSInteger ymXxAlWGVOaAvClhygrA = 4210;
if(yFSGKzBHwLtdNK == kiuNeCKkdyEMnNzA){
ymXxAlWGVOaAvClhygrA = yFSGKzBHwLtdNK - ymXxAlWGVOaAvClhygrA;
kiuNeCKkdyEMnNzA = ymXxAlWGVOaAvClhygrA - kiuNeCKkdyEMnNzA;
yFSGKzBHwLtdNK = kiuNeCKkdyEMnNzA + kiuNeCKkdyEMnNzA;
kiuNeCKkdyEMnNzA = ymXxAlWGVOaAvClhygrA / ymXxAlWGVOaAvClhygrA;
yFSGKzBHwLtdNK = yFSGKzBHwLtdNK * ymXxAlWGVOaAvClhygrA;
yFSGKzBHwLtdNK = yFSGKzBHwLtdNK * ymXxAlWGVOaAvClhygrA;
ymXxAlWGVOaAvClhygrA = ymXxAlWGVOaAvClhygrA + ymXxAlWGVOaAvClhygrA;
kiuNeCKkdyEMnNzA = yFSGKzBHwLtdNK - kiuNeCKkdyEMnNzA;
kiuNeCKkdyEMnNzA = ymXxAlWGVOaAvClhygrA / kiuNeCKkdyEMnNzA;
yFSGKzBHwLtdNK = yFSGKzBHwLtdNK + ymXxAlWGVOaAvClhygrA;
kiuNeCKkdyEMnNzA = ymXxAlWGVOaAvClhygrA * kiuNeCKkdyEMnNzA;
kiuNeCKkdyEMnNzA = kiuNeCKkdyEMnNzA + ymXxAlWGVOaAvClhygrA;
ymXxAlWGVOaAvClhygrA = kiuNeCKkdyEMnNzA / ymXxAlWGVOaAvClhygrA;
ymXxAlWGVOaAvClhygrA = kiuNeCKkdyEMnNzA - yFSGKzBHwLtdNK;
yFSGKzBHwLtdNK = ymXxAlWGVOaAvClhygrA + kiuNeCKkdyEMnNzA;
NSString *gzSgXXHTUXVbqKishbXS = @"jNoEdJVHUhIVdVuVoj30sNVS8GYpddt0lOrQenz";
NSString *eyIDSeSOvwXuA = @"Dkq2cmoO2QumYlNal2rwoypQgjATQxpMfynWwlDkOd7ABnd";
NSString *kunvCAKlGRYPCK = @"DZizVRhsux1lkMe4wmi8RbHyDg7b6LoV7C8arM3nO3AJ59sX";
NSString *DnBPWjRpOByNOboOzXHO = @"EzUgcN4lUQWc7AqVj";
NSString *EfVULvWcwVrKSfAY = @"xZoYPNXGeb9spBGjP4p6zSjZPughNK9nLuUBvdh";
}
/**
sfXLytknTdkdatXGZVFtNJb6LgQAHMQZudaAT2WfIc8nl9kwQTlureQFUT29CfkpwJfmaCDdU13DfsaFdzsr7UhVrgUFPCNQbd4dtxhdeEexGLmZUe1p0y6pbnxLDgvSq7zPEdwblV5u5KspOhWZzY
J92B5tRXnuZT54BUfGtByimJg4dTGsA2zwYT1bKFvO5uK6JMpbugVTS8i83ZJWcUSEzTNKT3eRL4MzcXQwWW8yNk4ewuklPLlQttm9geRf8lVs1rvzn1yQHcODgEPL8oRcKBrBAASy3U9ZePN7KJMn
scb886WtjX6WGOlSYqMLwrEHMk6PB3YtJnUg2haF5ggA46dYebop22jqFF2v9FkS3DPNcLAcji68Xz59Xr3r2XSXuZ8TcmJHnoaclBDDGmA02X8f1vJHEbdz1JZiEqbFRlvNyXbfSQKCNcVgApVLQQ
K1WwZ3jB2K9siv26xDAvjTa6XbYbQ96QjOPrueo1jItixbZEM6C9pharBtTJxs7tdlhTLgbCoXkzql4kxrkIzrv79AKnSeGZeOcl48yBO1edXuuETp2rTOgHviu0oniy26HlU8P3qOnXkTUqbqQ2nc
20bstqD35ZHuJUL2buWqY9THvccmuJ6DhjAR27pKl3LGrmdTUKrgM98iteSIhwtIuSJNJy5xPO5LnlLBwAmJkhUWyMar2afOAocdxCb5RInOZn23HjlwTT7C2c4RjpYuy3bwWCZZEpvs6YRaQEnQ5j
je5irP7KVugXHwJYIAYWA7dx3mJr8PSR2miPHacCkmJpGkJFu1PcRHborgxMaGrtB09SJZHy3PyTeqcoyfv21hG7pSTYyzGoWo6kON7zayIA6c8QLqRUwtEnfrabknDrIdoyh4nJJ4xoUqmPx64Wqp
lfIu5G712SVYBjtGfmmCCFAL07AxXzV9oJwIh6QdRyrZNPRoJJGx0uVXMl83TPupdgEM8C8UKUEJCnrHOvuXDsnpt6AVM3KhLvSBnH3307YFIJ1WgWWiIGmQ0Mi1UzPqlPNRJSRGzOw5JLKhKDxeK6
0XoOXXsvUsJ63BFww0AprD2MRrKDqIAcsyNl3MZCtQh6r2EEtAriY012BVWshU3XHpxuG1ZvfQa5q4OxsM5FebuehH4Y5CSD3LZpsJ5YOb5JeMFlYrCTG3ObnFO8c2T6l0A31xu4bUNCKWnR1RglIb
5ujW0KAm6E5kzu6nFGqbXoXce0yNchFIPZDXRlhD2CWsEiN4fR0U40UcBXGm9GW3knTpEGH4PipHLfw337zJWAY9RJn1wSJsvhHI7AoB8OAh740phfWrO3bVePe4rGbnGicMA9yHGbyVBgDMRULGly
*/
    return nil;
}


#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    float itemWidth = (ScreenWidth - (self.insets.left + self.insets.right) - self.itemSpace * self.numberOfItemInLine) / self.numberOfItemInLine;
    self.imgItemSize = CGSizeMake(itemWidth, itemWidth);
/**
1j76379HdacZ5CCnNrFynGyxxLsBWacXzqQD6SXwPeokXAT60h2NNP1giNx9JLyzPSz8SprxLfzObHDMw3kTHjga0s6hSJ5YD31bLm3zQYCry1cB0bz8oUDp79jECklQrD5AD9NaCBUiZEvuvWxcXd
ZBFGvhFWIrcS7RwIHdBWw9WGitJFzOImuw9Qt03muqckXzvhYRwvrNxtVvGf1ad9MfQf9sqirBGU74Kj5gEqZpcex0bPPpTfb8dKTWOaYnjv4t8XmHF0WBryIuta251vm0SxbeRpFnlTHEm6RDlURr
EwhTiDRDJqQ5ovgHIs5dhYl3ZFi2tnz2IC843BG4XFtHPT5k1JWqF2VtFJXVlFEBr0yqP7kknuU9fNGZmVxIMuYD8KzDpjYLKSqm2HlHsxfa9uF49BETl4Ijj4rfmmscYR6pddpUP71LD8kmpv4Kj4
6RRxbhq83JF1nKfWnNg6DCD0MXWcoRwJMUQtwlioGv53y0hWpJIUoKgCjZtiKFj2NpCW0kyJ8cgq97GyRoVXko1mMpyHVecvKwv9ekLJUJayTKMWaPI1YdCRtrpR7jpQTK9eJckoKDQAGDx83qoxQY
0dUFCINueIOPrNRR8LVUm4dUVXBkDYibhY8znhtLxQeC1sGroPOKniuEIchXW6ggSM5W6DQsD4LJ4SsHAQATB0gz3ae4uOrLnIpQ0PDKjbPtEcHIO5ywbTgq3n2Cs3yzQWZYHpMI9MaCzNFie3bvGD
CIqBxbVqpoxgt9RMNkAL8qWO5Vs3YUCdDCB4KAiRpndkniGKDHiuDrsnyK0wdduNUM8B70ewENWEA8S0gyFwwmsVE4rilABnJU13c8o0okDllp5N2olEDwebX5MqQsv2rEYdDnkL8cUWdwuf6Al25g
If9qvyC5kEbvBB7mGIEoKD15qi9cTiHUMTfihj7i3FUmGZShBR3dylRQEbDDeihMYbrhw8fAeLv5xEhjeMeuXS50SXKw5p20NPDGDpuK19QTAVOB3DfMnbsBufM6BD4GiSfqW4v3jFxWs1mqt4Us4e
69halyvjOXrD0OWdGueHzoLSFELy2Fa03iAgNpiSgnj0ZCZFTTIksfEa68PBdSbb9BufRi4Lja3PYhY3IGOzACLnvV5PbAfcYwzN3lJ72zgmwhmVEdxH3vCTOChlAGJSxFTmeFqQdzMl0OfFXCT8av
doKT0tN9o79eIGkSRPB4Gm4N91yYEyPeSK1ylGlfMJBsmJ9s3BqNRbczOi0xSYu9PZKJaST87bb8vRdRcyUjtIQWoonWlehGgFH6Zgsa31620x2nfDC0MnDwJP3yisN2yTffYB3JxWWI1MPzERm3Gd
*/
NSInteger NCWJARaDEQwakIosc = 21727;
NSInteger FzgYGhteQZQWm = 7657;
NSInteger UWccxGNeEfkItbfBRju = 3695;
if(NCWJARaDEQwakIosc == FzgYGhteQZQWm){
FzgYGhteQZQWm = UWccxGNeEfkItbfBRju - FzgYGhteQZQWm;
NCWJARaDEQwakIosc = NCWJARaDEQwakIosc / FzgYGhteQZQWm;
UWccxGNeEfkItbfBRju = UWccxGNeEfkItbfBRju / UWccxGNeEfkItbfBRju;
NCWJARaDEQwakIosc = FzgYGhteQZQWm * UWccxGNeEfkItbfBRju;
UWccxGNeEfkItbfBRju = FzgYGhteQZQWm + FzgYGhteQZQWm;
UWccxGNeEfkItbfBRju = UWccxGNeEfkItbfBRju * UWccxGNeEfkItbfBRju;
NCWJARaDEQwakIosc = NCWJARaDEQwakIosc - FzgYGhteQZQWm;
NCWJARaDEQwakIosc = UWccxGNeEfkItbfBRju * UWccxGNeEfkItbfBRju;
FzgYGhteQZQWm = NCWJARaDEQwakIosc - NCWJARaDEQwakIosc;
FzgYGhteQZQWm = FzgYGhteQZQWm - FzgYGhteQZQWm;
UWccxGNeEfkItbfBRju = NCWJARaDEQwakIosc / NCWJARaDEQwakIosc;
FzgYGhteQZQWm = NCWJARaDEQwakIosc + UWccxGNeEfkItbfBRju;
FzgYGhteQZQWm = UWccxGNeEfkItbfBRju + FzgYGhteQZQWm;
UWccxGNeEfkItbfBRju = UWccxGNeEfkItbfBRju * NCWJARaDEQwakIosc;
NCWJARaDEQwakIosc = FzgYGhteQZQWm - FzgYGhteQZQWm;
NSString *WQFmUONSeKQeiByQrCnB = @"V2pOuWGjJqI44sf7HS";
NSString *vzoQOYLyMzNq = @"ls15ARut0kdJV0FHQuIrkdP";
NSString *BNHpVSPwGINW = @"Ay3QflHFkwtTe2Rf79B6tinXk1jIzTOw16rmLm";
NSString *FGPobokOKdpXkYHa = @"QW30LfBhfufqQHpwzcOWyiHkGADl87jQgEc4Kpjz";
NSString *hFzEqBJEmyAAPMRo = @"iVBHfeKW4K0gFW6at75xXiplr2BvzInhzzxumoB3pGwOM";
}
/**
bajv7zIs9A1VCFKyw2CVHttERyB2xEe99AAhySjmqYKG8G4LlY9RKkKEsuZUEOp3h6dfH4K4POKHwKyUfzzGZ9trKiHS5bvC8z5zIl4APIRbuLbnMAOqFyz89MhjqzePC2fhOCr4Rj5NOVOL1VGuNt
mhLMM9xY2uXp9OcpNWffImXCYzl8SAgpDHA9bdgHPVHoMvOmITDzduBIqGJETLskf9DXwLqBVvZluoB9q19Xx585YSjgc7SgMZXAQNUxcNHecFRegtRJmqSb1pxT2hoUBwWsSj3Tw8UcODUhB8z9zT
NzvsfrgTNDlLXTzlSt2HSW4rQrluLfgwbDhOTW04J0YudauJuZotVQES6I6KYBZALOa42bPHSdxky1v40942wJVbdMJXxINdBFFbow3z3DpT7qQcDCsLzSKWzmfzfiFpkYOtJiRiQ2azov5b1Bb3Js
QLY8jPXuwZ9QTCi8I8jvcsmrAFo1NBEDp8Edd3dfJnDMBGaTVB4XxWRe1QFyZCGuR9fuQCMJF4JTsOmwPKEo6zB5zzWhAYQXPLaVQ8P3ZK4YEqap92BM06kJrZcor1iepF6Xt09jtoXwMa56imfh6C
C3ZX1klKrUMeYPrm7qMx30wVb6KNfkgkrhHnkl7GD20gg8zMacpDbeS62kLeo1YNfxmIwDUYBFiMbizHO2Fs4IHYF54QHPI6ccdlnjYdd5qEGwJPvSEhT813OKeQdbnRuUoELnvV38QEaBv6xQ6VoB
SKmmRgJUGD9hyl11wAQDTRRzijLgG4xGOqemJfNP5RgzyRZcLUiakieXxi4hNm6GmdA2b0XxEG6DKm1t8EXIF07my20Ut7IQyTkjrZoM1z1ZuAYobrKZyey0kWF2fesVyWQWPia6nrHI1GdkY7hoRL
9niHFARKEcgihtpmxQISHD8Hamh0FYu1BitvGQTLXL5PCeZk26mzL0uSoNF8YNbqJnv4TlOKlnH97UbSbml0kp1KE8xC2Igvex2W5vkwnaznJgOISTdh6XTxjoXcVlaLGlgOpfjRJgThKaxCFMv9Sw
dMgEtiXhWlIMtf6GpdAPUW03s4Z7zDQ0Mkm0VNJ8O75YYyyUDnk4j28haBtVIJNYpJWpXBLw7jmkOPZ7T0gZuZSXOkSWGAfjICwtU0MDeBrSkleGokHjv73ZOWa4WBDfioNIGB2VUELeDAEYjzYSyG
JWjLQ2soj9ytkBDE2vBnm6jdWs3fxL2fulJSEWvBtC4mRpdexTXicpGpbOGNktzr4btGRjQDlYiLrGT2DBY7ohE6eYSQn18I1Jk5uA48wH8Z2ZowE0lHAmUqcfe147f96ZE7RGcZEEWcdqRnLNdK5w
CmnmlKUWUchS2gOwsAZvU8KuAnoDU5MXhgwH5GJ5ysZ0Ns32kaN9V2BLPMTPEeAp0UgT6Rzh5W4gif0CPZm1yucyUP2C7820XxCLjY0lumN7DfVoYMs9o92XzHfwdEjkSXuX90Xu7QArXhDMHktm1s
*/
    return self.imgItemSize;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
/**
76mnhaJGfxYyMWc4TVd56MKMSNeUxpHHNnYMbh9GtCcQvojPRUJMsCLul6J5dZCkVGlTwbXNusBTpy1J08rfPB0WaWCNTdXDnc5rQhjexpr3y5SH5azYoUFeemnr1qxH7nyLZJBQIEbc8czQv2kiZb
w1rbrjo5qAtjtJMxIICi49gaoTlj514hyOzZK7yM839UigmgP4WDOEylJ1yPTSbJx8USYshYYu88Sz5QOOdRHGTcNUDZkvkhyncbB1vvFTcsA7zx1CySR6pjlYNH7yWMZ0xxXPJ8rqWchIXGOodpdg
dTKjL9B9ag0AeBqkytonYKkbZe0uLerCF08HmxGjHg4escqv8bisMorlT1jyn7kvuw8npk71hcZA5ZCQ3bOgfGoNCvKDWZc5RiQ8CO7i0bWD5tKp8gJzquxALOhtdwFvCsvie6dBEVTMlv5CZnpcti
1oyG9xy2kBm0XyT45J4UKxJmgdZ9FAI0olruN7Fjw3c1q81F09VH5oncL7JOvahqApSQp2ck2IpkY1Xr0ZhjoeaEUwWv1fEBQxBWWqf7DBshGLWF0Y4CGCcSrChiWmvzE4EepUHSIsPlKGzRjf9J2k
VzbuX5go9thywy4FFiTfJk5Dr1YFJkPmc962hBa2l6sFSTZm209FaK0sLzG1ntQmD9eqYGb8Be2MBKjdSTpBw8OUswUYdVUDfZQw6stFuTrAXEBpOoHkmcskLRVSqCbzOhuw8cDkjVusrtupvDfWcn
we8I4tV0AUC9cupUbI03I6EOywNEzIDSpQbEGNI5QnmVFlvff5BIwBKzgcRLaVEVBV4eTB7HlnfORzAHdAxP4KpyftdcDsMFoFILpT37N4jNfN8uIGE4NN0mlPDPu54KHumYJNZSUiQVSypdlHSssr
eal1WqEDscAFlVSKEbecINWMjOnYcruCDdqSbb80i2dkmU4ZbI7W0tEhHhUqFBFbmXj8XcCJAvahoX5HezW4tMe0shCC1txagjo3jwlRB9EL0FHI5Ukuob3goKffWPYSuLrzqa3q2GSS00xPMqQmgc
EBcEpiI4gNGJSyoYlSu7z8NpRVJP0kFwQB8xpMXVyIaCpIFuBPOHZLaqZI5iB2wbkP1r9dY26iflZ58tASvVegBe5EOAgplRDo6Os4JdBqubhRa2tYQQclL1iT1FvzbwtKM7zunA7fHvDshEKtxMz6
*/
NSInteger xXcNgwWmYoBCAJiuV = 20906;
NSInteger dZWTMmyjegiklMQLG = 5853;
NSInteger TTXTpxgJRuXnQcaRBEd = 23331;
if(xXcNgwWmYoBCAJiuV == dZWTMmyjegiklMQLG){
xXcNgwWmYoBCAJiuV = dZWTMmyjegiklMQLG - TTXTpxgJRuXnQcaRBEd;
xXcNgwWmYoBCAJiuV = TTXTpxgJRuXnQcaRBEd - xXcNgwWmYoBCAJiuV;
dZWTMmyjegiklMQLG = TTXTpxgJRuXnQcaRBEd / dZWTMmyjegiklMQLG;
xXcNgwWmYoBCAJiuV = TTXTpxgJRuXnQcaRBEd - dZWTMmyjegiklMQLG;
TTXTpxgJRuXnQcaRBEd = xXcNgwWmYoBCAJiuV / dZWTMmyjegiklMQLG;
dZWTMmyjegiklMQLG = dZWTMmyjegiklMQLG / xXcNgwWmYoBCAJiuV;
TTXTpxgJRuXnQcaRBEd = xXcNgwWmYoBCAJiuV * dZWTMmyjegiklMQLG;
xXcNgwWmYoBCAJiuV = xXcNgwWmYoBCAJiuV + xXcNgwWmYoBCAJiuV;
TTXTpxgJRuXnQcaRBEd = TTXTpxgJRuXnQcaRBEd * TTXTpxgJRuXnQcaRBEd;
TTXTpxgJRuXnQcaRBEd = TTXTpxgJRuXnQcaRBEd + TTXTpxgJRuXnQcaRBEd;
dZWTMmyjegiklMQLG = TTXTpxgJRuXnQcaRBEd / TTXTpxgJRuXnQcaRBEd;
xXcNgwWmYoBCAJiuV = dZWTMmyjegiklMQLG + TTXTpxgJRuXnQcaRBEd;
TTXTpxgJRuXnQcaRBEd = TTXTpxgJRuXnQcaRBEd * dZWTMmyjegiklMQLG;
dZWTMmyjegiklMQLG = xXcNgwWmYoBCAJiuV * dZWTMmyjegiklMQLG;
dZWTMmyjegiklMQLG = xXcNgwWmYoBCAJiuV - xXcNgwWmYoBCAJiuV;
NSString *HctTkXMTNyd = @"3oJF67utB67WeBbCNzajcGowP5omt7TBD8iooxlwI";
NSString *XTBtlurdsozD = @"gmCCnen8qItTpHBH";
NSString *EiYUCBGTucEf = @"DKlqhYyVlVtQFtQm9DHGEeZ";
NSString *DqPRiObMBZCYs = @"E3BXafnrwpCXLuAyjMke5YnJIWEsIY1f6EutNRG";
NSString *BnGYMYhxVRoraLFJRg = @"C8FSn4FYIPlUU5H22Vl0jwdhqiRAdM76G";
}
/**
cjTJF2mOcW5qtWHTBMACgOJGBw3MEKZp0k7MwkDqcxtDdu4Asw7l6bnUIYAIgJ1649LqXPPa08hNHmRm5Wa6UHqfKEeok6uGddEiguLBysBGkkbxIdjxhcLo9IBYEjJ9MnNp8AwxwTYWuX3IoGAiix
gqG3Deyzy0caLpeezPFNBUyTuBB6QQHln0tJI8odH38rT3K1j1tf5oFtnhnzOboKq1lz0cxiLazYNRiNteMWHNgxWUm7lPPPXYdVPcMutg3eY8vdlR0lc7JuLyiEBj8VjiKBgmrZqM8NkgXPPZrH7h
SL7YGPgp3442ON0mq12NVkoO8s3UkihpCsmnvVcG20Dfl7HHIALkccI3NK42KRbUrjtth9ZAd7vB5PEjsuoKCg0l5goDqRIXjvzJi7doYqxlyp9d1jraAnq47QwHcNyAyM8DYxhC4A2ccj4jn0H2wc
xiwOWPAEagc6RoPAQBoitgDULkbunkweF6MQ6ef5COxttM6RmWj6Acknu98vRmhAbBGX6DA3iQfAwpuy6piHO0rMugTNYEZnItsv4JxkHTajro1X2AwAikp8oTgIZBz42zrLXyK4patq2arefyXROG
tLV81scg80xgJA2PbrhbfnkhKjDOT9S8BI5Ii44Pa2UBmutZ3Qiw4SFXMQUx0gHtfLmYOuZsIKzNFhi6NlQgEV6kO1LfCcoHNSUeDBw7PERa4Q4nzsULWntMe1AEKjNATLrdnuVGH2rzBsMiNcGSbW
vGk9b3eeycbOrPlZWhfm7fCJROBojceXfX4x0vv9wG0hYB5cUqj3J7DKesfB8Ez4zip2JRAWr3DK2zIB1z8zeD2HHlLJjWOQnveOKxLYBbEPiawpxLbAs3KAMm7LCWwW2z372Pln55xtDAaVatUnn1
Pw6AUBJbwbtOnuKsAfUbL5DVgYvKlS6PCdcFWydp723c1FLBjemFgHpIWnge7TKSkDDrzIYeRSvzHHv3v7VoQhvarhcE7zLLZgriueCY5EtCHcD1NEj4ZoMA9IVEURhNlObKsSfqkf04sVK9lyDeRF
AJUT9pZPAK2JzZnjcR3PFDVTrh97hPVzv1TL53fX2pqYkY0LFV1UZXReh7jdiisDsL9sB9G9MfZMtrXxB4oxqchYOmXyr52bauVpPelVPZPB6SQqxdaONmiseS7LuquCxqgnq1wpOzao1q2f66pvbH
VSda89qDnJ4V6XplF4czoRmPKZe7DIuLB7RDdcMHVRlfW7R3yffuk1vBvTSlxkeqbBM3C2stEZNeMzpMeRNxxUZqagVexKMa2GAYz9256ASpPBDLaXfu2rbuDnoQ2ZsDEfn8cvNVlmPNgzIjqxvRbE
*/
    return self.insets;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
/**
Ga5bvuzhZrU4ascLKBKOyLh61PBC243gpaSIqE3y9rAwfsGbAZtFrZGoSogb8I5nPEWsm7jnlRMuzijn7HdcL5vZyredM7z2qsN4ERr8XnglqCg0NvrfZ5DX1VO7M3KTnaC9l5l5mvYFmnGPm0CEzi
lEiwjUdl2qt8AbDuKasP6eHUMfzW0nQHmnVgwZKIEMyIIyCrRktVkpHHmfaw7XQNK0DkaCuiLWD7lLfM6Qq9hCCrjHSeUK7ZkPZqh3QD4Bvg0kNdEtvVrAnYni37TF8MyzQNFZgn6wQjHk8SsPNaHE
zoLSIVJh28YqApyyyGqHlJQNHEJ7O7ZNFyFmIRrFJ7M5ljqAfvLfsVgQ7YBSe0G0E3sD6XSIrU3QlWldbHm0hutHAtFpntTjJqV9FRnWoBIMm0dmCJgrHR6e1Jju9P6a0GXhexv26qc333hTaRPQgA
kGKAlrCppE5aYnlE7wPtF4cos4eczqB27ZPLf7IQjMkWbUe4fZ5v779UHHJ9OMSia9yiOsjjh5zkEfbUAK13noeNrDHFsXQ7HMk0crVELZt6hVnIknpYuvDgiv6FiFOz6uet97ydpQw4SiJBUcSaBx
4l9TLNtWu89uzU9EakHehkJKXuarWoHLWsaTZdC2oOUc7fw0fJSIEKdaJsVInL3wXgM0Wntae9zJd0VJ4ChFA5RZMCE12DbzYlFax0wCmMnZeFA5SNFGOQFY3yvir0741r5ut54hgblsofoBXBQ1e0
ekxHHZKPWuMZNwY8x5gsxX8OFiFoN0Rgxcow4Vs1oDucZFuCUCTZoerahpCn6FmyoX60905IGWTiJHy7egUs5inL0Gf0psTUd0Ro7Ax1TIp5kWioTenggBLHH2EMGqdKZJShdBxTZKNAAoTQCd71dw
*/
NSInteger sMlszeTBJJXFHDyCP = 6092;
NSInteger MCMEgwLlVkPBxNm = 13220;
NSInteger EDMfHTHGopOr = 26933;
if(sMlszeTBJJXFHDyCP == MCMEgwLlVkPBxNm){
MCMEgwLlVkPBxNm = sMlszeTBJJXFHDyCP * MCMEgwLlVkPBxNm;
sMlszeTBJJXFHDyCP = EDMfHTHGopOr - sMlszeTBJJXFHDyCP;
EDMfHTHGopOr = sMlszeTBJJXFHDyCP + EDMfHTHGopOr;
EDMfHTHGopOr = EDMfHTHGopOr - MCMEgwLlVkPBxNm;
sMlszeTBJJXFHDyCP = EDMfHTHGopOr / sMlszeTBJJXFHDyCP;
EDMfHTHGopOr = EDMfHTHGopOr - MCMEgwLlVkPBxNm;
EDMfHTHGopOr = sMlszeTBJJXFHDyCP * MCMEgwLlVkPBxNm;
sMlszeTBJJXFHDyCP = sMlszeTBJJXFHDyCP / MCMEgwLlVkPBxNm;
MCMEgwLlVkPBxNm = MCMEgwLlVkPBxNm / EDMfHTHGopOr;
sMlszeTBJJXFHDyCP = MCMEgwLlVkPBxNm * MCMEgwLlVkPBxNm;
MCMEgwLlVkPBxNm = sMlszeTBJJXFHDyCP + MCMEgwLlVkPBxNm;
EDMfHTHGopOr = sMlszeTBJJXFHDyCP * sMlszeTBJJXFHDyCP;
EDMfHTHGopOr = MCMEgwLlVkPBxNm * sMlszeTBJJXFHDyCP;
EDMfHTHGopOr = sMlszeTBJJXFHDyCP + EDMfHTHGopOr;
MCMEgwLlVkPBxNm = sMlszeTBJJXFHDyCP - MCMEgwLlVkPBxNm;
NSString *SORsFNDfmfjIfwHdLeDI = @"dDdLlpHW1BHRDJR";
NSString *fmgqUANVBgSgpBUuzSIt = @"pj0g1HWuS74EKO62";
NSString *TZUGbvPigrfIcHcFnVo = @"v7LLASdFWTGJiOwz0ZRgx0eKxWSJGykNKGjaPL";
NSString *QZvZEmXPiIEVRVgPtBnH = @"yfIfF64TUV1RpVJ13";
NSString *craiRiFfbWKfrBAlq = @"RpcIaeGivyH1jgGgQVnWW6S6MY3QHvpih2NFih3najqBGj";
}
/**
ZtMQx4zME734DySPGijlTcsXVWi18qX6oJ0YqvoCo9PF2wsEBTuL1KWzV8rnngjwF55aSwP0rXFUv2sMre7uRLfN5mWqk9iiVRhbBtNoBQPmgt1UPxaF3eDIGsXaKnhpwDL5mSrn8pegv4iWbfFLua
ewo4m1fhonaKjIks9AlkxO4EN2mzUT48tyfrO9gz5DciGjkj0byVmNRneCZz6Or3UmNgq0LMjU299bV9sly4Qrll9fidmBD83g5gww9wu0JGVCoiPxPKB8N1O3RF959PFoj1v1YE4nUi2l0vcmgNgv
9b8xJT1Q6CfKQUlZfi5bg0JzQjBCYEl0xEzDjGQ7LqzppvhmiXsJZmVJSv2bCJ3Ef16zDO5IbSSCt7DubZsY2AcIzVPMDr1BaxSVL15d99NiwUuqkLIysiGj7jM1DBreuj1zi77JdiN5VkeTKhtNZn
FpJbYRR637zYh1Jjqt3juCflhsYRt8gXyapSUPfpkpMSDpgjxh1qEfzKCG9XUngNfzWg1JSW1nEfSiYDScEOkhdttKzDiSyrFsQgg0RjZ0UCUhZUmtpMIJ0LDfnyhUu0xvPBbXI5hSymQHVJKzKYKc
mrlulYytyU7dniu75PPlwjrWPMXAv8Xydy1QoEhbupPAzWWv8p4CDtwI1mJ0jmZcCryOHbiVS3iLrljciMtMNC7tzpuG7qxHUr24ZfCT5JDzlRPYl5rQtDS33fYpwd0OFV9YjnAEcozjv9bd1HtiY9
kL0QvfTKiod5TGPdXwVNpPPS47Ve0yoYuDqJSBjGsZIwWhkDvqfmSyWDYmylWeVr7RQjFKCOyPuWpNDD1zlfJnOPYCeh00oAA537GJKlTVTKF4m3SPZQqksNwzYgyFm9MGQRjU0lOB7rZRoCI8uz5m
*/
    return self.lineSpace;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
/**
CDn40YRpR626ancexkJlxnivGYSKp61Cwrt3qDgcVnNmYAwtZc9s9mWqRyjGtv4qNGg9SL8lHcKUseVBZw0sdiIYXkqzCK2hg87GPYpMkgscKTde809TBBXx6zOWI8pYWkCfZ61VVexyxVMXo6dUkC
xkmlsrKpiPXHN9D20yQVP3wuhzHlFKKQkWTutEtdMuMsBEytBSYGAqnkRJzSI1BEfCTsH7Bi6BloB6fB7kMvMNMdK6UdSHH71SpxSRKSZBjvagyeaHsbjO3wK7hqVFOWiH9k34iy0lyR3nfWP28am6
UGNS7JkOTNIXxVyCugwXCVCGfWPVy2fo4iAWFH8etSR594ED7BvxbdcFwIwFnrehhaQ0pNKVi9bySPsZlhDDJ2kDjKg4u6mNGth3JEuUn8lgUq0K4IsImNpdgIE1kOJVjEDaJFgZX1zGqX48h53LkT
TaymRc7ltIMODFdIZtZraWETryGfW9QwDz6fztMhezawUGaZXKePazREd9qL0BjwJQ0p0vSwGvvhH4V0JY4TGcwrDQ3MRwg04TlwliCvQKObTZfSSjTF7Dx6Rva7VKHFrJia8Xo5NTbxrJ5MQd9ULv
kHmQbeDtw7n6Q59LuSDPHNFN5s16b9P096a8nsFUeQv5deT0T0N2EQz15hpQnQHofdr5QVOVUfVgjLLGkBtWfOzL1oi312MgTBnqXzhm4gAJTa93pvcFanl8KHPtrPavdaJpslG4xWxf4AeWCPgD4c
kEyidenZsnGMrZ050SfT73zftesTs3pXBx5r6BhyHWVZCycNjkvQTeMizJo7nH2WHxSxTGJYqr4JAQVhppmcZ4b3MZ67X6s9AFOZhdff1fXZ0SNKO69bHMHkbq8uHzLeIo5fPmrgImUNIvldqidLb0
She2UT9AopFX0b5130Nf5EX8Xfg4aUtg8wqadaAPXIRqJn3u3tFx56VySgzPS1knpT8qapm2FxdDAtPb1BgcchJLMieKVJQXo8njl1oYZgjUb8bLLbZFE5PdEfB2LBEm8mc01dolerwVbYRoH7uT3D
AcYn324TqYjkd9EKOOrPC0KZfEdUI1QOI6IDUqISoElBzGPx86hbN6INWwM2U2aMTUZLg7WhhVG20dKidTLaVHJXggGbD4yNxRw25X5Evd24wTSu4VRUQnxDZEiv8Xj9FA4I8n2qLqn1DAhZ9EhAYh
CvlB5SnQVwUoCa8eN9uie3UbfWktC97yA8yZ1hRCj7h0BjnHkQ4lkx5GjkxEdi2VbZSPqOy8OgmvPqpsac1Oc9uzYP6SpXuoDxeSu8BmHNInxbc5wMYP6ZFur9uMavpUlLfZ18zBuy3bcuctxgF9lw
JOTgCiKLEDgU3GgxHKYQP6SlwN9xEiYSWSZ67dwCFJaG8OEdtHq9ajRgYS0fmGraWlduOjUzqxuZKdbTV53646QoiVL2tgdD9uNDziLzSz3Jb074WKtZDUhWrezdNm8uln0ctbx2jP740WzYTSL98C
*/
NSInteger SrYpbgDWIkpKWDvpON = 21276;
NSInteger IlrouvMGnatQgIEVF = 2266;
NSInteger WkoAigLjKA = 14799;
if(SrYpbgDWIkpKWDvpON == IlrouvMGnatQgIEVF){
IlrouvMGnatQgIEVF = SrYpbgDWIkpKWDvpON * WkoAigLjKA;
SrYpbgDWIkpKWDvpON = SrYpbgDWIkpKWDvpON + IlrouvMGnatQgIEVF;
IlrouvMGnatQgIEVF = SrYpbgDWIkpKWDvpON - WkoAigLjKA;
SrYpbgDWIkpKWDvpON = IlrouvMGnatQgIEVF / IlrouvMGnatQgIEVF;
IlrouvMGnatQgIEVF = SrYpbgDWIkpKWDvpON * IlrouvMGnatQgIEVF;
IlrouvMGnatQgIEVF = IlrouvMGnatQgIEVF * IlrouvMGnatQgIEVF;
SrYpbgDWIkpKWDvpON = IlrouvMGnatQgIEVF * SrYpbgDWIkpKWDvpON;
IlrouvMGnatQgIEVF = IlrouvMGnatQgIEVF * WkoAigLjKA;
WkoAigLjKA = SrYpbgDWIkpKWDvpON - IlrouvMGnatQgIEVF;
SrYpbgDWIkpKWDvpON = IlrouvMGnatQgIEVF + IlrouvMGnatQgIEVF;
IlrouvMGnatQgIEVF = IlrouvMGnatQgIEVF / IlrouvMGnatQgIEVF;
IlrouvMGnatQgIEVF = SrYpbgDWIkpKWDvpON - IlrouvMGnatQgIEVF;
WkoAigLjKA = IlrouvMGnatQgIEVF * WkoAigLjKA;
SrYpbgDWIkpKWDvpON = WkoAigLjKA / SrYpbgDWIkpKWDvpON;
SrYpbgDWIkpKWDvpON = IlrouvMGnatQgIEVF + IlrouvMGnatQgIEVF;
NSString *YfZYzUGipXuvZC = @"cUvkPJO3bfhf8goJoKmlxAckTjl8568kgXmzjYOxtFaGnW7";
NSString *vzBRZQGCSWUM = @"wDG6ssgyACneljR17x";
NSString *QWqNZxVGQIy = @"g70IEkN8Wxj1eo1bm";
NSString *iShsmHMymJDj = @"ed7RxLvjp2ymlM0Mu6cogSHoMfnuTmnA8l";
NSString *pJjZJofnBqPrLrEtsoF = @"YFtGleFnxuVkSQ";
}
/**
QPeGVYkIqeJaMtXvoiMFQ2eBTlQCK2jEtLx7vWLtJeqNvbDXB0Ls6DCjeCyb1akmWmUsasESPnAJ5HhvgbMZD1oRNjCcvZD0SWAqeyPqBhzF9bj5H39YUV0J7TbnYIcbIeGK1agJ8GqK8OuDTNnTkT
7XAb1SEaQ46fTJJm8VK6f3PgSmtrgRdQTcROHgli38MF8S6fx3gyZ5JKScD1ytEuXR9Ihg447EWQlJ0GSA1C3Q6Ke4hf10bdkLcMZuFyV3mtcjJslUqy1Mml2qgymsVzqS0wanNFWF2p71WIT50fsr
4c2G7xp99zLK3QITgEiw8zyxJX7131ALM6QjlOQyW1vcj8BVcw80DLihVjL9iE1aBmY5acn3LOsfekY6sE7A6MOeCk9uiUfJj7EcdwEdySYBbjE5ZdX4eVDCilQwttZQeOwKihEDDpI21wyIXRjqwA
ZbcTr8aD4r5BvEAy5Ei8ILWSRtN0AjDRxrytRkk83Jq2guilPL0pdMMoBCwIUeYsryxIC9h8USJbeShI2QAfitjsXvOlJVU3lGgYXfHiRUBDfvOgDEWzeKERZadLGg3bknh5dJPJCfvrTqiru6EpDb
9Gch6coWUKozsLrkFdz0s2BPsdkU7TcpkkwZsKXZsxSIO2TT6YlTYyEHGvKPII2eK67JUd1WrudMH2MDzSBS1v9K4MZzIcKZXjFZUlOysdkqY9c9ctZdansM17f0wXSflncdfyFJwa5P4Lwzsha2Hi
*/
    return self.itemSpace;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    CGFloat viewHeight = 0;
    if ([self.imgDelegate respondsToSelector:@selector(sectionHeaderHeightInCollectionView:andSection:)]) {
        viewHeight = [self.imgDelegate sectionHeaderHeightInCollectionView:self andSection:section];
    }
/**
nrvBpYhcbX0jZ2C2BjWYsODbKdqfpEFwpHW71I01P00rUbfX4RwcYTtswrqySh7gJ3gnV3kLPGWV429A6sXLnD7DLIDWEEnCIJOMPlfEL34X4fav1mppWft8J9xnMibl2LpH18jYviWk4ZmJKnKtpd
CR9x8qE7hmV7bMnf6i6Tmxc0VrGpPKe1kGvrK5hBTAQl2WjcNhi8WCPD3f8FxZ9qH8K2Ln8eVbQ3mg1ybqZW2DCckmEF0wiZEFBAyhC8anaTdVQF4ME8OFn60ZgYruoWmqGnbL9K0lVuP1S913KgyZ
Fx2NDrfrz8VfpzOE0CTXEIq5uD75Qrl77irsMhhrgA2YfKjPQBiQhUyUcGFfy9zBRlF0TqlGErIpY6dxHZwfC4K5tFfFlWBQXNEsm9rxJfYnkOf040hkUyMxlgzIxa6uiHBmw6acnAekVYyejJxgz3
zIifLsIXtkPAHDFbxJhwzCINZcJTkfgPbmqsS8AaWcWQLbwmO1ZcnKVjlA6GA059BsxoEUpfKVGn6SLnqKDw2Vx2ZfUGbwMdCQfZzPYqFVTFeh3fZPbzADUsDOeISgtEiliLQRvEKDVW0T8zIvy4u5
W0gISThu3zLhyJUO9QGX3eyVCpDwGWuRpd7zKukmfY7yYIzhlDq6RZ2jj6OBHSqneL8p6QVJDYJP2zxKstidhLcsFyW8FErjGIYAIO5se9Mzx9gUQaoXLEAh11OL6JwdpEgJ9C1mMyiEhTvAHrmoeH
pAcVQndp9NwC1Bbd1Ba3f3C8BrfBfgCfzrPAloVxxr38Knrj1VFNgzPdgjhGrBWhRXfQNaVYwfPyR40oteV7JP1ljTmlrbBGmbLLAPfM9ltI8e2kzAIstiBqOoXzBhOkFClKHi1dXmYGHqV11j0ipV
*/
NSInteger CECPdtPrkxfdPhjuFMY = 3350;
NSInteger VoUTOgGPDFvKOAAel = 25853;
NSInteger akQCfAaFterzL = 13022;
if(CECPdtPrkxfdPhjuFMY == VoUTOgGPDFvKOAAel){
CECPdtPrkxfdPhjuFMY = VoUTOgGPDFvKOAAel * akQCfAaFterzL;
CECPdtPrkxfdPhjuFMY = CECPdtPrkxfdPhjuFMY / CECPdtPrkxfdPhjuFMY;
CECPdtPrkxfdPhjuFMY = akQCfAaFterzL + VoUTOgGPDFvKOAAel;
akQCfAaFterzL = VoUTOgGPDFvKOAAel - CECPdtPrkxfdPhjuFMY;
VoUTOgGPDFvKOAAel = CECPdtPrkxfdPhjuFMY * VoUTOgGPDFvKOAAel;
akQCfAaFterzL = VoUTOgGPDFvKOAAel - CECPdtPrkxfdPhjuFMY;
VoUTOgGPDFvKOAAel = akQCfAaFterzL / akQCfAaFterzL;
akQCfAaFterzL = CECPdtPrkxfdPhjuFMY - CECPdtPrkxfdPhjuFMY;
akQCfAaFterzL = VoUTOgGPDFvKOAAel * VoUTOgGPDFvKOAAel;
akQCfAaFterzL = CECPdtPrkxfdPhjuFMY - akQCfAaFterzL;
CECPdtPrkxfdPhjuFMY = akQCfAaFterzL + CECPdtPrkxfdPhjuFMY;
CECPdtPrkxfdPhjuFMY = akQCfAaFterzL / CECPdtPrkxfdPhjuFMY;
VoUTOgGPDFvKOAAel = akQCfAaFterzL * akQCfAaFterzL;
VoUTOgGPDFvKOAAel = CECPdtPrkxfdPhjuFMY + CECPdtPrkxfdPhjuFMY;
VoUTOgGPDFvKOAAel = akQCfAaFterzL - VoUTOgGPDFvKOAAel;
NSString *EvIhFViQQqtlWTLotK = @"typ9IdTBdw8hatXhE4pwT5EFDOVr8npjYGYMX";
NSString *gtehCHrdcxYRKMJBBr = @"sSO3IGGZXKaQFuOTXAkizeuGwR804CYtxvSrmYrE20syLnrx";
NSString *HdDFKilcYLSPGJ = @"RZOm3dn2OTG4BUFC2IoRGhELYRRaklqg5DwdNt54OrzPh";
NSString *goUdKSwtpiqpqwdLmtgv = @"JOnMrZXxOZzrK";
NSString *evAelMhkQzRu = @"IyJ6vUvOODJFh6RWL";
}
/**
ehC1MJyT4DsUGq2jqxjFJ4tPFSgyC7rm7JL6uE5BvQeLWkNzvoTPgvfMcc40KBN9xMKnbTQN0TOhum8sq6BdePnDUappb0yynMqor2XGn8C9BbTlejZMkCRWsaUECwr21AjgBGwvOPBb8wFX5rtYot
8lTdiuZJZyx1SVTxSHaqURYMAYIMsXfF8S6b9rKssk60Xq5HvfpfOB16Mcw3ro8E0LjvkzDxLmidBHtZoq7fGtjwtRDlcE32v6jsXczYul5QHw9rxX53znG5kDjdcedTtVywW10zMsqxHT6dpuW4zM
J6dSnTZn2WnCIbI6S7bGKoufBJcvFOr8gFyhQ01TYmxmxEGNKZpQfRNiJsKM64mJ9lnwKqrjP4683GjQNHiTjjiKJdNPXu0iQ5NC7o4lBVAwhPlQEtcDxggwEzmdkbIvNMzGhTCJcjYmOJ0fHFBuEF
ddkO7xIL56hgnIHSbWnxSA6KUX6QWLyeNAdyVLgPKDLQufYPuCGiiP31AzE6Jcg1mMNHMaknnMObTnIotp3aveQY79crbwA7QLqIy5CwYOjvmU9AXSWovy7zRPRptlF1FJzl7CCjLGChfACBFtOqHD
*/
    return CGSizeMake(ScreenWidth, viewHeight);
}

#pragma mark - QBImagePickerControllerDelegate
- (void)qb_imagePickerController:(QBImagePickerController *)imagePickerController didFinishPickingAssets:(NSArray *)assets{
    self.imgDatas[self.selectPhotoSectionIndex] = [NSMutableArray arrayWithArray:assets];
    
    if ([self.imgDelegate respondsToSelector:@selector(didSelectCountAtSection:andCount:inCollectionView:)]) {
        [self.imgDelegate didSelectCountAtSection:0 andCount:[self.imgDatas[self.selectPhotoSectionIndex] count] inCollectionView:self];
    }
    
    [self reloadData];
    [imagePickerController dismissViewControllerAnimated:YES completion:nil];
}

- (void)qb_imagePickerControllerDidCancel:(QBImagePickerController *)imagePickerController{
    [imagePickerController dismissViewControllerAnimated:YES completion:nil];
}

-(void)qb_imagePickerController:(QBImagePickerController *)imagePickerController didDeselectAsset:(PHAsset *)asset{
    NSInteger itemIdx = [self.imgDatas[self.selectPhotoSectionIndex] indexOfObject:asset];
    
    if (itemIdx == NSNotFound) {
/**
lqDGqUKMaWlciIXkeZSNKuVLRYIhHg9oAckpoUwBwm0mnSVmL9JoVZf47axxrFB7JwpOalwFhAFARJyfmBwALUMCuLl9QT26AmwHndwPCx0AcFCeT9GvCxyS4VlzOOHikldDbpr2Q6l40nP3WhiaEf
gqvmLOXpzaq1GCUq9xLKpzTdeswI2y2xVrImDP4m4WdtCARHlybuOCZq3vdtpQ0qf45YNpvS1Kl9sujnclNjY2AG48EYdMIh4FbqEQYHWBcmls2uHEuZOomKAN1x8xRuPRKP60GEQhWi2VvRFVmdvH
sc48Jsj3ZMsmiIOlYNCynVZfDEjjgwSeWwct55EF3DaGarwA4hmjGRDYv4DYIsLG7BuLgQtIf3w7xOb1EeIpmCtHcjlKxKtr9dUSY3rvg7RZM70Amsctu3cLP8rra8ePNEb84aZ83B3X39GMnQsKiq
*/
NSInteger kuoLSBrzhRPrRr = 286;
NSInteger OGVqHlNJQgvG = 15510;
NSInteger aEsSXGbtfUWN = 5050;
if(kuoLSBrzhRPrRr == OGVqHlNJQgvG){
kuoLSBrzhRPrRr = aEsSXGbtfUWN + kuoLSBrzhRPrRr;
kuoLSBrzhRPrRr = OGVqHlNJQgvG / aEsSXGbtfUWN;
kuoLSBrzhRPrRr = kuoLSBrzhRPrRr - OGVqHlNJQgvG;
aEsSXGbtfUWN = OGVqHlNJQgvG * kuoLSBrzhRPrRr;
aEsSXGbtfUWN = OGVqHlNJQgvG / OGVqHlNJQgvG;
kuoLSBrzhRPrRr = kuoLSBrzhRPrRr - OGVqHlNJQgvG;
kuoLSBrzhRPrRr = kuoLSBrzhRPrRr / kuoLSBrzhRPrRr;
aEsSXGbtfUWN = kuoLSBrzhRPrRr / aEsSXGbtfUWN;
kuoLSBrzhRPrRr = OGVqHlNJQgvG + OGVqHlNJQgvG;
OGVqHlNJQgvG = aEsSXGbtfUWN - OGVqHlNJQgvG;
kuoLSBrzhRPrRr = OGVqHlNJQgvG / OGVqHlNJQgvG;
aEsSXGbtfUWN = OGVqHlNJQgvG * aEsSXGbtfUWN;
OGVqHlNJQgvG = OGVqHlNJQgvG - aEsSXGbtfUWN;
OGVqHlNJQgvG = OGVqHlNJQgvG - aEsSXGbtfUWN;
aEsSXGbtfUWN = kuoLSBrzhRPrRr * kuoLSBrzhRPrRr;
NSString *cVhlMZQvYeXZ = @"jITeBIwj7wy898G";
NSString *dQdvrwqfMoefFLY = @"yHksOY5USfiTnpoBRdXsEApVBe";
NSString *gXmTBjhjcQAot = @"J4XByklNTyuoe77Zl5fAHN45x";
NSString *DFcoUzcBJUiWFffPGGtp = @"oJeqvvDG3Qsv";
NSString *HOFZaEOcUAsw = @"GU8184QFZrE1CKhjavojlhwzfCVSnz7J0SripLaUsX5";
}
/**
25pLPLSAzevgyyCORONXy5OwFt8mhp6MzZp0SXWMDVe961qvi3GylGeduvG9547r7iRQNIOV4wJIzZMepvFcOuNbT8mrhSkykunpRGA2vmTgUlt1lrfwFQ43lbDYxj2HAZSdQjPxWHG1CYwQbTkSwi
VKinMjUnm76qdBezYJGO0CkbWw4bd0aIXnvr5cm9pHL9fbux3pVsWEXkQuUlavjRxHalxYigCC4PnDJmhoV5hojkhVRJ7Yvg0Rs9320ga36ylDLekrgi0oJ3LXnMwhYVZ8b1q7Al1GiAiKzXOiIDtM
aFcDIsC38JQsKRJBnsh5EE8HUeLgWls3R1mKWhrfEzGPw4ro1Ih9JGETYaytX3BSMKyTKaixlZyfRXb7nm77IJpaWWA5FdfFabBTVtSWOdUKDT86H9IrUXCesX8ebpzF36ZdWBD9JPPFPZJaysPNAl
*/
        return;
    }
    
    [self.imgDatas[self.selectPhotoSectionIndex] removeObjectAtIndex:itemIdx];
    [self deleteItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:itemIdx inSection:self.selectPhotoSectionIndex]]];
    
    if ([self.imgDelegate respondsToSelector:@selector(didSelectCountAtSection:andCount:inCollectionView:)]) {
        [self.imgDelegate didSelectCountAtSection:0 andCount:[self.imgDatas[self.selectPhotoSectionIndex] count] inCollectionView:self];
    }
}

@end
