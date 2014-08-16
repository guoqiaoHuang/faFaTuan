//
//  LLBulkTableViewCell.h
//  faFaTuan
//
//  Created by git on 14-8-14.
//  Copyright (c) 2014年 fafaS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LLBulkTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *productTitle;
@property (weak, nonatomic) IBOutlet UILabel *productDescribe;
@property (weak, nonatomic) IBOutlet UIImageView *productImage;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UILabel *priceUnit;
@property (weak, nonatomic) IBOutlet UILabel *originaPrice;
@property (weak, nonatomic) IBOutlet UILabel *haveSales;
@property (weak, nonatomic) IBOutlet UIView *lineView;
@end
