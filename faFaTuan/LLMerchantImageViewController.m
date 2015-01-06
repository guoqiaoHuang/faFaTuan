//
//  LLMerchantImageViewController.m
//  faFaTuan
//
//  Created by git on 14-12-25.
//  Copyright (c) 2014年 fafaS. All rights reserved.
//

#import "LLMerchantImageViewController.h"

@interface LLMerchantImageViewController (){
    NSArray *ary;
}

@end

@implementation LLMerchantImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [HCNavigationAndStatusBarTool setNavigationTitle:self andTitle:@"商家相册"];
    [HCNavigationAndStatusBarTool customLeftBackButton:self sel:@selector(goBack)];
    [_imageNumberLable setText:@""];

    //获得图片列表
    NSMutableDictionary *helpDic = [[NSMutableDictionary alloc]init];
    [helpDic setValue:_shopID forKey:@"shop_id"];
    [LLASIHelp requestWithURL:URL(@"/shop/photo") paramDic:helpDic resultBlock:^(NSDictionary *dic) {
        if (!dic) {
            SHOW(@"返回数据为空");
        }else{
            [_imageNumberLable setText:[NSString stringWithFormat:@"共%@张",[dic objectForKey:@"total_count"]]];
            ary = [dic objectForKey:@"data"];
            [self setImageView];
        }
    } cancelBlock:^{
        SHOW(@"获取数据失败");
    } httpMethod:@"GET"];
}
-(void)goBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)setImageView
{
    for (int i=0; i<[ary count]; i++) {
        UIImageView *imageView =[[UIImageView alloc]initWithFrame:CGRectMake(self.view.W*i, _myScrollerView.H/2- self.view.W/3, self.view.W, self.view.W*2/3)];
        [imageView setImage:[UIImage imageNamed:@"icon_loadingimage_merchang"]];
        [_myScrollerView addSubview:imageView];
        UILabel *lab =[[ UILabel alloc]initWithFrame:CGRectZero];
        [_myScrollerView addSubview:lab];
        
        NSString  *imgString =[ary[i] objectForKey:@"img_url"];
        NSURL *imgUrl=[NSURL URLWithString:imgString];
        [lab setText:imgString];
        if (hasCachedImage(imgUrl)) {
            [imageView setImage:[UIImage imageWithContentsOfFile:pathForURL(imgUrl)]];
        }else{
            NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:imgUrl,@"url",imageView,@"imageView",lab,@"urlMark",imgString,@"urlString",nil];
            [NSThread detachNewThreadSelector:@selector(cacheImage:) toTarget:[ImageCacher defaultCacher] withObject:dic];
        }
    }
    [_myScrollerView setContentSize:CGSizeMake(self.view.W*[ary count],0 )];
}

@end
