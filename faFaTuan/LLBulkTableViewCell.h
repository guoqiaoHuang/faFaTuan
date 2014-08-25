//
//  LLBulkTableViewCell.h
//  faFaTuan
//
//  Created by git on 14-8-14.
//  Copyright (c) 2014年 fafaS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LLPriceView.h"
@interface LLBulkTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *productTitle;//商品名称
@property (weak, nonatomic) IBOutlet UILabel *productDescribe;//商品描述
@property (weak, nonatomic) IBOutlet UIImageView *productImage;//商品图片
@property (weak, nonatomic) IBOutlet UILabel *price;//商品价格
@property (weak, nonatomic) IBOutlet UILabel *priceUnit;
@property (weak, nonatomic) IBOutlet UILabel *originaPrice;//商品原价格
@property (weak, nonatomic) IBOutlet LLPriceView *priceViews;


@property (weak, nonatomic) IBOutlet UILabel *haveSales;//商品销量
@property (weak, nonatomic) IBOutlet UILabel *imageMark;//图片标记（缓存图片使用）
@end
