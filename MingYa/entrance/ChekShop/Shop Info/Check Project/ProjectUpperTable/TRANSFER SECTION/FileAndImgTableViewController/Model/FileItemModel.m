//
//  FileItemModel.m
//  MingYa
//
//  Created by 陈必锋 on 2017/10/19.
//  Copyright © 2017年 镓洲 王. All rights reserved.
//

#import "FileItemModel.h"
#import "FileUtils.h"

static NSArray* fileSuffix;
static NSArray* fileSuffixType;

@implementation FileItemModel

-(instancetype)init{
    self = [super init];
    if (self) {
        fileSuffix = @[@".doc",@".docx",@".xls",@".xlsx",@".ppt",@".pptx",@".rar",@".pdf",@".psd",@".ai"];
        fileSuffixType = @[@{@"suffixType":@1,@"fileImg":@"icon_word2",@"fileBigImg":@"icon_word"},
                           @{@"suffixType":@1,@"fileImg":@"icon_word2",@"fileBigImg":@"icon_word"},
                           @{@"suffixType":@2,@"fileImg":@"icon_excel2",@"fileBigImg":@"icon_excel"},
                           @{@"suffixType":@2,@"fileImg":@"icon_excel2",@"fileBigImg":@"icon_excel"},
                           @{@"suffixType":@3,@"fileImg":@"icon_power2",@"fileBigImg":@"icon_power"},
                           @{@"suffixType":@3,@"fileImg":@"icon_power2",@"fileBigImg":@"icon_power"},
                           @{@"suffixType":@4,@"fileImg":@"icon_rar2",@"fileBigImg":@"icon_rar"},
                           @{@"suffixType":@5,@"fileImg":@"icon_pdf2",@"fileBigImg":@"icon_pdf"},
                           @{@"suffixType":@6,@"fileImg":@"icon_ps2",@"fileBigImg":@"icon_ps"},
                           @{@"suffixType":@7,@"fileImg":@"icon_ai2",@"fileBigImg":@"icon_ai"}];
    }
/**
9b6oawBrUfE8bn7kwzSVpTJHI9fDRczKUP9Itt9hY3LateYl0SfYd8hpjnx6u7dbxyjS8nSPAzI16KICfaSipwAxVn2UmYLxQHbL7CPm0FQFV61yKV738e313P8O1MyPHaXvkDbUGxOw7PYfDlTyYo
w2BFAAglYYBZ12nszrnWowaTjtYdhrEm9dGVICUTpznR2Uin9gHQROa0ioEheHJYj48ZTBvrfUccNFN6dYYFPwFT19DkucrSnCq1iybNrzfWnSuYFEoGsyOvyxKq0mJ6ut5Rz4FZJInDwMj6u4MI53
Ix3TkIvfEnmxEvVhOZlKM1q4pWQ8BqvgDpoRw6XPEDCAGkoV8JhlsefueZpwHpg7iGFnQflPZL3PwXgWWcEQ8ub8n9NwP8QbamDcGhM2FgI5oC1olY6o2MwAbtGwkmpG9EDLUSNwXlhowoJrUb2fad
Wj2lzMAnKUUrMQdYpGCyhxTwOeMOgOzBg9WNteAA7pvPT4hctA36uFeWILjCTB2InnnA8zi29TfQ5P00LwdQilaLu3fkhnEpCdOL1Rxss5FMeGJIYeTrteTgjeXrf73EXBTK3ABM4TVhTgFlmt8In6
Zkrgfsgb5LYVlsSskXYKGI8zyonuZ07UskJsOVUiHq13IzPOfkx9GSJ0OHKVZCU9IFA65fCdT3N5MzAaWKhDsk0QSV80z52wFRfHVMGCIXkqpZJ1iiAIluyyXXXhtDjPtyuvtShRS3nBwjo0weirtl
ZNHJtkyGoNeOX5GYxpPxnsH1BDeReIGw577ZPlWrIGPN9WVIkeyw43UDoANZh6M3s6ZeP0OVuxCah55wNuauxCYQ7GMDUrurTfjFolqsvdZ077XQvLVYWMXnHrXhn6amgZmpaiALfvYVArM2JvkhVK
*/
NSInteger VpPHaXERnnBUdpBltRKR = 5347;
NSInteger XbrowyoozLvN = 24427;
NSInteger InHsyZVbRGm = 7175;
if(VpPHaXERnnBUdpBltRKR == XbrowyoozLvN){
InHsyZVbRGm = InHsyZVbRGm - InHsyZVbRGm;
VpPHaXERnnBUdpBltRKR = VpPHaXERnnBUdpBltRKR * VpPHaXERnnBUdpBltRKR;
XbrowyoozLvN = InHsyZVbRGm / InHsyZVbRGm;
InHsyZVbRGm = XbrowyoozLvN - XbrowyoozLvN;
XbrowyoozLvN = XbrowyoozLvN / InHsyZVbRGm;
InHsyZVbRGm = InHsyZVbRGm - VpPHaXERnnBUdpBltRKR;
InHsyZVbRGm = XbrowyoozLvN + InHsyZVbRGm;
InHsyZVbRGm = XbrowyoozLvN * InHsyZVbRGm;
VpPHaXERnnBUdpBltRKR = InHsyZVbRGm - VpPHaXERnnBUdpBltRKR;
InHsyZVbRGm = XbrowyoozLvN * InHsyZVbRGm;
VpPHaXERnnBUdpBltRKR = XbrowyoozLvN - InHsyZVbRGm;
InHsyZVbRGm = InHsyZVbRGm + VpPHaXERnnBUdpBltRKR;
InHsyZVbRGm = InHsyZVbRGm * VpPHaXERnnBUdpBltRKR;
VpPHaXERnnBUdpBltRKR = XbrowyoozLvN - XbrowyoozLvN;
InHsyZVbRGm = InHsyZVbRGm - InHsyZVbRGm;
NSString *IppQGvYkdWsBZBNPiP = @"vjFKd1eUR0A6biXHUN4uG6N49e79MkkHdf3zaU";
NSString *aAAmPMcNAv = @"ZGAemDlsB4s2aFfd54yoCDxlG0KG1EQGtpO";
NSString *axgwUSrBbYiSD = @"h66IngizViCi2uJXfemZthFHTndXyos";
NSString *wrOMMbFjDEKjg = @"5CKnEMdsyToyUiNlxYjDLJc8j1EMIEdH82ymzz9s";
NSString *hfLHTwJYVsOieVoqzF = @"pDropsJXNzGX4j";
}
/**
rq7WTWhrnrnJuGGJhZ3v83KaUfzz6juzp2pQHXskWHfGjPkPxTRNXCqAgMVB5qFsQjbAqXSPrRRCH6yqSIF1dY07xNt7fkC22RRDHp5BUSuWvaoMAWaHpD8yl3AcaOY6ExL4yd4LiBNpjUWmGcLotI
zjlW4nKe2bdHaRUHeZTojeaibfNfKr4PfcLTDEJbxHGpr1zRa0UQ1tbRaITT44TRC38JxVeZwh368kMDowYFfJKAeeYOPdeDeVI18sVyREUfuUhtsjXQcDSQo71aoRHQjJ0KS21CqW4h59rUvUOfb7
V3ga6tlkXizs7ncmXNUN3vrGZaGMnXJsFi0yLsovrNAXQPUTpFhHDqKpvQLFT7xO2uN2vlPKvaG8L1q5G0t9DriWjJHFa0rhpTzfmypINLJXxzLK4mIpv8HCdBBTnxOcsxwK65GUmIlUYoFL15GIci
v2MR7dYSxRorklGHe7MIIEXQmgesuR2TScR6BxtneSKeqWjPUR2wJoo3CZzxJdCXLTKS2QM6XqfRU0b1G4dRE9Mu24xU5DrwQE69Fd4CFCQlKZE1xBzXKMEI8kpjfIBBcuj6vqJoa5ub6ODBvIbnCV
dngUpTAiuhT4r21CGpCTYNcc2cOAuv1iarXkp3UtgfGooX1c5TLD9C8mPSvD7ITU3z3lUCBxirt1oPZV06P8BNRhUMWQrnXu40n22H8JD3BVUKUe4orAbm5mYeEOXUx1CISTXcXPl7TAtiIQTBbWv9
DZ6uE50qYiWS0J7nYyR8hvbwa45qEWRzSlMU5iWgugQfQfjaM1WJgW5a86BrKRhSyI5uOiCaVlypGp4amiSk5FlrzCF8pA2slVs7JaGGWyLLm3hPqpvleijiMsf8Q7cYBJk7WZNSF0nT02Kepg7ltH
bCFRkhJH1zkj9Xm66XYtSvbAuxTktVa2vslWhNvqiDV5jLiuNdKT5JZj9ekSUcLM0hTuTMCOGH6NCrxxsrXkeuhOUt1BgDrcaTpz0uJODahc9FNJi4WEZeJhbyIMKJYBXPkzUwgd7MUJOBPmyzQski
rSx8VcKIelaAPRHlAULB3M5FSLvQKFJRpDanOyRHYd9YzofJhxyLrxT0csLfl3c5M230zztXzAW7enS1zXup7GwmN5OEdUmDJDiOr2UXsMngFFQHyFOVGTS72JQYDOU66f0gJG1N30FbueZ01yLQ1p
AVkkIlZKm6i9aIyvX4M896Y3c9KAsJk7qtFXKB0PZMZO8p2OlS4DYJJLCweZJcD1VNmAJCucDmqCX3tXElNBjDVQ5zlRLljzFlIZewv38rqeIJ0EWCuXy3CUZSNqzzV80sxP9DhJzQ90poAibtC7C9
*/
    return self;
}

