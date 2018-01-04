 //
//  SharedPicsCollectionViewController.m
//  MingYa
//
//  Created by 镓洲 王 on 10/26/17.
//  Copyright © 2017 镓洲 王. All rights reserved.
//

#import "SharedPicsCollectionViewController.h"
#import "SharedPicCollectionCell.h"
#import "SharedPicHeaderView.h"
#import "BeeNet.h"
#import "MYUser.h"

#import "ImgBrowserViewController.h"


#define NMItemInterim   5

@interface SharedPicsCollectionViewController ()<UICollectionViewDelegateFlowLayout>
@property (nonatomic,assign) CGSize screenSize;
@property (nonatomic,strong) NSArray *dataArr;


@end

@implementation SharedPicsCollectionViewController

static NSString * const itemIdentifier = @"picture";
static NSString * const headIdentifier = @"head";

// get screen size
-(CGSize)screenSize{
    if (CGSizeEqualToSize(_screenSize, CGSizeZero)) {
        self.screenSize = [UIScreen mainScreen].bounds.size;
    }
    return _screenSize;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // request
    NSString *token = [[MYUser defaultUser] token];
    NSDictionary *paramDict = @{ @"token":token, @"method": @"getShareImageApp", @"page": @0};
    [[BeeNet sharedInstance] requestWithType:Request_GET andUrl:@"getList" andParam:paramDict andHeader:nil andSuccess:^(id data) {
        // success
        self.dataArr = data[@"data"];
        [self.collectionView reloadData];
    } andFailed:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

# pragma mark - <UICollectionFlowLayout>

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat width = (self.screenSize.width-NMItemInterim*4)/3 - 1;
    return CGSizeMake(width, width);
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return NMItemInterim;
}
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return NMItemInterim;
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, NMItemInterim, 0, NMItemInterim);
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.dataArr.count;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSArray *tmpArr = self.dataArr[section][@"shareImage"];
    return tmpArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SharedPicCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:itemIdentifier forIndexPath:indexPath];
    
    NSArray *tmpArr = self.dataArr[indexPath.section][@"shareImage"];
    cell.imageDict = tmpArr[indexPath.row];
    
    return cell;
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    SharedPicHeaderView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:headIdentifier forIndexPath:indexPath];
    // timestamp
    NSString *timeStrap = self.dataArr[indexPath.section][@"shareDate"];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[timeStrap doubleValue]/1000.f];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy.MM.dd"];
    view.time = [formatter stringFromDate:date];
    return view;
}

#pragma mark <UICollectionViewDelegate>
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    ImgBrowserViewController* vc = [ImgBrowserViewController viewControllerWithImgArray:self.dataArr[indexPath.section][@"shareImage"] andKeyPath:@"shareUrl" andStartIdx:indexPath.item];
    [self.navigationController pushViewController:vc animated:YES];
}


/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
