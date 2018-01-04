//
//  GoodsListItemCell.m
//  MingYa
//
//  Created by 陈必锋 on 2017/10/24.
//  Copyright © 2017年 镓洲 王. All rights reserved.
//

#import "GoodsListItemCell.h"

@interface GoodsListItemCell ()<UITextViewDelegate,UITextFieldDelegate>

@property (strong,nonatomic) GoodsListItemModel* itemModel;
@property (strong,nonatomic) void(^deleteBlock)();
@property (strong,nonatomic) void(^datePickerBlock)(BOOL isSendDate);

@end

@implementation GoodsListItemCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    UITapGestureRecognizer* sendDateTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(sendDateTap)];
    UITapGestureRecognizer* expectedDateTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(expectedDateTap)];
    
    [self.sendDateL.superview addGestureRecognizer:sendDateTap];
    [self.expectedTimeL.superview addGestureRecognizer:expectedDateTap];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setupWithModel:(GoodsListItemModel *)model andIndex:(NSInteger)index andDeleteBlock:(void (^)())deleteBlock andDatePickerBlock:(void (^)(BOOL))datePickerBlock andIsOnlyShow:(BOOL)isOnlyShow{
    self.itemModel = model;
    self.deleteBlock = deleteBlock;
    self.datePickerBlock = datePickerBlock;
    
    self.delBtn.hidden = index == 0 || isOnlyShow;
    self.goodsNamePlaceHolderL.hidden = model.goodsNames.length != 0;
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_Hans"];
    formatter.numberStyle = kCFNumberFormatterRoundHalfDown;
    NSString *upperNum = [formatter stringFromNumber:[NSNumber numberWithInteger:index + 1]];
    
    self.goodsNumL.text = [NSString stringWithFormat:@"第%@批发货",upperNum];
    
    self.goodsNameListTV.text = model.goodsNames;
    self.logisticsCompanyL.text = model.logisticsCompanyName;
    self.logisticsPhoneL.text = model.logisticsPhone;
    self.logisticsOrderNumL.text = model.logisticsNum;
    
    // NSDate
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    self.sendDateL.text = [dateFormatter stringFromDate:model.sendDate];
    self.expectedTimeL.text = [dateFormatter stringFromDate:model.expectedDate];
    
    self.goodsNameListTV.editable = !isOnlyShow;
    self.logisticsCompanyL.enabled = !isOnlyShow;
    self.logisticsPhoneL.enabled = !isOnlyShow;
    self.logisticsOrderNumL.enabled = !isOnlyShow;
    
    [self.sendDateL.superview.gestureRecognizers[0] setEnabled:!isOnlyShow];
    [self.expectedTimeL.superview.gestureRecognizers[0] setEnabled:!isOnlyShow];
    
    for (NSLayoutConstraint* constraint in self.rightToBorders) {
        [constraint setPriority:isOnlyShow ? 751 : 749];
    }
}

-(void)sendDateTap{
    self.datePickerBlock(YES);
}

-(void)expectedDateTap{
    self.datePickerBlock(NO);
}


#pragma mark - UITextViewDelegate
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

-(void)textViewDidChange:(UITextView *)textView{
    self.itemModel.goodsNames = textView.text;
    self.goodsNamePlaceHolderL.hidden = textView.text.length != 0;
    
    
    UITableView* tbl = [self tableView];
    [tbl beginUpdates];
    [tbl endUpdates];
}

#pragma mark - UITextFieldDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return NO;
}

- (UITableView *)tableView{
    UIView *tableView = self.superview;
    while (![tableView isKindOfClass:[UITableView class]] && tableView) {
        tableView = tableView.superview;
    }
    return (UITableView *)tableView;
}

- (IBAction)delBtnClick:(id)sender {
    self.deleteBlock();
}

- (IBAction)textFieldEditingChanged:(id)sender {
    NSInteger tag = [sender tag];
    if (tag == 100) {
        self.itemModel.logisticsCompanyName = [sender text];
    }else if (tag == 101) {
        self.itemModel.logisticsPhone = [sender text];
    }else if (tag == 102) {
        self.itemModel.logisticsNum = [sender text];
    }
}

@end
