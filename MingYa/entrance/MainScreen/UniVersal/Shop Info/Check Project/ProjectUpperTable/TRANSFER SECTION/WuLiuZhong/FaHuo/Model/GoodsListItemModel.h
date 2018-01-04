//
//  GoodsListItemModel.h
//  MingYa
//
//  Created by 陈必锋 on 2017/10/24.
//  Copyright © 2017年 镓洲 王. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GoodsListItemModel : NSObject

@property (nonatomic,strong) NSString *logisticsId;
@property (strong,nonatomic) NSString* goodsNames;
@property (strong,nonatomic) NSString* logisticsCompanyName;
@property (strong,nonatomic) NSString* logisticsPhone;
@property (strong,nonatomic) NSString* logisticsNum;
@property (strong,nonatomic) NSDate* sendDate;
@property (strong,nonatomic) NSDate* expectedDate;



@end
