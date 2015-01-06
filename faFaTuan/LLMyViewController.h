//
//  LLMyViewController.h
//  faFaTuan
//
//  Created by git on 14-8-12.
//  Copyright (c) 2014年 fafaS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LLMyViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
- (IBAction)loginIn:(id)sender;

//登陆后显示
@property (weak, nonatomic) IBOutlet UIView *userDetailView;

@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UIImageView *leaveImage;
@property (weak, nonatomic) IBOutlet UILabel *moneyLable;
- (IBAction)setHeaderImage:(id)sender;
- (IBAction)mineInformation:(id)sender;
@end
