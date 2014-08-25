//
//  LLBulkDetailTableViewCell.h
//  faFaTuan
//
//  Created by git on 14-8-19.
//  Copyright (c) 2014年 fafaS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LLBulkDetailTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *title;//标题
@property (weak, nonatomic) IBOutlet UILabel *subtitle;//副标题
@property (weak, nonatomic) IBOutlet UIImageView *drawbackImg;//支付图片
@property (weak, nonatomic) IBOutlet UILabel *drawback;//


@property (weak, nonatomic) IBOutlet UIImageView *overDrawbackImg;//过期退款
@property (weak, nonatomic) IBOutlet UILabel *overDrawback;

@property (weak, nonatomic) IBOutlet UILabel *haveSell;//已经销售
@property (weak, nonatomic) IBOutlet UILabel *sellTime;// 销售时间

//评价
@property (weak, nonatomic) IBOutlet UILabel *score;
@property (weak, nonatomic) IBOutlet UILabel *personNum;
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *star;
//商家信息
@property (weak, nonatomic) IBOutlet UILabel *shopName;
@property (weak, nonatomic) IBOutlet UILabel *shopAddress;
@property (strong,nonatomic) NSString *phone;
- (IBAction)call:(id)sender;
//套餐
@property (weak, nonatomic) IBOutlet UIView *packageTopView;
@property (weak, nonatomic) IBOutlet UIWebView *package;
@property (weak, nonatomic) IBOutlet UIImageView *packageImage;

//购买须知
@property (weak, nonatomic) IBOutlet UIView *purchaseTopView;
@property (weak, nonatomic) IBOutlet UIWebView *purchase;
@property (weak, nonatomic) IBOutlet UIImageView *purchaseImage;

@property (strong, nonatomic)  NSString *packageStr;
@property (strong, nonatomic)  NSString *purchaseStr;

@end
