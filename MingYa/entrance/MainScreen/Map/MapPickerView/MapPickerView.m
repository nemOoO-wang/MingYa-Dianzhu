//
//  MapPickerView.m
//  MingYa
//
//  Created by 镓洲 王 on 10/13/17.
//  Copyright © 2017 镓洲 王. All rights reserved.
//

#import "MapPickerView.h"
#import "MapLeftTableCell.h"
#import "MYUser.h"
#import "MapRightCollectionCell.h"
#import "MapHeaderCollectionView.h"


@interface MapPickerView ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITableViewDelegate, UITableViewDataSource>

// view
@property (weak, nonatomic) IBOutlet UITableView *leftTableView;
@property (weak, nonatomic) IBOutlet UICollectionView *rightCollectionView;

// data
@property (nonatomic,assign) NSInteger tableSelectedRow;
@property (nonatomic,strong) NSArray *cityArr;
@property (nonatomic,strong) NSArray *subBrandArr;

// log select status
// 城市
@property (nonatomic,strong) NSString *selectedCity;
@property (nonatomic,assign) NSInteger selectedCityTableRow;
@property (nonatomic,assign) NSInteger selectedCityCollectionSection;
@property (nonatomic,assign) NSInteger selectedCityCollectionRow;
// 品牌
@property (nonatomic,strong) NSString *selectedBrand;
@property (nonatomic,assign) NSInteger selectedBrandTableRow;
@property (nonatomic,assign) NSInteger selectedBrandCollectionSection;
@property (nonatomic,assign) NSInteger selectedBrandCollectionRow;


@end


// collection view iden
static NSString *selectBtnIden = @"selected";
static NSString *unSelectBtnIden = @"unselected";
static NSString *collectionHeaderIden = @"header";
static NSString *collectionSeperatorIden = @"footer";

// table iden
static NSString *tableCellIden = @"cell";
static NSString *tableHeadCellIden = @"head cell";

// picker style
static NSString *pickerStyleCity = @"city";
static NSString *pickerStyleBrand = @"brand";


@implementation MapPickerView

# pragma mark - rewrite identifier
-(void)setIdentifier:(NSString *)identifier{
    [super setIdentifier:identifier];
    [self.leftTableView reloadData];
    [self.rightCollectionView reloadData];
}

# pragma mark - set proArr
-(void)setProArr:(NSArray *)proArr{
    NSMutableArray *tmpArr = [proArr mutableCopy];
    [tmpArr insertObject:@{@"name":@"全国"} atIndex:0];
    _proArr = tmpArr;
    // reload table
    [self.leftTableView reloadSections:[NSIndexSet indexSetWithIndex:0.f] withRowAnimation:UITableViewRowAnimationAutomatic];
    // load 1st model
    [self requestCitiesAtIndex:0];
    
}

# pragma mark - set brand
-(void)setBrandArr:(NSArray *)brandArr{
    NSMutableArray *tmpArr = [brandArr mutableCopy];
    [tmpArr insertObject:@{@"brandName":@"全部品牌"} atIndex:0];
    _brandArr = tmpArr;
    // table
    [self.leftTableView reloadSections:[NSIndexSet indexSetWithIndex:0.f] withRowAnimation:UITableViewRowAnimationAutomatic];
    // load model
    [self requestSubBrandAtIndex:0];
}


# pragma mark - <CollectionViewDataSource>

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    MapRightCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:unSelectBtnIden forIndexPath:indexPath];
    if ([self.identifier isEqualToString:pickerStyleCity]) {
        // city
        if (self.selectedCityCollectionSection == indexPath.section && self.selectedCityCollectionRow == indexPath.row) {
            cell = [collectionView dequeueReusableCellWithReuseIdentifier:selectBtnIden forIndexPath:indexPath];
        }else{
            cell = [collectionView dequeueReusableCellWithReuseIdentifier:unSelectBtnIden forIndexPath:indexPath];
        }
        NSArray *cityArr = self.cityArr[indexPath.section][@"areaList"];
        cell.cellName = cityArr[indexPath.row][@"name"];
    }else{
        // brand
        if (self.selectedBrandCollectionSection == indexPath.section && self.selectedBrandCollectionRow == indexPath.row) {
            cell = [collectionView dequeueReusableCellWithReuseIdentifier:selectBtnIden forIndexPath:indexPath];
        }else{
            cell = [collectionView dequeueReusableCellWithReuseIdentifier:unSelectBtnIden forIndexPath:indexPath];
        }
        cell.cellName = self.subBrandArr[indexPath.row][@"subClassName"];
    }
    
    return cell;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if ([self.identifier isEqualToString:pickerStyleCity]) {
        return [(NSArray *)self.cityArr[section][@"areaList"] count];
    }else{
        return self.subBrandArr.count;
    }
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    if ([self.identifier isEqualToString:pickerStyleCity]) {
        return self.cityArr.count;
    }else{
        return 1;
    }
}


