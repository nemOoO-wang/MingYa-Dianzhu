//
//  MapHeaderCollectionView.h
//  MingYa
//
//  Created by 镓洲 王 on 11/21/17.
//  Copyright © 2017 镓洲 王. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MapHeaderCollectionView : UICollectionReusableView

@property (weak, nonatomic) IBOutlet UILabel *label;

@property (nonatomic,strong) NSString *headerName;

@end
