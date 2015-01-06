//
//  LLMerchTableViewCell.h
//  faFaTuan
//
//  Created by git on 14-12-25.
//  Copyright (c) 2014年 fafaS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LLMerchTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *myImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLable;
@property (weak, nonatomic) IBOutlet UILabel *nowPriceLable;
@property (weak, nonatomic) IBOutlet UILabel *yuanLable;
@property (weak, nonatomic) IBOutlet UILabel *beforePriceLable;
@property (weak, nonatomic) IBOutlet UILabel *sellLable;
@property (weak, nonatomic) IBOutlet UILabel *imageMarkLable;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewFor;
@end