-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        // section header
        MapHeaderCollectionView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:collectionHeaderIden forIndexPath:indexPath];
        if (indexPath.section == 0) {
            // 第一行的 section 更高
            CGRect rect = view.bounds;
            rect.size.height += 10;
            view.bounds = rect;
        }
        
        // name
        NSString *headerStr;
        if ([self.identifier isEqualToString: pickerStyleCity]) {
            headerStr = self.cityArr[indexPath.section][@"name"];
        }else{
            headerStr = self.subBrandArr[indexPath.section][@"subClassName"];
        }
        view.headerName = headerStr;
        
        // set highlight
        if (indexPath.section == self.selectedCityCollectionSection) {
            [view.label setTextColor:[UIColor colorWithHexString:@"429BFF"]];
        }else{
            [view.label setTextColor:[UIColor blackColor]];
        }
                
        return view;
        
    }else{
        // section footer
        return [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:collectionSeperatorIden forIndexPath:indexPath];
    }
}


# pragma mark - <collectionViewLayout>

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat width = self.rightCollectionView.frame.size.width / 3.f - 1 ;
    
    return CGSizeMake(width, width-10);
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if ([self.identifier isEqualToString:pickerStyleBrand]) {
        return CGSizeZero;
    }
    return CGSizeMake(CGFLOAT_MAX, 44);
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    if ([self.identifier isEqualToString: @"city"]) {
        return 0;
    }else{
        return self.rightCollectionView.frame.size.width / 2.f;
    }
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
    
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    if (section == 0) {
        return UIEdgeInsetsMake(10, 0, 0, 0);
    }
    return UIEdgeInsetsZero;
}


# pragma mark - <CollectionViewDelegate>
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    //
    NSString *token = [[MYUser defaultUser] token];
    NSString *userId = [[MYUser defaultUser] userId];
    NSDictionary *paramDict;
    NSString *searchValueStr;
    // city / brand
    if ([self.identifier isEqualToString:pickerStyleCity]) {
        // search city
        NSString *areaStr;
        if (indexPath.section == 0) {
            // 全国
            areaStr = @"null";
        } else{
            NSArray *areaAreas = self.cityArr[indexPath.section][@"areaList"];
            if ([areaAreas[indexPath.row][@"name"] isEqualToString:@"全境"]) {
                areaStr = self.cityArr[indexPath.section][@"name"];
            }else{
                areaStr = areaAreas[indexPath.row][@"name"];
            }
        }
#warning 插入品牌
        if (!self.selectedBrand || [self.selectedBrand isEqualToString:@""]) {
            self.selectedBrand = @"null";
        }
        searchValueStr = [NSString stringWithFormat:@"null,null,null,%@,%@,%@,null",areaStr,userId,self.selectedBrand];
        // log status
        self.selectedCityCollectionSection = indexPath.section;
        self.selectedCityCollectionRow = indexPath.row;
        self.selectedCity = areaStr;
        
    }else{
        // search brand
        NSString *subBrandId;
        if (indexPath.row == 0) {
            subBrandId = @"null";
        }else{
            subBrandId = self.subBrandArr[indexPath.row][@"subClassId"];
        }
#warning 插入 city
        if (!self.selectedCity || [self.selectedCity isEqualToString:@""]) {
            self.selectedCity = @"null";
        }
        searchValueStr = [NSString stringWithFormat:@"null,null,null,%@,%@,%@,null",self.selectedCity,userId,subBrandId];
        // log status
        self.selectedBrandCollectionSection = indexPath.section;
        self.selectedBrandCollectionRow = indexPath.row;
        self.selectedBrand = subBrandId;
    }
    // param
    paramDict = @{@"token": token, @"method":@"getProjectList", @"page":@1, @"keyWord": @"", @"searchValue": searchValueStr};
    // request delegate
    if ([self.delegate respondsToSelector:@selector(pickerView:requestDict:)]) {
        [self.delegate performSelector:@selector(pickerView:requestDict:) withObject:paramDict];
    }
}



