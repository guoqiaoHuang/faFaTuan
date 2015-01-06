//
//  LLLoginViewController.h
//  faFaTuan
//
//  Created by git on 14-9-10.
//  Copyright (c) 2014年 fafaS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LLLoginViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *passWord;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
- (IBAction)loginIn:(id)sender;
- (IBAction)resigerIn:(id)sender;
@end
