//
//  LLPriceView.h
//  faFaTuan
//
//  Created by git on 14-8-18.
//  Copyright (c) 2014年 fafaS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LLPriceView : UIView
@property (weak, nonatomic) IBOutlet UILabel *price;//商品价格
@property (weak, nonatomic) IBOutlet UILabel *priceUnit;
@property (weak, nonatomic) IBOutlet UILabel *originaPrice;//商品原价格
@end
