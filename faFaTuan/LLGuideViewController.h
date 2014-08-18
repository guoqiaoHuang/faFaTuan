//
//  LLGuideViewController.h
//  faFaTuan
//
//  Created by git on 14-8-11.
//  Copyright (c) 2014年 fafaS. All rights reserved.
//
//  控制是否进入引导页
#import <UIKit/UIKit.h>

@interface LLGuideViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *startButton;
- (IBAction)startGuide:(id)sender;
@end
