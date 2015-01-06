//
//  LLCommentViewController.h
//  faFaTuan
//
//  Created by git on 14-12-31.
//  Copyright (c) 2014年 fafaS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LLCommentViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (strong,nonatomic) NSString *shopID;
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@end
