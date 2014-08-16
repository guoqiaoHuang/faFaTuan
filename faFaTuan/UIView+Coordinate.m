//
//  UIView+Coordinate.m
//  weifutong
//
//  Created by LTNET on 14-6-11.
//  Copyright (c) 2014年 LTNET. All rights reserved.
//

#import "UIView+Coordinate.h"

@implementation UIView (Coordinate)
-(float)X
{
    return self.frame.origin.x;
}
-(float)Y
{
    return self.frame.origin.y;
}
-(float)W
{
    return self.frame.size.width;
}
-(float)H
{
    return self.frame.size.height;
}
-(float)endX
{
    return self.frame.origin.x+self.frame.size.width;
}
-(float)endY
{
    return self.frame.origin.y+self.frame.size.height;
}
@end
