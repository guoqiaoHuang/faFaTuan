//
//  LLMoreSortViewController.m
//  faFaTuan
//
//  Created by git on 14-9-6.
//  Copyright (c) 2014年 fafaS. All rights reserved.
//

#import "LLMoreSortViewController.h"

@interface LLMoreSortViewController (){
    UIImageView *animatImgView;
    NSMutableArray*allData;
}

@end

@implementation LLMoreSortViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [HCNavigationAndStatusBarTool setNavigationTitle:self andTitle:@"更多分类"];
    [HCNavigationAndStatusBarTool customLeftBackButton:self sel:@selector(goBack)];
    animatImgView=[UIImageView startAnimationAt:self.view];
    [self getData];
}
-(void)goBack
{
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark  --数据--
-(void)getData
{
    //获得分类列表
    NSDictionary *dic =@{@"parent_id": @"-1"};
    [LLASIHelp requestWithURL:URL(@"/init/list_deal_cate") paramDic:dic resultBlock:^(NSDictionary *dic) {
        allData =[self sortArray:[dic objectForKey:@"data"]];
        [self setTheBtns];
        [UIImageView stopAnimation:animatImgView];
    } cancelBlock:^{
        SHOW(@"获取数据失败");
        [UIImageView stopAnimation:animatImgView];
    } httpMethod:@"GET"];

}
//对返回数据进行分组
-(NSMutableArray *)sortArray:(NSArray *)arys
{
    NSMutableArray *myAry= [[NSMutableArray alloc] init];
    for (NSDictionary *dic in arys) {
        if ([[dic objectForKey:@"parent_id"] isEqualToString:@"0"]) {
            NSMutableDictionary *levelOneDic =[[NSMutableDictionary alloc]init];
            
            for (NSString *key in [dic allKeys]) {
                [levelOneDic setObject:[dic objectForKey:key] forKey:key];
            }
            
            NSMutableArray *levelTwoAry= [[NSMutableArray alloc] init];
            for (NSDictionary *mydic in arys) {
                if ([[mydic objectForKey:@"parent_id"] isEqualToString:[dic objectForKey:@"id"]]) {
                    [levelTwoAry addObject:mydic];
                }
            }
            if ([levelTwoAry count]!=0) {
                [levelTwoAry insertObject:@{@"name": @"全部",@"id":[dic objectForKey:@"id"]} atIndex:0];
            }
            [levelOneDic setObject:levelTwoAry forKey:@"levelTwo"];
            [myAry addObject:levelOneDic];
        }
    }
    
    [myAry insertObject:@{@"name": @"全部分类",@"id":@"0",@"levelTwo":@[]} atIndex:0];
    
    return myAry;
}
#pragma mark  --设置btn--
-(void)setTheBtns
{
    
}
@end
