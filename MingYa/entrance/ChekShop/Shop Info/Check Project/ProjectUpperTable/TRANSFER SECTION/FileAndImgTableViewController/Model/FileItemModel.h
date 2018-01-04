//
//  FileItemModel.h
//  MingYa
//
//  Created by 陈必锋 on 2017/10/19.
//  Copyright © 2017年 镓洲 王. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,FileType){
    FileTypeUnknow,
    FileTypeWord,
    FileTypeExcel,
    FileTypePowerPoint,
    FileTypeRAR,
    FileTypePDF,
    FileTypePSD,
    FileTypeAI
};

@interface FileItemModel : NSObject

//文件类型
@property (nonatomic) FileType fileType;

//文件名称
@property (strong,nonatomic) NSString* fileName;

//文件远程url
@property (strong,nonatomic) NSString* fileUrl;

//文件本地url
@property (strong,nonatomic) NSString* fileLocalUrl;

//文件圆形logo
@property (strong,nonatomic) NSString* fileIconImgName;

//文件方形logo
@property (strong,nonatomic) NSString* fileIconBigImgName;

//文件大小
@property (nonatomic) float fileSize;

//文件是否已经下载
@property (nonatomic) BOOL isFinishDownload;


/**
 生成FileItemModel

 @param fileName 文件名称
 @param url 远程url
 @param fileSize 文件大小
 @return FileItemModel
 */
+(FileItemModel*)modelWithFileName:(NSString*)fileName andFileUrl:(NSString*)url andFileSize:(float)fileSize;

@end
