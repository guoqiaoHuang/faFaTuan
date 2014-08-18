//
//  ImageCacher.m
//  AAPinChe
//
//  Created by Reese on 13-4-3.
//  Copyright (c) 2013年 Himalayas Technology&Science Company CO.,LTD-重庆喜玛拉雅科技有限公司. All rights reserved.
//  单例类

#import "ImageCacher.h"
#import "FileHelpers.h"
@implementation ImageCacher

static ImageCacher *defaultCacher=nil;
-(id)init
{
    if (defaultCacher) {
        return defaultCacher;
    }else
    {
        self =[super init];
        [self setFade];
        return self;
    }
}

+(ImageCacher*)defaultCacher
{
    if (!defaultCacher) {
        defaultCacher=[[super allocWithZone:nil]init];
    }
    return defaultCacher;
}

+ (id)allocWithZone:(NSZone *)zone
{
    
    return [self defaultCacher];
}

-(void) setFade
{
    _type=kCATransitionFade;
}

-(void) setCube
{
   _type=@"cube";
}

-(void) setFlip
{
   _type= @"oglFlip";
}
-(void) setRippleEffect
{
    _type= @"rippleEffect";
}

-(NSString *)cacheImage:(NSDictionary*)aDic
{
    NSURL *aURL=[aDic objectForKey:@"url"];
    UIView *view=[aDic objectForKey:@"imageView"];
    UILabel *urlMark = [aDic objectForKey:@"urlMark"];
    NSString *urlString = [aDic objectForKey:@"urlString"];
    
    NSData *data=[NSData dataWithContentsOfURL:aURL] ;
    UIImage *image=[UIImage imageWithData:data];
    if (image==nil) {
        return Nil;
    }
    
    //压缩比例
    NSData *smallData=UIImageJPEGRepresentation(image,1);
    
    NSFileManager *fileManager=[NSFileManager defaultManager];
    NSString *path =pathForURL(aURL) ;
    if (smallData) {
        BOOL flag =  [fileManager createFileAtPath:path contents:smallData attributes:nil];
        if(flag){
            NSLog(@"cache success path is:%@,",path);
        }
    }
    
    //判断view是否还存在 如果tablecell已经移出屏幕会被回收 那么什么都不用做，下次滚到该cell 缓存已存在 不需要执行此方法 
    CATransition *transtion = [CATransition animation];
    transtion.duration = 0.1;
    [transtion setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [transtion setType:_type];
    [view.layer addAnimation:transtion forKey:@"transtionKey"];
    if ([urlString isEqualToString:urlMark.text]) {
        [(UIImageView*)view setImage:image];
    }
    return path;
}
@end
