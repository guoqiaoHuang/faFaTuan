//
//  WFTMapPoint.h
//  weifutong
//
//  Created by LTNET on 14-6-4.
//  Copyright (c) 2014年 LTNET. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface WFTMapPoint : NSObject<MKAnnotation>
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *latitude;
@property (nonatomic, strong) NSString *longitude;
@end
