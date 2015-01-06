//
//  LLMoreSortViewController.m
//  faFaTuan
//
//  Created by git on 14-9-6.
//  Copyright (c) 2014年 fafaS. All rights reserved.
//

#import "LLMoreSortViewController.h"
#import "LLSortBulkViewController.h"
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
    animatImgView=[UIImageView startAnimationAt:self.myScrollview];
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
    UIEdgeInsets ed ={2,2,2,2};
    for (int i=0; i<[allData count]; i++) {
        NSDictionary *detailDic =[allData objectAtIndex:i];
        if (i==0) {
            UIImageView *allType =[UIImageView allocInitWithRect:CGRectMake(15, 15, self.myScrollview.W-15*2, 35) imgName:@"bg_morepage_subCell" view:self.myScrollview EdgeInsets:ed];
            UILabel *lab =[UILabel allocInitWith:allType.frame title:[detailDic objectForKey:@"name"]font:14 color:[UIColor darkGrayColor] view:self.myScrollview];
            [lab setTextAlignment:NSTextAlignmentCenter];

            UIButton *btn =[UIButton buttonWithType:UIButtonTypeCustom];
            [btn setFrame:allType.frame];
            [self.myScrollview addSubview:btn];
            [btn setTag:i*100+99];
            [btn addTarget:self action:@selector(nextPage:) forControlEvents:UIControlEventTouchUpInside];
            
        }else{
            UIView *before=[self.myScrollview viewWithTag:((i-1)*100+99)];
            UIImageView *markImg =[UIImageView allocInitWithRect:CGRectMake(15,before.endY+30, 17, 17) imgName:[detailDic objectForKey:@"uname"] view:self.myScrollview];
            [markImg setTag:i+1];
            [UILabel allocInitWith:CGRectMake(markImg.endX+5, markImg.Y, self.myScrollview.W-markImg.endX-5, 17) title:[detailDic objectForKey:@"name"] font:14 color:[UIColor darkGrayColor] view:self.myScrollview];

            NSArray *levelAry =[detailDic objectForKey:@"levelTwo"];
            for (int j=0; j<[levelAry count]; j++) {
                UIImageView *allType =[UIImageView allocInitWithRect:CGRectMake(15+((self.myScrollview.W-15*4)/3+12)*(j%3),markImg.endY+15+50*(j/3), (self.myScrollview.W-15*2-12*2)/3, 35) imgName:@"bg_morepage_subCell" view:self.myScrollview EdgeInsets:ed];
                if (j==([levelAry count]-1)) {
                    [allType setTag:i*100+99];
                }
               
                UILabel *lab =[UILabel allocInitWith:allType.frame title:[[levelAry objectAtIndex:j] objectForKey:@"name"]font:14 color:[UIColor darkGrayColor] view:self.myScrollview];
                [lab setTextAlignment:NSTextAlignmentCenter];
                
                UIButton *btn =[UIButton buttonWithType:UIButtonTypeCustom];
                [btn setFrame:allType.frame];
                [self.myScrollview addSubview:btn];
                [btn setTag:i*100+j];
                [btn addTarget:self action:@selector(nextPage:) forControlEvents:UIControlEventTouchUpInside];
                if (i==([allData count]-1)&&j==([levelAry count]-1)) {
                    [_myScrollview setContentSize:CGSizeMake(_myScrollview.W, btn.endY+30)];
                    return;
                }
            }
            if (i==[allData count]-1) {
                [_myScrollview setContentSize:CGSizeMake(_myScrollview.W, markImg.endY+30)];
            }
        }
    }
}
-(void)nextPage:(UIButton *)btn
{
    NSLog(@"%d",btn.tag);
    LLSortBulkViewController *next =[[LLSortBulkViewController alloc]init];
    next.typeName=[allData[btn.tag/100] objectForKey:@"name"];
    next.mark=(btn.tag/100);//如果  对应的id发生变化需要更改
    if (btn.tag/100!=0) {
        next.typeTwoName=[[allData[btn.tag/100] objectForKey:@"levelTwo"][btn.tag%100] objectForKey:@"name"];
        next.markTwo=btn.tag%100;
    }
    next.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:next animated:YES];

}
@end
