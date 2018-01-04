//
//  AliOSSKit.h
//  MingYa
//
//  Created by 镓洲 王 on 12/11/17.
//  Copyright © 2017 镓洲 王. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol AliOSSKitDelegate <NSObject>

-(void)aliKitFinishUploadImgswithNameArr:(NSArray *)imgNameArr;
@optional
-(void)aliKitFinishUploadImg:(UIImage *)img withName:(NSString *)imgName;

@end


@interface AliOSSKit : NSObject

@property (nonatomic,strong) id <AliOSSKitDelegate> delegate;


+ (instancetype)sharedInstance;
- (void)initOSSClient;
- (void)pushImage:(UIImage *)img withName:(NSString *)imgName;
- (void)pushImgsAutoSetName:(NSArray *)imgArr;

@end
