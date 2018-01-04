//
//  NormalUpLoadImgViewController.h
//  MingYa
//
//  Created by 陈必锋 on 2017/10/19.
//  Copyright © 2017年 镓洲 王. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageShowCollectionView.h"
#import "NormarlUploadVCSetting.h"
#import "NMButton.h"


@protocol NormalUpLoadImgViewControllerDelegate<NSObject>
@optional
-(void)finishTheWholeProject;

@end


@interface NormalUpLoadImgViewController : UIViewController

//viewcontroller初始化参数
@property (strong,nonatomic) NormarlUploadVCSetting* viewCtlBaseSetting;
@property (nonatomic,strong) NSString *projectId;
@property (nonatomic,assign) NSInteger sc;
// 作为单独的 controller 显示的时候设置
@property (nonatomic,strong) NSString *detailId;
@property (nonatomic,strong) NSString *sectionName;
@property (nonatomic,assign) NSInteger maxImgCount;

// 在 container 中的时候设置
@property (nonatomic,assign) BOOL isCommitCompleteViewController;
/// 最后一次提交的时候设置
@property (nonatomic,strong) id delegate;



@property (weak, nonatomic) IBOutlet ImageShowCollectionView *collectionView;
@property (weak, nonatomic) IBOutlet NMButton *submitBtn;

- (IBAction)submitBtnClick:(id)sender;

@end
