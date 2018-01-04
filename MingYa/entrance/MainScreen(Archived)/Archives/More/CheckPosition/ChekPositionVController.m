//
//  ChekPositionVController.m
//  MingYa
//
//  Created by 镓洲 王 on 10/12/17.
//  Copyright © 2017 镓洲 王. All rights reserved.
//

#import "ChekPositionVController.h"
#import "NMBubbleAnnoView.h"
#import "MYUser.h"
#import "BeeNet.h"
#import "MYProject.h"

@interface ChekPositionVController ()<MAMapViewDelegate>
@property (strong, nonatomic) IBOutlet MAMapView *mapView;
@property (nonatomic,strong) NSArray<MYProject *> *projectArr;

@end



@implementation ChekPositionVController

# pragma mark - init projectArr
-(void)setProjectArr:(NSArray *)projectArr{
    NSMutableArray *tmpDataArr = [[NSMutableArray alloc] init];
    for (NSDictionary *tmpDict in projectArr) {
//        MYProject *aProject = [MYProject projectWithDict:tmpDict];
        MYProject *aProject = [[MYProject alloc] init];
        aProject.latitude = [tmpDict[@"latitude"] doubleValue];
        aProject.longititude = [tmpDict[@"longitude"] doubleValue];
        aProject.projectName = tmpDict[@"nickName"];
        [tmpDataArr addObject:aProject];
    }
    _projectArr = [tmpDataArr copy];
}


#pragma mark - MA delegate func
-(MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation{
    if ([annotation isKindOfClass:[MAPointAnnotation class]]) {
        static NSString *annoIdentifier = @"bubbleIdentifier";
        NMBubbleAnnoView *annoView = (NMBubbleAnnoView *)[mapView
                                    dequeueReusableAnnotationViewWithIdentifier:annoIdentifier];
        if (annoView == nil) {
            annoView = [[NMBubbleAnnoView alloc]init];
            [annoView setBubbleWithName:annotation.title];
        }
        CGPoint point = annoView.frame.origin;
        annoView.frame = CGRectMake(point.x, point.y, 20, 20);
        annoView.canShowCallout = NO;
        return annoView;
    }
    return nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // set delegate
    self.mapView.delegate = self;
    
    // move 2 user's location
    [self.mapView setShowsUserLocation:YES];
    self.mapView.userTrackingMode = MAUserTrackingModeFollow;
    MAUserLocationRepresentation *r = [[MAUserLocationRepresentation alloc] init];
    r.image = [UIImage imageNamed:@"myAnno2"];
    [self.mapView updateUserLocationRepresentation:r];
    
}

// view will appear
-(void)viewDidAppear:(BOOL)animated{
    // request 地图位置点集
    NSString *token = [[MYUser defaultUser] token];
    if (token) {
        
        // get coordinate
        CLLocationCoordinate2D center = self.mapView.region.center;
        MACoordinateSpan span = self.mapView.region.span;
        
        // coordinate str
//        NSString *coordinateStr = [NSString stringWithFormat:@"%lf,%lf,%lf,%lf",center.latitude-span.latitudeDelta/2.f,
//                                   center.latitude+span.latitudeDelta/2.f,
//                                   center.longitude-span.longitudeDelta/2.f,
//                                   center.longitude + span.longitudeDelta/2.f];
        NSString *coordinateStr = @"3.52,53.33,73.4,135.2";
        // param
        //
        NSDictionary *paramDict = @{ @"token": token, @"method": @"getAreaUser", @"page": @0, @"searchValue": coordinateStr};
        [[BeeNet sharedInstance] requestWithType:Request_GET andUrl:@"getList" andParam:paramDict andHeader:nil andSuccess:^(id data) {
            NSArray *tmpArr = data[@"data"];
            if ([tmpArr count]>0) {
                // success
                self.projectArr = data[@"data"];
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
        } andFailed:^(NSString *str) {
            // fail
            NSLog(@"%@",str);
        }];
    }
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
