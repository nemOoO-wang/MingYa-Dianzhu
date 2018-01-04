//
//  ProjectCollectionReusableView.h
//  MingYa
//
//  Created by 镓洲 王 on 11/24/17.
//  Copyright © 2017 镓洲 王. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProjectCollectionReusableView : UICollectionReusableView

@property (weak, nonatomic) IBOutlet UILabel *label;

@property (nonatomic,strong) NSString *headerName;
@property (nonatomic,assign) BOOL showLabel;

@end
