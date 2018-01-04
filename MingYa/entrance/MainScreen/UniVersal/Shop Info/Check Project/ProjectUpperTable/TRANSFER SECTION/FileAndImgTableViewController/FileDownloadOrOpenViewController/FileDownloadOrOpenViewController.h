//
//  FileDownloadOrOpenViewController.h
//  MingYa
//
//  Created by 陈必锋 on 2017/10/23.
//  Copyright © 2017年 镓洲 王. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FileItemModel.h"

@interface FileDownloadOrOpenViewController : UIViewController

@property (strong,nonatomic) FileItemModel* itemModel;


@property (weak, nonatomic) IBOutlet UIImageView *fileImgView;
@property (weak, nonatomic) IBOutlet UILabel *fileNameL;
@property (weak, nonatomic) IBOutlet UIProgressView *downloadProgress;
@property (weak, nonatomic) IBOutlet UILabel *progressL;
@property (weak, nonatomic) IBOutlet UIButton *beginDownloadOrOpenBtn;
@property (weak, nonatomic) IBOutlet UIButton *cancelDownloadBtn;


- (IBAction)cancelDownloadBtnClick:(id)sender;
- (IBAction)beginDownloadOrOpenBtnClick:(id)sender;

@end
