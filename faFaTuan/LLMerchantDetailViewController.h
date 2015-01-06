//
//  LLMerchantDetailViewController.h
//  faFaTuan
//
//  Created by git on 14-12-24.
//  Copyright (c) 2014年 fafaS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TQStarRatingView.h"
#import "ImageCacher.h"
#import "FileHelpers.h"

@interface LLMerchantDetailViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (strong,nonatomic) NSDictionary *merchantDic;
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
//商家信息
@property (strong, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UILabel *headerTitleLable;
@property (weak, nonatomic) IBOutlet TQStarRatingView *starView;
@property (weak, nonatomic) IBOutlet UILabel *rateLable;
@property (weak, nonatomic) IBOutlet UILabel *addressLable;
@property (weak, nonatomic) IBOutlet UILabel *markImg;
- (IBAction)telPhoneButton:(UIButton *)sender;
- (IBAction)moreImage:(UITapGestureRecognizer *)sender;
//地图
- (IBAction)goMapView:(UITapGestureRecognizer *)sender;

//评价
@property (strong, nonatomic) IBOutlet UIView *footerView;
@property (weak, nonatomic) IBOutlet UILabel *commentName;
@property (weak, nonatomic) IBOutlet TQStarRatingView *commentStar;
@property (weak, nonatomic) IBOutlet UILabel *commentsLable;
@property (weak, nonatomic) IBOutlet UILabel *commentNext;
- (IBAction)goCommentPage:(UITapGestureRecognizer *)sender;
@property (strong, nonatomic) IBOutlet UIView *noComment;
@property (strong, nonatomic) IBOutlet UIView *noCommentAndTuan;
@property (weak, nonatomic) IBOutlet UIImageView *lineImage;
@property (weak, nonatomic) IBOutlet UIView *nextContentView;
@end
