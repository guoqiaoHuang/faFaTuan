//
//  LLLoginPassWordViewController.h
//  faFaTuan
//
//  Created by git on 15-1-3.
//  Copyright (c) 2015年 fafaS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LLLoginPassWordViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *originalPassWord;
@property (weak, nonatomic) IBOutlet UITextField *newsPassWord;

@property (weak, nonatomic) IBOutlet UITextField *confirmPassWord;
@property (weak, nonatomic) IBOutlet UIButton *okButton;
- (IBAction)ok:(UIButton *)sender;
@end
