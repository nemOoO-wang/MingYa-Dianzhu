//
//  WorkerPickerView.m
//  MingYa
//
//  Created by 镓洲 王 on 10/24/17.
//  Copyright © 2017 镓洲 王. All rights reserved.
//

#import "WorkerPickerView.h"
// views
#import "MapRightCollectionCell.h"
#import "MapHeaderCollectionView.h"
#import "MapHeaderCollectionView.h"
#import "MapLeftTableCell.h"
// models
#import "MYUser.h"


@interface WorkerPickerView()<UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

// 950/850
@property (nonatomic,weak) IBOutlet NSLayoutConstraint *set950ToShowTableOnlyConstraint;

@property (nonatomic,weak) IBOutlet UITableView *leftTable;
@property (nonatomic,weak) IBOutlet UICollectionView *rightCollection;

// data
@property (nonatomic,strong) NSArray *cityArr;
@property (nonatomic,assign) NSInteger tableSelectedRow;

// log select status
// 城市
@property (nonatomic,strong) NSString *selectedCity;
@property (nonatomic,assign) NSInteger selectedCityTableRow;
@property (nonatomic,assign) NSInteger selectedCityCollectionSection;
@property (nonatomic,assign) NSInteger selectedCityCollectionRow;
// 工种
@property (nonatomic,assign) NSInteger selectedWorkTableRow;
@property (nonatomic,assign) NSInteger selectedWorkCollectionSection;
@property (nonatomic,assign) NSInteger selectedWorkCollectionRow;

@end


@implementation WorkerPickerView

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
static NSString *pickerStyleBrand = @"workerType";


# pragma mark - rewrite identifier
-(void)setIdentifier:(NSString *)identifier{
    [super setIdentifier:identifier];
    [self.leftTable reloadData];
    [self.rightCollection reloadData];
}

# pragma mark - set proArr & workertypeArr
-(void)setProArr:(NSArray *)proArr{
    NSMutableArray *tmpArr = [proArr mutableCopy];
    [tmpArr insertObject:@{@"name":@"全国"} atIndex:0];
    _proArr = tmpArr;
    // reload table
    [self.leftTable reloadSections:[NSIndexSet indexSetWithIndex:0.f] withRowAnimation:UITableViewRowAnimationAutomatic];
    // load 1st model
    [self requestCitiesAtIndex:0];
}

-(void)setWorkerTypeArr:(NSArray *)workerTypeArr{
    _workerTypeArr = workerTypeArr;
    [self.leftTable reloadSections:[NSIndexSet indexSetWithIndex:0.f] withRowAnimation:UITableViewRowAnimationAutomatic];
}


# pragma mark - <CollectionViewDataSource>

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MapRightCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:unSelectBtnIden forIndexPath:indexPath];
    if ([self.identifier isEqualToString:pickerStyleCity]) {
        NSArray *cityArr = self.cityArr[indexPath.section][@"areaList"];
        cell.cellName = cityArr[indexPath.row][@"name"];
    }else{
        // worker type (none)
    }
    
    return cell;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if ([self.identifier isEqualToString:pickerStyleCity]) {
        return [(NSArray *)self.cityArr[section][@"areaList"] count];
    }else{
        // worker type (none)
        return 1;
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
            // worker type (none)
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
    CGFloat width = self.rightCollection.frame.size.width / 3.f - 1 ;
    
    return CGSizeMake(width, width-10);
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    if ([self.identifier isEqualToString: @"city"]) {
        return 0;
    }else{
        return self.rightCollection.frame.size.width / 2.f;
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
    self.tableSelectedRow = indexPath.row;
    //
    NSString *token = [[MYUser defaultUser] token];
    NSDictionary *paramDict;
    NSString *searchValueStr;
    // city / worker0
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
        searchValueStr = [NSString stringWithFormat:@"null,null,%@,null,null",areaStr];
        // param
        paramDict = @{@"token": token, @"method":@"getAllPersonal", @"page":@1, @"keyWord": @"", @"searchValue": searchValueStr};
        // request delegate
        if ([self.delegateController respondsToSelector:@selector(pickerView:requestDict:)]) {
            [self.delegateController performSelector:@selector(pickerView:requestDict:) withObject:paramDict];
        }
        // log status
        self.selectedCityCollectionSection = indexPath.section;
        self.selectedCityCollectionRow = indexPath.row;
        self.selectedCity = areaStr;
    }else{
        // worker type (none)
        // log status
        self.selectedWorkCollectionSection = indexPath.section;
        self.selectedWorkCollectionRow = indexPath.row;
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
        // worker type
        cell.text = self.workerTypeArr[indexPath.row][@"name"];
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
        // worker type
        return self.workerTypeArr.count;
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


# pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.identifier isEqualToString:pickerStyleCity]) {
        [self requestCitiesAtIndex:indexPath.row];
        self.selectedCityTableRow = indexPath.row;
    }else{
        self.selectedWorkTableRow = indexPath.row;
        // search 工种
        NSString *token = [[MYUser defaultUser] token];
        NSString *workeTypeId = self.workerTypeArr[indexPath.row][@"id"];
        NSString *searchValueStr = [NSString stringWithFormat:@"null,null,null,%@,null",workeTypeId];
        // param
        NSDictionary *paramDict = @{@"token": token, @"method":@"getAllPersonal", @"page":@1, @"keyWord": @"", @"searchValue": searchValueStr};
        // request delegate
        if ([self.delegateController respondsToSelector:@selector(pickerView:requestDict:)]) {
            [self.delegateController performSelector:@selector(pickerView:requestDict:) withObject:paramDict];
        }
    }
}


