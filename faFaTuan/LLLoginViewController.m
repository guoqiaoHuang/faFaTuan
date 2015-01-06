//
//  LLLoginViewController.m
//  faFaTuan
//
//  Created by git on 14-9-10.
//  Copyright (c) 2014年 fafaS. All rights reserved.
//

#import "LLLoginViewController.h"
#import "LLRegisterViewController.h"

@interface LLLoginViewController ()

@end

@implementation LLLoginViewController

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
    [HCNavigationAndStatusBarTool setNavigationTitle:self andTitle:@"登陆"];
    [HCNavigationAndStatusBarTool customLeftBackButton:self sel:@selector(goBack)];
    UIEdgeInsets ed ={2,2,2,2};
    [_loginBtn setBackgroundImage:[[UIImage imageNamed:@"btn_green"] resizableImageWithCapInsets:ed] forState:UIControlStateNormal];
    [_loginBtn setBackgroundImage:[[UIImage imageNamed:@"btn_green_highlighted"] resizableImageWithCapInsets:ed] forState:UIControlStateHighlighted];
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

- (IBAction)loginIn:(id)sender {
    NSDictionary *dic =@{@"user_name": _userName.text,@"user_pwd":_passWord.text};
    [LLASIHelp requestWithURLReInt:URL(@"/sign/check_login") paramDic:dic resultBlock:^(int re) {
        if (re==0) {
            SHOW(@"账号或密码错误");
        }else{
            [DefaultsStore setObject:_userName.text forKey:@"userName"];
            [DefaultsStore setObject:_passWord.text forKey:@"passWord"];
            [DefaultsStore setObject:[NSString stringWithFormat:@"%d",re] forKey:@"userID"];

            [[NSNotificationCenter defaultCenter] postNotificationName:@"login" object:nil];
            [self.navigationController popViewControllerAnimated:YES];
        }
    } cancelBlock:^{
        SHOW(@"获取数据失败");
    } httpMethod:@"POST"];

}
- (IBAction)resigerIn:(id)sender {
    LLRegisterViewController *registers =[[LLRegisterViewController alloc] init];
    [self.navigationController pushViewController:registers animated:YES];
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
@end
