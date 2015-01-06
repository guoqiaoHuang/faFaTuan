
//
//  LLBindingPhoneViewController.h
//  faFaTuan
//
//  Created by git on 15-1-3.
//  Copyright (c) 2015年 fafaS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LLBindingPhoneViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *okButton;
@property (weak, nonatomic) IBOutlet UIButton *verifiButton;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTextFild;
@property (weak, nonatomic) IBOutlet UITextField *verifiTextField;

- (IBAction)getVerNumber:(UIButton *)sender;
- (IBAction)submitTextFiled:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *timeLable;
@end

