//
//  LLBulkDetailViewController.h
//  faFaTuan
//
//  Created by git on 14-8-18.
//  Copyright (c) 2014年 fafaS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LLBulkDetailViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) NSDictionary* bulkDic;//团购信息
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (strong, nonatomic) IBOutlet UIView *tableHeaderView;

@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (strong, nonatomic) IBOutlet UIView *viewImageView;//查看图片 弹出view
@property (weak, nonatomic) IBOutlet UIScrollView *viewImageScroll;
@property (weak, nonatomic) IBOutlet UILabel *viewPage;//标记page
@property (weak, nonatomic) IBOutlet UILabel *imageMarkString;//店名
- (IBAction)viewImages:(id)sender;//点击 打开展示图片组


@property (strong, nonatomic) IBOutlet UIView *sectionView;
@property (weak, nonatomic) IBOutlet UIButton *ticketButton;
- (IBAction)buyAtOnce:(id)sender;//马上购买
@property (weak, nonatomic) IBOutlet UILabel *nowPrice;//现价
@property (weak, nonatomic) IBOutlet UILabel *originPrice;//原价
@end
