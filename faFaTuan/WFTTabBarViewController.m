//
//  WFTTabBarViewController.m
//  微付通
//
//  Created by git on 14-8-11.
//  Copyright (c) 2014年 发发团. All rights reserved.
//

#import "WFTTabBarViewController.h"
#define TabBarNumber 4
#define TabBarHeight 49
#define TabBarWidth self.view.frame.size.width/TabBarNumber
#define TagM 2000
#define TagD 10


@interface WFTTabBarViewController (){
    UIView *myTabBar;
    NSArray *itemNames;//item的名称
    NSArray *itemPicker;//item未被选中时的图片
    NSArray *itemPickerSelected;//item被选中时的图片
}

@end

@implementation WFTTabBarViewController

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
	// Do any additional setup after loading the view.
    itemNames =@[@"团购",@"商家",@"我的",@"更多"];
    itemPicker =@[@"icon_tabbar_homepage",@"icon_tabbar_merchant_normal",@"icon_tabbar_mine",@"icon_tabbar_misc"];
    itemPickerSelected =@[@"icon_tabbar_homepage_selected",@"icon_tabbar_merchant_selected"
                          ,@"icon_tabbar_mine_selected",@"icon_tabbar_misc_selected"];
    //将自定义的view 覆盖到TabBar之上
    myTabBar = [[UIView alloc]initWithFrame:CGRectMake(0,0, self.view.frame.size.width, TabBarHeight)];
    [myTabBar setBackgroundColor:[UIColor whiteColor]];
    for (int i=0; i<TabBarNumber; i++) {
        //在TabBar 上加透明的btn
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(i*TabBarWidth,0,TabBarWidth, TabBarHeight)];
        [btn addTarget:self action:@selector(clickTabBar:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTag:i+TagM];
        //图标 btn
        UIButton *imgBtn =[[UIButton alloc]initWithFrame:CGRectMake(btn.frame.origin.x, btn.frame.origin.y, btn.frame.size.width, btn.frame.size.height*2.0/3.0)];
        [imgBtn setImage:[UIImage imageNamed:itemPicker[i]] forState:UIControlStateNormal];
        [imgBtn setImage:[UIImage imageNamed:itemPickerSelected[i]] forState:UIControlStateSelected];
        [imgBtn setTag:i+TagM+TagD];
        
        //文字 btn
        UIButton *lableBtn =[[UIButton alloc]initWithFrame:CGRectMake(btn.frame.origin.x, imgBtn.frame.origin.y+imgBtn.frame.size.height,  btn.frame.size.width, btn.frame.size.height*1.0/3.0)];
        [lableBtn setTitle:itemNames[i] forState:UIControlStateNormal];
        [lableBtn setTitle:itemNames[i] forState:UIControlStateSelected];
        
        [lableBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [lableBtn setTitleColor:[UIColor colorWithRed:47.0/255 green:172.0/255 blue:160.0/255 alpha:1.0] forState:UIControlStateSelected];

        lableBtn.titleLabel.font =[UIFont systemFontOfSize:10];
        [lableBtn setTag:i+TagM+TagD*2];
        
        [myTabBar addSubview:imgBtn];
        [myTabBar addSubview:lableBtn];
        [myTabBar addSubview:btn];
    }
    [((UIButton *)[myTabBar viewWithTag:TagM+TagD]) setSelected:YES];
    [((UIButton *)[myTabBar viewWithTag:TagM+TagD*2]) setSelected:YES];
    [self.tabBar addSubview:myTabBar ];

}
-(void)clickTabBar:(UIButton *)sender
{
    for (int i=0; i<TabBarNumber; i++) {
        if (sender.tag==i+TagM) {
            [((UIButton *)[myTabBar viewWithTag:i+TagM+TagD]) setSelected:YES];
            [((UIButton *)[myTabBar viewWithTag:i+TagM+TagD*2]) setSelected:YES];
        }else{
            [((UIButton *)[myTabBar viewWithTag:i+TagM+TagD]) setSelected:NO];
            [((UIButton *)[myTabBar viewWithTag:i+TagM+TagD*2]) setSelected:NO];
        }
    }
    self.selectedIndex =sender.tag-TagM;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end

