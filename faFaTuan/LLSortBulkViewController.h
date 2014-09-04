//
//  LLSortBulkViewController.h
//  faFaTuan
//
//  Created by git on 14-8-26.
//  Copyright (c) 2014年 fafaS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DropDownChooseProtocol.h"
#import "EGORefreshTableHeaderView.h"

@interface LLSortBulkViewController : UIViewController<DropDownChooseDelegate,DropDownChooseDataSource,UITableViewDelegate,UITableViewDataSource,EGORefreshTableHeaderDelegate>{
    EGORefreshTableHeaderView *_refreshHeaderView;
    BOOL _reloading;
}
@property (nonatomic ,assign) int mark;
@property (nonatomic ,strong) NSString *typeName;//分类名称

@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@end
