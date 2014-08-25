//
//  LLOrderDetailsViewController.h
//  faFaTuan
//
//  Created by git on 14-8-24.
//  Copyright (c) 2014年 fafaS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LLOrderDetailsViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIWebView *detailWeb;
@property (strong, nonatomic)  NSString *detail;

@end
