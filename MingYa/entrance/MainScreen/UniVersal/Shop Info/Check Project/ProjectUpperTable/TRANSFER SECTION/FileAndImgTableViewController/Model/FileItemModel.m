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
    
    return model;
}


@end