+(FileItemModel *)modelWithFileName:(NSString *)fileName andFileUrl:(NSString*)url andFileSize:(float)fileSize{
    FileItemModel* model = [[FileItemModel alloc]init];
    model.fileName = fileName;
    model.fileUrl = url;
    model.fileSize = fileSize;
    model.fileType = FileTypeUnknow;
    model.fileIconImgName = @"icon_unknow2";
    model.fileIconBigImgName = @"icon_unknow";
    
    for (NSInteger i = 0; i < fileSuffix.count; i++) {
        if ([fileName containsString:fileSuffix[i]]) {
            model.fileType = [fileSuffixType[i][@"suffixType"] integerValue];
            model.fileIconImgName = fileSuffixType[i][@"fileImg"];
            model.fileIconBigImgName = fileSuffixType[i][@"fileBigImg"];
            break;
        }
    }
    
    NSString* filePath = [FileUtils filePathWithFileName:url andFileName:fileName];
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath isDirectory:false]){
        model.isFinishDownload = YES;
        model.fileLocalUrl = filePath;
        model.fileSize = [[[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:nil] fileSize];
    }else{
        model.isFinishDownload = NO;
        model.fileLocalUrl = nil;
    }
    
/**
vvgjzfXvbx1lcsslGnf9h4aXZKmVZYX9sSjGua8vE0VumHkc7dDfoR29LH4y4jxE5RpTGYr5Lrbr6or4Ah9Yx0W9zsgx5sniv36WJVa749nGVyb9goInj6cGv7tiebLFGNDTynVUnVhQtlZzuKFi3u
DkmnEZ4ZQKewcoKHACqmVlOxyaRxgMh27ig0oDibFUcz5Zm4bg0ISV42JY9gT5WsSJ7PHqW9fCMjnBoh8TmcBI6ghSqEEpwWQr9jSFiQ0avKs4caoBr1ybr6P3vuw9PRuhcj0zL2sF8Jboou8ggDeT
5cYQGrR0wehxZod6rHDDyUJe85iQrjP6bRnDrSsnyoV77W7n9IMbTAcwtEYsXCWR0OLP0ivP0EL6N5i8nqF0kSnTePXnofQ5JUY2VSCETfA04yboYHs0wBIjmMEXMqXeCR0LdjMkdMyeBsItUzK7QT
vo2H1vdYGBEVzI9nwkdil4TX5u7Uc5DUsjgAim1kl57VntuUf28BMpLrqnFh1OjkkAwWesEncvqlTqAG0FMQi9qKoU1HKURM7MwghY0yc32HTQW4kaXwBl4UDQRsFfDylm4mSqGe6oZKgS8zvaVBym
VSpVPl8X55t42KBw1hhGHy9EKEYfUJxQtwqUcSqo3H3IBb6iV6iIkXRQRzEi7iJyEGxIxI1sGmqtXsQofMfMBbwOlEmY26363VmZD7zaWmklSW8tHhqFCfrITn5PJxZUu9F4RNcmj6xuX3LrHMhZvR
*/
NSInteger ckLmiECliOPF = 15370;
NSInteger ZpJDMKxpyWhlTjYZHo = 1031;
NSInteger vttDIaiHFXmSH = 19068;
if(ckLmiECliOPF == ZpJDMKxpyWhlTjYZHo){
ZpJDMKxpyWhlTjYZHo = ZpJDMKxpyWhlTjYZHo + vttDIaiHFXmSH;
vttDIaiHFXmSH = ckLmiECliOPF - ZpJDMKxpyWhlTjYZHo;
ckLmiECliOPF = vttDIaiHFXmSH / ZpJDMKxpyWhlTjYZHo;
ZpJDMKxpyWhlTjYZHo = vttDIaiHFXmSH + vttDIaiHFXmSH;
ZpJDMKxpyWhlTjYZHo = ckLmiECliOPF / ckLmiECliOPF;
ZpJDMKxpyWhlTjYZHo = ckLmiECliOPF - ZpJDMKxpyWhlTjYZHo;
vttDIaiHFXmSH = ZpJDMKxpyWhlTjYZHo / ckLmiECliOPF;
ckLmiECliOPF = vttDIaiHFXmSH * ckLmiECliOPF;
ckLmiECliOPF = ZpJDMKxpyWhlTjYZHo + ZpJDMKxpyWhlTjYZHo;
ckLmiECliOPF = ckLmiECliOPF / ckLmiECliOPF;
ZpJDMKxpyWhlTjYZHo = vttDIaiHFXmSH + vttDIaiHFXmSH;
ZpJDMKxpyWhlTjYZHo = ckLmiECliOPF + ZpJDMKxpyWhlTjYZHo;
vttDIaiHFXmSH = ckLmiECliOPF - ZpJDMKxpyWhlTjYZHo;
ZpJDMKxpyWhlTjYZHo = ZpJDMKxpyWhlTjYZHo + ckLmiECliOPF;
ckLmiECliOPF = ckLmiECliOPF / vttDIaiHFXmSH;
NSString *SfqOMHrOsMnv = @"HXpbs5joZxREr";
NSString *NDrKhmKCXicoXG = @"081DPqN5YOXcaxfmd";
NSString *OCVuUymyYUEUXdAXiB = @"0FhJhy1w3NHWrG9aZhscDBpvNZzGx0rEwVq6q8s";
NSString *BjtXHLLhYGNLChkGC = @"UucgUjh8tjZOpsznrxYmfFtnkBki6GHOb6";
NSString *dYWTNwRcOKtrvp = @"vehRmLnWLQEqseE5eBFoBaIKe0s11kW0A62USlVu";
}
/**
pex7Js4VysGNOF34JpRdg1DbzsjK5fN4htZNC7E0m1hUqF3PvzhA64SdRnKH701O5gtwL6Xg7CJtNP4N2ftBNc1kRpohy64jANRqDV04R3ZVypcq4PrcEE4pugtummWBhHuik0fl1zYwT4yR4tTwEe
Z0WoA6PkKv6wnDeSBnRr4IgBoKc4FHbyiJnWQXaL2mYDKzxtndHfEhAUFw23gHTSyBUd4w2kQPItlBO0qTpzMRa1FkqPp85QpZXvueaoBNsBTpbwlmmYvnLGXqzLcY7x3kAntwFE24kXrTzm9ZCrgF
qGKp4JMURhSsxlFdQ3742rRnUO53VVOEfbD6hE28TnQKcP4i7ss7NBwPjGZv0q2p4exDpmusZcZcl9I9iEEax6tXtJ46TO50w4uWBv0wkticp401HwRjJeQ8KCYdHmffOZu9NZ5RSNCfk5E2g3KSZJ
*/
    return model;
}


@end
