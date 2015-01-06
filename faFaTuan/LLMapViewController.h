//
//  LLMapViewController.h
//  faFaTuan
//
//  Created by git on 14-12-25.
//  Copyright (c) 2014年 fafaS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
@interface LLMapViewController : UIViewController<MKMapViewDelegate>
@property (nonatomic,strong) NSString *longitude;
@property (nonatomic,strong) NSString *latitude;
@property (nonatomic,strong) NSString *shopName;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@end
