//
//  MapViewController.m
//  MingYa
//
//  Created by 镓洲 王 on 10/12/17.
//  Copyright © 2017 镓洲 王. All rights reserved.
//

#import "MapViewController.h"
#import "NMapView.h"
#import "NMAnnotationView.h"
#import "BeeNet.h"
#import "MYUser.h"
#import "MYProject.h"
#import "ShopInfoTabVC.h"
#import <JPUSHService.h>
//#import <MAMapKit/MAMapKit.h>
//#import <AMapFoundationKit/AMapFoundationKit.h>

#define NMPickerMinimalHeight       48
#define NMShowPickerConstant        20     // picker 到 bar 的距离


@interface MapViewController ()<MAMapViewDelegate>

// 700->900
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *showRightOnlyConstraint;

// view
@property (strong, nonatomic) IBOutlet NMapView *mapView;
@property (weak, nonatomic) IBOutlet MapPickerView *mapPickerView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cityToBottomConstraint;
@property (weak, nonatomic) IBOutlet UIButton *cityBtn;
@property (weak, nonatomic) IBOutlet UIButton *brandBtn;
@property (nonatomic,assign) CGFloat hidePickerConstant;
@property (weak, nonatomic) IBOutlet NMRoundView *roundView;
@property (weak, nonatomic) IBOutlet UIButton *quitBtn;

// param
@property (nonatomic,strong) NSArray<MYProject *> *projectArr;
@property (nonatomic,strong) NSString *selectedProjectId;
@property (nonatomic,strong) NSString *token;

@end


static NSString *cityIden = @"city";
static NSString *brandIden = @"brand";

@implementation MapViewController
- (IBAction)clickQuickBtn:(id)sender {
    // user default
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:@"token"];
    [defaults removeObjectForKey:@"userId"];
    [defaults synchronize];
    
    // JPush
    [JPUSHService deleteAlias:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
        NSLog(@"irescode:%ld\nialias:%@\nseq:%ld",iResCode,iAlias,seq);
    } seq:0];
    
    // pop
    [self dismissViewControllerAnimated:YES completion:^{
        //
    }];
}

# pragma mark - init projectArr
-(void)setProjectArr:(NSArray *)projectArr{
    NSMutableArray *tmpDataArr = [[NSMutableArray alloc] init];
    for (NSDictionary *tmpDict in projectArr) {
        MYProject *aProject = [MYProject projectWithDict:tmpDict];
        [tmpDataArr addObject:aProject];
    }
    _projectArr = [tmpDataArr copy];
    [self reloadMapWithPositions];
}


#pragma mark - load pickerConstant
-(CGFloat)hidePickerConstant{
    if (!_hidePickerConstant) {
        _hidePickerConstant = 0.f;
        self.cityToBottomConstraint.constant = NMShowPickerConstant;
        CGFloat height = self.mapPickerView.frame.size.height;
        _hidePickerConstant = (height - NMPickerMinimalHeight)+NMShowPickerConstant;
    }
    return _hidePickerConstant;
}


# pragma mark - reload map with annotations
-(void)reloadMapWithPositions{
    // 刷新 map
    [self.mapView removeAnnotations:self.mapView.annotations];
    
    for (MYProject *aProject in self.projectArr) {
        // a project
        MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc] init];
        pointAnnotation.coordinate = CLLocationCoordinate2DMake(aProject.latitude, aProject.longititude);
        pointAnnotation.title = aProject.projectName;
        pointAnnotation.subtitle = aProject.projectId;
        [self.mapView addAnnotation:pointAnnotation];
    }
    [self.mapView showAnnotations:self.mapView.annotations animated:YES];
}


#pragma mark - map delegate
-(MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation{
    
    // user location
    if ([annotation isKindOfClass:[MAUserLocation class]]) {
        return nil;
    }
    
    // set anno
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        static NSString *reuseIndetifier = @"annoIndetifier";
        NMAnnotationView *annotationView = (NMAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:reuseIndetifier];
        if (annotationView == nil)
        {
            annotationView = [[NMAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:reuseIndetifier];
            [annotationView addBtnWithName:annotation.title andProjectId:annotation.subtitle];
        }else{
            [annotationView updateBtnWithName:annotation.title andProjectId:annotation.subtitle];
        }
        
        CGPoint point = annotationView.frame.origin;
        annotationView.frame = CGRectMake(point.x, point.y, 20, 20);
        annotationView.canShowCallout = NO;
        return annotationView;
    }
    return nil;
}



#pragma mark - view load & appear
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // set map delegate
    self.mapView.delegate = self;
    
    // move 2 user's location
    [self.mapView setShowsUserLocation:YES];
    self.mapView.userTrackingMode = MAUserTrackingModeFollow;
    MAUserLocationRepresentation *r = [[MAUserLocationRepresentation alloc] init];
    r.image = [UIImage imageNamed:@"myAnno2"];
    [self.mapView updateUserLocationRepresentation:r];
    
    // picker delegate
    self.mapPickerView.delegate = self;
    
    // 多线程加载省市、工种
    [self loadStatesAtBackGround];
    [self loadBrandsAtBackGround];
    
    // 观察 notification
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(presentAnno:) name:@"selectAnnoInMap" object:nil];
}

/// 点击位置点，响应通知中心
-(void)presentAnno:(NSNotification *)notification{
    self.selectedProjectId = (NSString *)notification.object;
    [self performSegueWithIdentifier:@"check project" sender:self];
}

