//
//  LLCommentTableViewCell.h
//  faFaTuan
//
//  Created by git on 14-12-31.
//  Copyright (c) 2014年 fafaS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TQStarRatingView.h"
@interface LLCommentTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *commmentNameLable;
@property (weak, nonatomic) IBOutlet TQStarRatingView *starView;
@property (weak, nonatomic) IBOutlet UILabel *commentLable;
@property (weak, nonatomic) IBOutlet UILabel *commentTime;
@property (weak, nonatomic) IBOutlet UIImageView *lineImageView;
@end
