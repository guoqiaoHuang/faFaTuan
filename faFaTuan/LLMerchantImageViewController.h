//
//  LLMerchantImageViewController.h
//  faFaTuan
//
//  Created by git on 14-12-25.
//  Copyright (c) 2014年 fafaS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageCacher.h"
#import "FileHelpers.h"

@interface LLMerchantImageViewController : UIViewController
@property (nonatomic,strong)NSString *shopID;
@property (weak, nonatomic) IBOutlet UILabel *imageNumberLable;
@property (weak, nonatomic) IBOutlet UIScrollView *myScrollerView;
@end
