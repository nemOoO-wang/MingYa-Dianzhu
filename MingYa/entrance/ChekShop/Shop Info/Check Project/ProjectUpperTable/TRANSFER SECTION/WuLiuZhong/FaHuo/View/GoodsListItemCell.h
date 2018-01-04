//
//  GoodsListItemCell.h
//  MingYa
//
//  Created by 陈必锋 on 2017/10/24.
//  Copyright © 2017年 镓洲 王. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodsListItemModel.h"

@interface GoodsListItemCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *goodsNumL;
@property (weak, nonatomic) IBOutlet UIButton *delBtn;
@property (weak, nonatomic) IBOutlet UILabel *goodsNamePlaceHolderL;
@property (weak, nonatomic) IBOutlet UITextView *goodsNameListTV;
@property (weak, nonatomic) IBOutlet UITextField *logisticsCompanyL;
@property (weak, nonatomic) IBOutlet UITextField *logisticsPhoneL;
@property (weak, nonatomic) IBOutlet UITextField *logisticsOrderNumL;
@property (weak, nonatomic) IBOutlet UILabel *sendDateL;
@property (weak, nonatomic) IBOutlet UILabel *expectedTimeL;

@property (strong, nonatomic) IBOutletCollection(NSLayoutConstraint) NSArray *rightToBorders;


- (IBAction)delBtnClick:(id)sender;
- (IBAction)textFieldEditingChanged:(id)sender;

-(void)setupWithModel:(GoodsListItemModel*)model andIndex:(NSInteger)index andDeleteBlock:(void(^)())deleteBlock andDatePickerBlock:(void(^)(BOOL isSendDate))datePickerBlock andIsOnlyShow:(BOOL)isOnlyShow;

@end
