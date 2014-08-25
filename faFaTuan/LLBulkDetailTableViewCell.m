//
//  LLBulkDetailTableViewCell.m
//  faFaTuan
//
//  Created by git on 14-8-19.
//  Copyright (c) 2014年 fafaS. All rights reserved.
//

#import "LLBulkDetailTableViewCell.h"

@implementation LLBulkDetailTableViewCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)layoutSubviews
{
    //评价
    float scores =[_score.text floatValue];
    for (int i=0; i<5; i++) {
        if(scores>=0.5&&scores<1){
            [_star[i] setImage:[UIImage imageNamed:@"icon_merchant_star_half"]];
        }else if(scores>=1){
            [_star[i] setImage:[UIImage imageNamed:@"icon_merchant_star_full"]];
        }else{
            [_star[i] setImage:[UIImage imageNamed:@"icon_merchant_star_empty"]];
        }
        scores=scores-1;
    }
    [_package loadHTMLString:_packageStr baseURL:nil];
    [_purchase loadHTMLString:_purchaseStr baseURL:nil];
    //适配webview
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self fitWebView];
    });
}
- (IBAction)call:(id)sender {
    if (!_phone) {
        return;
    }
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[@"tel://" stringByAppendingString:_phone ]]];
}
-(void)fitWebView
{
    [_package sizeToFit];
    [_purchase sizeToFit];
    [self banScrool:_package];
    [self banScrool:_purchase];

    
    [_packageTopView setFrame:CGRectMake(_packageTopView.X, _packageTopView.Y, _packageTopView.W, _package.endY+2)];
    [_packageImage setFrame:_package.frame];
    
    [_purchaseTopView setFrame:CGRectMake(_purchaseTopView.X, _packageTopView.endY+10, _purchaseTopView.W, _purchase.endY+2)];
    [_purchaseImage setFrame:_purchase.frame];
    
    [self setFrame:CGRectMake(self.X, self.Y, self.W, _purchaseTopView.endY+10)];
}
-(void)banScrool:(UIWebView *)web
{
    UIScrollView *scroller = [web.subviews objectAtIndex:0];
    if (scroller){
        scroller.bounces = NO;
        scroller.alwaysBounceVertical = NO;
        scroller.alwaysBounceHorizontal = NO;
    }
}
@end
