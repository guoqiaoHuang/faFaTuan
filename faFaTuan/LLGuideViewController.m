//
//  LLGuideViewController.m
//  faFaTuan
//
//  Created by git on 14-8-11.
//  Copyright (c) 2014年 fafaS. All rights reserved.
//

#import "LLGuideViewController.h"

@interface LLGuideViewController ()

@end

@implementation LLGuideViewController

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
    if (1==[[[NSUserDefaults standardUserDefaults]objectForKey:@"guide"]intValue]) {
        [self performSegueWithIdentifier:@"guide" sender:self];
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)startGuide:(id)sender {
    [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"guide"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
@end
