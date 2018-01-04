//
//  ShopInfoTableCell.h
//  MingYa
//
//  Created by 镓洲 王 on 10/16/17.
//  Copyright © 2017 镓洲 王. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShopInfoTableCell : UITableViewCell

@property (nonatomic,strong) NSString *leftName;
@property (nonatomic,strong) NSString *detailText;
@property (nonatomic,strong) NSString *rightText;
@property (nonatomic,strong) NSString *phontNumText;
@property (nonatomic,assign) BOOL projectIsStopping;


@end
