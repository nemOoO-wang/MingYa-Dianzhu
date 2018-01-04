//
//  ImgBrowserViewController.m
//  MingYa
//
//  Created by 陈必锋 on 2017/12/27.
//  Copyright © 2017年 镓洲 王. All rights reserved.
//

#import "ImgBrowserViewController.h"

#import "ImgItemCell.h"
#import <Masonry.h>

#import <Photos/Photos.h>

@interface ImgBrowserViewController () <UICollectionViewDelegate,UICollectionViewDataSource>

@property (strong,nonatomic) UICollectionView* collectionView;
@property (strong,nonatomic) NSArray* imgDataArray;
@property (nonatomic) NSInteger startIdx;
@property (strong,nonatomic) NSString* keyPath;
@end

@implementation ImgBrowserViewController

+(ImgBrowserViewController *)viewControllerWithImgArray:(NSArray *)imgArray andKeyPath:(NSString *)keyPath andStartIdx:(NSInteger)startIdx{
    ImgBrowserViewController* vc = [[ImgBrowserViewController alloc] init];
    vc.imgDataArray = imgArray;
    vc.startIdx = startIdx;
    vc.keyPath = keyPath;
    return vc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = [NSString stringWithFormat:@"%ld/%ld",self.startIdx + 1,self.imgDataArray.count];
    
    [self setupUI];
}

-(void)setupUI{
    UICollectionViewFlowLayout* layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.itemSize = CGSizeMake(CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - 64);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.pagingEnabled = YES;
    
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(self.view);
        make.top.equalTo(self.mas_topLayoutGuide);
    }];
    
    [self.collectionView registerClass:[ImgItemCell class] forCellWithReuseIdentifier:@"ImgItemCell"];
    
    UIBarButtonItem* saveToPhone = [[UIBarButtonItem alloc] initWithTitle:@"保存图片" style:UIBarButtonItemStylePlain target:self action:@selector(savePhotoBtnClick)];
    self.navigationItem.rightBarButtonItem = saveToPhone;
}

-(void)savePhotoBtnClick{
    ImgItemCell* cell = (ImgItemCell*)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:[self nowCollectionIdx]-1 inSection:0]];
    UIImage* img = [cell img];
    if (img == nil) {
        [SVProgressHUD showErrorWithStatus:@"图片还没加载成功"];
        return;
    }
    
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
        PHAssetChangeRequest *req = [PHAssetChangeRequest creationRequestForAssetFromImage:img];
    } completionHandler:^(BOOL success, NSError * _Nullable error) {
        [SVProgressHUD showSuccessWithStatus:@"保存成功"];
    }];
}

-(void)viewDidLayoutSubviews{
    if (self.startIdx != -1) {
        [self.collectionView setContentOffset:CGPointMake(CGRectGetWidth(self.view.bounds) * self.startIdx, 0)];
        self.startIdx = -1;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)nowCollectionIdx{
    NSInteger idx = self.collectionView.contentOffset.x / CGRectGetWidth(self.collectionView.bounds) + 1 + 0.5;
    return idx <= 0 ? 1 : idx;
}

#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    self.title = [NSString stringWithFormat:@"%ld/%ld",[self nowCollectionIdx],self.imgDataArray.count];
}

#pragma mark - UICollectionViewDelegate
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}

#pragma mark - UICollectionViewDataSource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.imgDataArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ImgItemCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ImgItemCell" forIndexPath:indexPath];
    
    id imgData = nil;
    if (self.keyPath == nil || [self.keyPath isEqualToString:@""]) {
        imgData = self.imgDataArray[indexPath.row];
    }else{
        imgData = [self.imgDataArray[indexPath.row] valueForKeyPath:self.keyPath];
    }
    
    if ([imgData isKindOfClass:[NSString class]]) {
        [cell setImgUrl:imgData];
    }else if ([imgData isKindOfClass:[UIImage class]]){
        [cell setImg:imgData];
    }
    return cell;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
