//
//  LLMineViewController.m
//  faFaTuan
//
//  Created by git on 14-9-11.
//  Copyright (c) 2014年 fafaS. All rights reserved.
//

#import "LLMineViewController.h"
#import "LLMineTableViewCell.h"

#import "LLLoginPassWordViewController.h"
#import "LLBindingPhoneViewController.h"
@interface LLMineViewController (){
    NSMutableArray * allAry;

}

@end

@implementation LLMineViewController

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
    [HCNavigationAndStatusBarTool setNavigationBackground:self];
    [HCNavigationAndStatusBarTool setNavigationTitle:self andTitle:@"我的账户"];
    [HCNavigationAndStatusBarTool customLeftBackButton:self sel:@selector(goBack)];
    [_myTableView registerNib:[UINib nibWithNibName:@"LLMineTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MineCell"];
    
    _myTableView.tableFooterView = _footerView;
    UIEdgeInsets ed ={2,2,2,2};
    [_turnButton setBackgroundImage:[[UIImage imageNamed:@"btn_green"] resizableImageWithCapInsets:ed] forState:UIControlStateNormal];
    [_turnButton setBackgroundImage:[[UIImage imageNamed:@"btn_green_highlighted"] resizableImageWithCapInsets:ed] forState:UIControlStateHighlighted];

    
    [self getData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)goBack
{
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)getData
{
    allAry = [[NSMutableArray alloc] initWithContentsOfFile: [[NSBundle mainBundle]pathForResource:@"mine" ofType:@"plist" ]] ;
    
}
#pragma mark -UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [allAry count];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return [allAry[section] count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    LLMineTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"MineCell"];
    NSDictionary *dic =allAry[indexPath.section][indexPath.row];
    [cell.headerImg setImage:[UIImage imageNamed:[dic objectForKey:@"img"]]];
    [cell.titleText setText:[dic  objectForKey:@"name"]];
    [cell.changeMark setText:[dic  objectForKey:@"mark"]];

    if (indexPath.section==1&&indexPath.row==2&&((NSString *)[_subDic  objectForKey:@"mobile"]).length==11) {
        NSRange range = NSMakeRange (3,4);
        [cell.subtitle setText:[[_subDic  objectForKey:@"mobile"] stringByReplacingCharactersInRange:range withString:@"****"]];
        [cell.titleText setText:@"绑定手机"];
        [cell.changeMark setText:@"修改"];
    }
    return cell;
}
#pragma mark -UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section==1&&indexPath.row==2) {
        LLBindingPhoneViewController *next  = [[LLBindingPhoneViewController alloc ]init];
        [self.navigationController pushViewController:next animated:YES];
    }else if (indexPath.section==1&&indexPath.row==1){
        LLLoginPassWordViewController *next =[[LLLoginPassWordViewController alloc]init];
        [self.navigationController pushViewController:next animated:YES];
    }
}
- (IBAction)turnOut:(UIButton *)sender {
    [[[UIAlertView alloc]initWithTitle:@"提示" message:@"是否要退出本账户" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil] show];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;
{
    if (buttonIndex==1) {
        [[NSNotificationCenter defaultCenter]postNotificationName:@"turnOut" object:nil];
        [DefaultsStore setObject:nil forKey:@"userName"];
        [DefaultsStore setObject:nil forKey:@"passWord"];
        [DefaultsStore setObject:nil forKey:@"userID"];
        [DefaultsStore synchronize];
        [self.navigationController popViewControllerAnimated:YES];

    }
}
@end
