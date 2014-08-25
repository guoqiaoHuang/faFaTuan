//
//  LLOrderDetailsViewController.m
//  faFaTuan
//
//  Created by git on 14-8-24.
//  Copyright (c) 2014年 fafaS. All rights reserved.
//

#import "LLOrderDetailsViewController.h"

@interface LLOrderDetailsViewController ()

@end

@implementation LLOrderDetailsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [_detailWeb loadHTMLString:[[_detail stringByReplacingOccurrencesOfString:@"\\" withString:@""] stringByReplacingOccurrencesOfString:@"<img" withString:@" <img style=\"width:300px;height:170px;\" "] baseURL:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
