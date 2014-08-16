//
//  LLBulkViewController.h
//  faFaTuan
//
//  Created by git on 14-8-12.
//  Copyright (c) 2014年 fafaS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LLBulkTableViewCell.h"
@interface LLBulkViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@end
