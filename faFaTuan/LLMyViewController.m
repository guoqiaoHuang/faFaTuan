//
//  LLMyViewController.m
//  faFaTuan
//
//  Created by git on 14-8-12.
//  Copyright (c) 2014年 fafaS. All rights reserved.
//

#import "LLMyViewController.h"
#import "LLMeTableViewCell.h"
#import "LLLoginViewController.h"
#import "LLMineViewController.h"

@interface LLMyViewController (){
    NSArray *allData;
    NSDictionary *headerDic;
}

@end

@implementation LLMyViewController

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
    [HCNavigationAndStatusBarTool setNavigationBackground:self];
    [HCNavigationAndStatusBarTool setNavigationTitle:self andTitle:@"我的"];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginEd) name:@"login" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(turnOut) name:@"turnOut" object:nil];
    
    if (!IOS7_OR_LATER)
        _myTableView.separatorColor=UIColor.clearColor;
    headerDic =[[NSMutableDictionary alloc] init];
    [self getData];
    
    if ([DefaultsStore objectForKey:@"userName"]) {
        [self loginEd];
        [_userDetailView setHidden:NO];
    }else{
        [_userDetailView setHidden:YES];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)getData
{
    allData =@[@[@[@"团购订单",@"icon_mine_group_order"],@[@"预定订单",@"icon_mine_reservation_order"]],@[@[@"每日推荐",@"icon_mine_recommandation"]],@[@[@"会员",@"icon_mine_member"],@[@"我的抽奖",@"icon_mine_lottery"],@[@"我的代金券",@"icon_mine_voucher"]]];
    [_loginButton setBackgroundImage:[[UIImage imageNamed:@"btn_homepage_hotdealMore_normal"] resizableImageWithCapInsets:(UIEdgeInsets){2,2,2,2}] forState:UIControlStateNormal];
}
#pragma mark ---UITableViewDataSource---

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return [allData[section] count];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [allData count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LLMeTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"MeTableCell"];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [cell.myHeaderView setImage:[UIImage imageNamed:allData[indexPath.section][indexPath.row][1]]];
    [cell.myTextView setText:allData[indexPath.section][indexPath.row][0]];
    if (!IOS7_OR_LATER) {
        cell.backgroundColor=UIColor.clearColor;
        UIImageView *img =[[UIImageView alloc]initWithImage:[[UIImage imageNamed:@"cell_single"] resizableImageWithCapInsets:(UIEdgeInsets){2,2,2,2}]];
        [img setFrame:CGRectMake(0, 0, self.view.W, 47)];
        [cell insertSubview:img atIndex:0];
    }
    return cell;
}
#pragma mark ---UITableViewDelegate---
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    SHOW(@"近期上线");

}

- (IBAction)loginIn:(id)sender {
    LLLoginViewController *next = [[LLLoginViewController alloc]init];
    next.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:next animated:YES];
}
-(void)loginEd
{
    NSDictionary *dic =@{@"user_name":[DefaultsStore objectForKey:@"userName"],@"user_pwd":[DefaultsStore objectForKey:@"passWord"]};
    [LLASIHelp requestWithURL:URL(@"/account/user_info") paramDic:dic resultBlock:^(NSDictionary *dic) {
        [self setValue:dic];
        headerDic=dic;
        NSLog(@"%@",dic);
    } cancelBlock:^{
        SHOW(@"服务器出错");
    } httpMethod:@"POST"];

}
-(void)setValue:(NSDictionary *)dic
{
    [_userDetailView setHidden:NO];
    [_userName setText:[dic objectForKey:@"user_name"]];
    [_moneyLable setText:[NSString  stringWithFormat:@"%@元",[dic objectForKey:@"money"]]];
}
//    [_userName sizeToFit];
//    [_leaveImage setImage:[UIImage imageNamed:@"icon_mine_level0"]];
//    [_leaveImage setFrame:CGRectMake(_userName.endX+5, _leaveImage.Y, _leaveImage.W, _leaveImage.H)];

- (IBAction)setHeaderImage:(id)sender {
}

- (IBAction)mineInformation:(id)sender {
    LLMineViewController *next =[[LLMineViewController alloc]init];
    next.hidesBottomBarWhenPushed=YES;
    next.subDic =headerDic;
    [self.navigationController pushViewController:next animated:YES];
}
//注销
-(void)turnOut
{
    [_userDetailView setHidden:YES];
}
@end
