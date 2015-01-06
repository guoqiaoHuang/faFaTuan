//
//  LLMapViewController.m
//  faFaTuan
//
//  Created by git on 14-12-25.
//  Copyright (c) 2014年 fafaS. All rights reserved.
//

#import "LLMapViewController.h"
#import "WFTMapPoint.h"
@interface LLMapViewController ()

@end

@implementation LLMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [HCNavigationAndStatusBarTool setNavigationTitle:self andTitle:@"商家地图"];
    [HCNavigationAndStatusBarTool customLeftBackButton:self sel:@selector(goBack)];
    
    //放大地图
    CLLocationCoordinate2D loc = CLLocationCoordinate2DMake([_latitude doubleValue],[_longitude doubleValue]);
    MKCoordinateRegion regin = MKCoordinateRegionMakeWithDistance(loc, 5000, 5000);
    [_mapView setRegion:regin animated:YES];

     WFTMapPoint *item = [[WFTMapPoint alloc] init];
    item.latitude = _latitude;
    item.longitude = _longitude;
    item.name =_shopName;
    [_mapView addAnnotation:item];

    // Do any additional setup after loading the view from its nib.
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)goBack
{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