/// prepare for segue
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    UINavigationController *naviVC = [segue destinationViewController];
    ShopInfoTabVC *vc = [[naviVC viewControllers]firstObject];
    vc.projectID = self.selectedProjectId;
}


-(void)viewDidAppear:(BOOL)animated{
    [self.roundView loadSubLayerWithController:self];
    
    // request 地图位置点集
    NSString *token = [[MYUser defaultUser] token];
    NSString *bId = [[MYUser defaultUser] userId];
    self.token = token;
    if (token) {
        
        // 获取自己的位置
//        // get coordinate
//        CLLocationCoordinate2D center = self.mapView.region.center;
//        MACoordinateSpan span = self.mapView.region.span;
//        // coordinate str
//        NSString *coordinateStr = [NSString stringWithFormat:@"%lf,%lf,%lf,%lf",center.latitude-span.latitudeDelta/2.f,
//                                   center.latitude+span.latitudeDelta/2.f,
//                                   center.longitude-span.longitudeDelta/2.f,
//                                   center.longitude + span.longitudeDelta/2.f];
        // 改为中国的范围
        NSString *coordinateStr = @"3.52,53.33,73.4,135.2";
        
        // param
        NSDictionary *paramDict = @{ @"token": token, @"brandId": bId, @"searchValue": coordinateStr};
        [[BeeNet sharedInstance] requestWithType:Request_GET andUrl:@"brand/map" andParam:paramDict andHeader:nil andSuccess:^(id data) {
            
            // success
            NSArray *tmpArr = data[@"data"];
            if ([tmpArr count]>0) {
                self.projectArr = tmpArr;
            }
        } andFailed:^(NSString *str) {
            // fail
            NSLog(@"%@",str);
        }];
    }
}


-(void)viewWillAppear:(BOOL)animated{
    [self.view bringSubviewToFront:self.quitBtn];
    [self.view bringSubviewToFront:self.mapPickerView];
    [self.mapPickerView initFrameInSuperViewWithConstraint:self.cityToBottomConstraint showConstant:NMShowPickerConstant];
    
}


# pragma mark - load data at background

// 请求省
-(void)loadStatesAtBackGround{
    
    // token
    NSString *token = [[MYUser defaultUser] token];
    
    // init operation queue1
    NSOperationQueue *queue1 = [[NSOperationQueue alloc] init];
    
    // Thread 1
    NSBlockOperation *operation1 = [NSBlockOperation blockOperationWithBlock:^{
        
        // param
        NSDictionary *paramDict = @{ @"token": token,
                                     @"method": @"getAllProvice", @"page": @0,
                                     @"keyWord": @"", @"searchValue": @""};
        // request provinces
        [[BeeNet sharedInstance] requestWithType:Request_GET andUrl:@"getList"
                                        andParam:paramDict andHeader:nil
                                      andSuccess:^(id data) {
                                          
                                          // province success
                                          self.mapPickerView.proArr = data[@"data"];
                                          
                                      } andFailed:nil];
        
    }];
    [queue1 addOperation:operation1];
    
}

// 请求品牌
-(void)loadBrandsAtBackGround{
    
    // token
    NSString *token = [[MYUser defaultUser] token];
    
    // init operation queue2
    NSOperationQueue *queue2 = [[NSOperationQueue alloc] init];
    
    NSBlockOperation *operation2 = [NSBlockOperation blockOperationWithBlock:^{
        
        // param
        NSDictionary *paramDict = @{ @"token": token,
                                     @"method": @"getBrandListForSelect", @"page": @0,
                                     @"keyWord": @"", @"searchValue": @""};
        // request provinces
        [[BeeNet sharedInstance] requestWithType:Request_GET andUrl:@"getList"
                                        andParam:paramDict andHeader:nil
                                      andSuccess:^(id data) {
                                          
                                          // province success
                                          self.mapPickerView.brandArr = data[@"data"];
                                          
                                      } andFailed:nil];
        
    }];
    [queue2 addOperation:operation2];
    
}


# pragma mark - <MapPickerViewDelegate>
-(void)pickerView:(NMPikerView *)pickerView requestDict:(NSDictionary *)paramDict{
    if (self.cityBtn.selected) {
        [self.mapPickerView animateWithViewController:self TargetIdentifier:cityIden];
    }else{
        [self.mapPickerView animateWithViewController:self TargetIdentifier:brandIden];
    }
    [[BeeNet sharedInstance] requestWithType:Request_GET andUrl:@"/getList" andParam:paramDict andHeader:nil andSuccess:^(id data) {
        // success
        self.projectArr = data[@"data"];
    } andFailed:^(NSString *str) {
        NSLog(@"%@",str);
    }];
}


# pragma mark - click btn
- (IBAction)clickPickBtn:(id)sender {
    
    UIButton *btn = (UIButton *)sender;
    
    switch (btn.tag) {
        case 1:
            self.cityBtn.selected = [self.mapPickerView.identifier isEqualToString:cityIden] ? NO: YES;
            self.brandBtn.selected = NO;
            self.showRightOnlyConstraint.priority = 700;
            [self.mapPickerView animateWithViewController:self TargetIdentifier:cityIden];
            break;
            
        case 2:
            self.brandBtn.selected = [self.mapPickerView.identifier isEqualToString:brandIden] ? NO: YES ;
            self.cityBtn.selected = NO;
            self.showRightOnlyConstraint.priority = 900;
            [self.mapPickerView animateWithViewController:self TargetIdentifier:brandIden];
            break;
            
        default:
            NSLog(@"错误选项");
            break;
    }
}


@end
