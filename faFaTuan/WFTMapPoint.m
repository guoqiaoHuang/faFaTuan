//
//  WFTMapPoint.m
//  weifutong
//
//  Created by LTNET on 14-6-4.
//  Copyright (c) 2014年 LTNET. All rights reserved.
//

#import "WFTMapPoint.h"
@implementation WFTMapPoint

- (CLLocationCoordinate2D)coordinate;
{
    CLLocationCoordinate2D theCoordinate;
    theCoordinate.latitude = [self.latitude doubleValue];
    theCoordinate.longitude = [self.longitude doubleValue];
    return theCoordinate;
}

- (NSString *)title
{
    return _name;
}
@end