# pragma mark - UITableViewDataSource
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    // dequeue cell
    MapLeftTableCell *cell;
    if(indexPath.row == 0){
        cell = [tableView dequeueReusableCellWithIdentifier:tableHeadCellIden];
    }else{
        cell = [tableView dequeueReusableCellWithIdentifier:tableCellIden];
    }
    // set cell
    if ([self.identifier isEqualToString:pickerStyleCity]) {
        cell.text = self.proArr[indexPath.row][@"name"];
    }else{
        cell.text = self.brandArr[indexPath.row][@"brandName"];
    }
    
    if (self.tableSelectedRow == 0 && indexPath.row == 0) {
        // 第一次进入，默认选中第一行
        [tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
    }
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([self.identifier isEqualToString:pickerStyleCity]) {
        return self.proArr.count;
    }else{
        return self.brandArr.count;
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


# pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.tableSelectedRow = indexPath.row;
    if ([self.identifier isEqualToString:pickerStyleCity]) {
        [self requestCitiesAtIndex:indexPath.row];
        self.selectedCityTableRow = indexPath.row;
    }else{
        [self requestSubBrandAtIndex:indexPath.row];
        self.selectedBrandTableRow = indexPath.row;
    }
}


# pragma mark - MAIN
-(void)layoutSubviews{
    [super layoutSubviews];
    self.leftTableView.separatorColor = [UIColor clearColor];
    self.leftTableView.rowHeight = UITableViewAutomaticDimension;
    self.leftTableView.estimatedRowHeight = 70.f;
#warning 在这里更新选中节点
    if (self.identifier == pickerStyleCity) {
        // select table
        NSIndexPath *tableIndexpath = [NSIndexPath indexPathForRow:self.selectedCityTableRow inSection:0];
        [self.leftTableView selectRowAtIndexPath:tableIndexpath animated:YES scrollPosition:UITableViewScrollPositionMiddle];
        // select collection
        NSIndexPath *collectionIndexpath = [NSIndexPath indexPathForRow:self.selectedCityCollectionRow inSection:self.selectedCityCollectionSection];
        [self.rightCollectionView selectItemAtIndexPath:collectionIndexpath animated:YES scrollPosition:UICollectionViewScrollPositionTop];
        
    }else if (self.identifier == pickerStyleBrand){
        // select table
        NSIndexPath *tableIndexpath = [NSIndexPath indexPathForRow:self.selectedBrandTableRow inSection:0];
        [self.leftTableView selectRowAtIndexPath:tableIndexpath animated:YES scrollPosition:UITableViewScrollPositionMiddle];
        // select collection
        NSIndexPath *collectionIndexpath = [NSIndexPath indexPathForRow:self.selectedBrandCollectionRow inSection:self.selectedBrandCollectionSection];
        [self.rightCollectionView selectItemAtIndexPath:collectionIndexpath animated:YES scrollPosition:UICollectionViewScrollPositionTop];
        
    }
}



# pragma mark - RequestCity
-(void)requestCitiesAtIndex:(NSInteger)index{
    // request
    if (index == 0) {
        // 全国
        self.cityArr = @[@{@"name":@"全国", @"areaList":@[@{@"name":@"全境"}]}];
        [self.rightCollectionView reloadData];
    }else{
        
        NSString *token = [[MYUser defaultUser] token];
        NSDictionary *subParamDict = @{@"token": token, @"method": @"getAllCityAndArea", @"page": @0, @"keyWord": @"",@"searchValue": self.proArr[index][@"id"]};
        // request cities
        [[BeeNet sharedInstance]
         requestWithType:Request_GET andUrl:@"getList"
         andParam:subParamDict andHeader:nil andSuccess:^(id data) {
             NSMutableArray *tmpMArr = [data[@"data"] mutableCopy];
             [tmpMArr insertObject:@{@"name":@"全省", @"areaList":@[@{@"name":@"全部"}]} atIndex:0];
             self.cityArr = [tmpMArr copy];
             [self.rightCollectionView reloadData];
         } andFailed:nil];
    }
    
}


# pragma mark - requestSubBrandAtIndex
-(void)requestSubBrandAtIndex:(NSInteger)index{
    NSString *bId = [[MYUser defaultUser] userId];
    if (!self.subBrandArr || [self.subBrandArr count]==0) {
        //token
        NSString *token = [[MYUser defaultUser] token];
        
        // request
        NSDictionary *subParamDict = @{@"token": token, @"method": @"getSubClassSelect", @"page": @0, @"keyWord": @"",@"searchValue": bId};
        
        // request sub brand
        [[BeeNet sharedInstance]
         requestWithType:Request_GET andUrl:@"getList"
         andParam:subParamDict andHeader:nil andSuccess:^(id data) {
             NSMutableArray *tmpArr = [data[@"data"] mutableCopy];
             [tmpArr insertObject:@{@"subClassName":@"全部品牌"} atIndex:0];
             self.subBrandArr = [tmpArr copy];
             [self.rightCollectionView reloadData];
         } andFailed:^(NSString *str) {
             NSLog(@"%@",str);
         }];
    }else{
        [self.rightCollectionView reloadData];
    }
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
