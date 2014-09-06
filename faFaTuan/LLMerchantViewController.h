//
//  LLMerchantViewController.h
//  faFaTuan
//
//  Created by git on 14-8-12.
//  Copyright (c) 2014年 fafaS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DropDownChooseProtocol.h"
#import "EGORefreshTableHeaderView.h"
#import "EGORefreshTableFooterView.h"

@interface LLMerchantViewController : UIViewController<DropDownChooseDelegate,DropDownChooseDataSource,UITableViewDelegate,UITableViewDataSource,EGORefreshTableHeaderDelegate,EGORefreshTableFooterDelegate>{
    EGORefreshTableHeaderView *_refreshHeaderView;
    BOOL _reloading;
    
    EGORefreshTableFooterView *refreshView;
    BOOL reloading;
    
    int pages;
}

@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@end
