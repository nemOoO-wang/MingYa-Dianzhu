//
//  AddWorkerPickerVC.m
//  MingYa
//
//  Created by 镓洲 王 on 10/25/17.
//  Copyright © 2017 镓洲 王. All rights reserved.
//

#import "AddWorkerPickerVC.h"
/// kits
#import "BeeNet.h"
#import "MYUser.h"
/// views
#import "NMPikerView.h"
#import "MapLeftTableCell.h"
#import "MapRightCollectionCell.h"
#import "MapHeaderCollectionView.h"
#import "MapHeaderCollectionView.h"
#import "AddWorkersController.h"


/// constraint length
#define NMPickerCityHeight              408
#define NMPickerWorkerTypeHeight        240
/// animation duration
#define NMShowOutDuration               0.2
/// constraint priority
#define NMTablePriority                 950
#define NMTableAndCollectionPriority    850



@interface AddWorkerPickerVC ()<UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *picker2BottomConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *pickerHeightConstraint;
@property (weak, nonatomic) IBOutlet NMPikerView *pickerView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableOnlyConstraint;
@property (weak, nonatomic) IBOutlet UITableView *leftTableView;
@property (weak, nonatomic) IBOutlet UICollectionView *rightCollection;

@property (nonatomic,strong) NSArray *cityArr;
@property (nonatomic,strong) NSString *selectedProvince;

@end


static NSString *leftCellIden = @"cell";

@implementation AddWorkerPickerVC


// collection view iden
static NSString *selectBtnIden = @"selected";
static NSString *unSelectBtnIden = @"unselected";
static NSString *collectionHeaderIden = @"header";
static NSString *collectionSeperatorIden = @"footer";

# pragma mark - <CollectionViewDataSource>

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MapRightCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:unSelectBtnIden forIndexPath:indexPath];
    if ([self.identifier isEqualToString:@"city"]) {
        NSArray *cityArr = self.cityArr[indexPath.section][@"areaList"];
        cell.cellName = cityArr[indexPath.row][@"name"];
    }else{
        // worker type (none)
    }
    
    return cell;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if ([self.identifier isEqualToString:@"city"]) {
        return [(NSArray *)self.cityArr[section][@"areaList"] count];
    }else{
        // worker type (none)
        return 1;
    }
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    if ([self.identifier isEqualToString:@"city"]) {
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
        if ([self.identifier isEqualToString: @"city"]) {
            headerStr = self.cityArr[indexPath.section][@"name"];
        }else{
            // worker type (none)
        }
        view.headerName = headerStr;
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
    
    // city / worker0
    if ([self.identifier isEqualToString:@"city"]) {
        // search city
        NSArray *areaAreas = self.cityArr[indexPath.section][@"areaList"];
        
//        if ([areaAreas[indexPath.row][@"name"] isEqualToString:@"全境"]) {
//            self.selectedCity = self.cityArr[indexPath.section][@"name"];
//        }else{
//            self.selectedCity = areaAreas[indexPath.row][@"name"];
//        }
        
        self.selectedCityDic = @{@"province": self.selectedProvince,
                                 @"city":self.cityArr[indexPath.section][@"name"],
                                 @"area":areaAreas[indexPath.row][@"name"]};
        
        [self performSegueWithIdentifier:@"unwind2AddWorker" sender:self];
    }else{
        // worker type (none)
    }
    
}



# pragma mark - set proArr & workertypeArr
-(void)setProArr:(NSArray *)proArr{
    _proArr = proArr;
    self.selectedProvince = self.proArr[0][@"name"];
    // load 1st model
    [self requestCitiesAtIndex:0];
}


# pragma mark - <UITableViewDataSource>
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MapLeftTableCell *cell = [tableView dequeueReusableCellWithIdentifier:leftCellIden];
    if ([self.identifier isEqualToString:@"worker"]) {
        cell.text = self.workerTypeArr[indexPath.row][@"name"];
    }else{
        cell.text = self.proArr[indexPath.row][@"name"];
    }
    return cell;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger num;
    if ([self.identifier isEqualToString:@"worker"]) {
        num = self.workerTypeArr.count;
    }else{
        num = self.proArr.count;
    }
    return num;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


# pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.identifier isEqualToString:@"city"]) {
        [self requestCitiesAtIndex:indexPath.row];
        self.selectedProvince = self.proArr[indexPath.row][@"name"];
    }else{
        // worker
        self.selectedWorkerTypeDic = self.workerTypeArr[indexPath.row];
        [self performSegueWithIdentifier:@"unwind2AddWorker" sender:self];
    }
}



# pragma mark - RequestCity
-(void)requestCitiesAtIndex:(NSInteger)index{
    NSString *token = [[MYUser defaultUser] token];
    // request
    NSDictionary *subParamDict = @{@"token": token, @"method": @"getAllCityAndArea", @"page": @0, @"keyWord": @"",@"searchValue": self.proArr[index][@"id"]};
    
    // request cities
    [[BeeNet sharedInstance]
     requestWithType:Request_GET andUrl:@"getList"
     andParam:subParamDict andHeader:nil andSuccess:^(id data) {
         NSMutableArray *tmpMArr = [data[@"data"] mutableCopy];
         [tmpMArr insertObject:@{@"name":@"全省", @"areaList":@[@{@"name":@"全部"}]} atIndex:0];
         self.cityArr = [tmpMArr copy];
         [self.rightCollection reloadData];
     } andFailed:^(NSString *str) {
         //fail
         NSLog(@"%@",str);
     }];
    
}



# pragma mark - Appear Animation
// appear
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.leftTableView.estimatedRowHeight = 50.f;
    self.leftTableView.rowHeight = UITableViewAutomaticDimension;
    // set picker
    CGRect originR = self.pickerView.frame;
    originR.size.width = [UIScreen mainScreen].bounds.size.width - 40;
    originR.origin.y += NMPickerWorkerTypeHeight;
    self.pickerView.frame = originR;
    
//     check identifier
    if ([self.identifier isEqualToString:@"worker"]) {
        // table only
        self.pickerHeightConstraint.constant = NMPickerWorkerTypeHeight;
        self.picker2BottomConstraint.constant = -NMPickerWorkerTypeHeight;
        self.tableOnlyConstraint.priority = NMTablePriority;
    }else{
        // table & collection
        self.pickerHeightConstraint.constant = NMPickerCityHeight;
        self.picker2BottomConstraint.constant = -NMPickerCityHeight;
        self.tableOnlyConstraint.priority = NMTableAndCollectionPriority;
    }
    
}

-(void)viewWillAppear:(BOOL)animated{

    // 弹出菜单
    UIColor *startColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    self.view.backgroundColor = startColor;
    
}

-(void)viewDidAppear:(BOOL)animated{
    UIColor *endColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
    self.view.backgroundColor = endColor;
    
    [UIView animateWithDuration:NMShowOutDuration delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.view.backgroundColor = endColor;
        NSLog(@"%lf",self.picker2BottomConstraint.constant);
        self.picker2BottomConstraint.constant = 20;
        [self.leftTableView layoutSubviews];
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
    }];
    
}

// dissappear
-(void)viewWillDisappear:(BOOL)animated{
    self.view.alpha = 0.f;
    [UIView animateWithDuration:NMShowOutDuration delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.picker2BottomConstraint.constant = -self.pickerView.bounds.size.height;
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        //
    }];
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint point  = [touch locationInView:self.view];
    if (CGRectContainsPoint(self.pickerView.frame, point)) {
        NSLog(@"!!");
    }else{
        [self dismissViewControllerAnimated:YES completion:^{
            //
        }];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
