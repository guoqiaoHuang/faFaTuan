//
//  LLMerchantViewController.m
//  faFaTuan
//
//  Created by git on 14-8-12.
//  Copyright (c) 2014年 fafaS. All rights reserved.
//

#import "LLMerchantViewController.h"

@interface LLMerchantViewController ()

@end

@implementation LLMerchantViewController

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
    // Do any additional setup after loading the view.
    [HCNavigationAndStatusBarTool setNavigationBackground:self];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