# pragma mark - MAIN
-(void)layoutSubviews{
    [super layoutSubviews];
    self.leftTable.separatorColor = [UIColor clearColor];
    self.leftTable.rowHeight = UITableViewAutomaticDimension;
    self.leftTable.estimatedRowHeight = 70.f;
    
    // show collection only?
    if ([self.identifier isEqualToString: pickerStyleCity]) {
        self.set950ToShowTableOnlyConstraint.priority = 800;
    }else{
        self.set950ToShowTableOnlyConstraint.priority = 950;
    }
    
#warning 在这里更新选中节点
    if ([self.identifier isEqualToString: pickerStyleCity]) {
        // select table
        NSIndexPath *tableIndexpath = [NSIndexPath indexPathForRow:self.selectedCityTableRow inSection:0];
        [self.leftTable selectRowAtIndexPath:tableIndexpath animated:YES scrollPosition:UITableViewScrollPositionMiddle];
        // select collection
        NSIndexPath *collectionIndexpath = [NSIndexPath indexPathForRow:self.selectedCityCollectionRow inSection:self.selectedCityCollectionSection];
        [self.rightCollection selectItemAtIndexPath:collectionIndexpath animated:YES scrollPosition:UICollectionViewScrollPositionTop];
    }else{
        // select table
//        NSIndexPath *tableIndexpath = [NSIndexPath indexPathForRow:self.selectedWorkTableRow inSection:0];
//        [self.leftTable selectRowAtIndexPath:tableIndexpath animated:YES scrollPosition:UITableViewScrollPositionMiddle];
//        // select collection
//        NSIndexPath *collectionIndexpath = [NSIndexPath indexPathForRow:self.selectedWorkCollectionRow inSection:self.selectedWorkCollectionSection];
//        [self.rightCollection selectItemAtIndexPath:collectionIndexpath animated:YES scrollPosition:UICollectionViewScrollPositionTop];
    }
}



# pragma mark - RequestCity
-(void)requestCitiesAtIndex:(NSInteger)index{
    // request
    if (index == 0) {
        // 全国
        self.cityArr = @[@{@"name":@"全国", @"areaList":@[@{@"name":@"全境"}]}];
        [self.rightCollection reloadData];
    }else{
        
        NSString *token = [[MYUser defaultUser] token];
        NSDictionary *subParamDict = @{@"token": token, @"method": @"getAllCityAndArea", @"page": @0, @"keyWord": @"",@"searchValue": self.proArr[index][@"id"]};
        // request cities
        [[BeeNet sharedInstance]
         requestWithType:Request_GET andUrl:@"getList"
         andParam:subParamDict andHeader:nil andSuccess:^(id data) {
             self.cityArr = data[@"data"];
             [self.rightCollection reloadData];
         } andFailed:nil];
    }
}



# pragma mark - delegate
-(void)pickWillShow{
    if (self.tag == 2) {
        [self.delegateController changePickerLayoutAs:NMWorkerPickerTypeWorker];
    }else{
        [self.delegateController changePickerLayoutAs:NMWorkerPickerTypeCity];
    }
}

-(void)pickWillReload{
    [self pickWillShow];
}


-(void)didMoveToSuperview{
    self.leftTable.tableFooterView = [[UIView alloc] init];
}

@end
