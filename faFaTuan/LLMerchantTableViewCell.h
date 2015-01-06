//
//  LLMerchantTableViewCell.h
//  faFaTuan
//
//  Created by git on 14-12-22.
//  Copyright (c) 2014年 fafaS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TQStarRatingView.h"
@interface LLMerchantTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *myImageView;
@property (weak, nonatomic) IBOutlet UILabel *myTitleLable;
@property (weak, nonatomic) IBOutlet TQStarRatingView *starView;
@property (weak, nonatomic) IBOutlet UILabel *evaluateNumLable;
@property (weak, nonatomic) IBOutlet UILabel *addressLable;
@property (weak, nonatomic) IBOutlet UILabel *markLable;

@end
