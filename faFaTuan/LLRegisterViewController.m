//
//  LLRegisterViewController.m
//  faFaTuan
//
//  Created by git on 14-9-10.
//  Copyright (c) 2014年 fafaS. All rights reserved.
//

#import "LLRegisterViewController.h"

@interface LLRegisterViewController ()

@end

@implementation LLRegisterViewController

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
    [HCNavigationAndStatusBarTool setNavigationTitle:self andTitle:@"注册"];
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
- (IBAction)loginIn:(id)sender;
{
    if (_userName.text.length<4||_userName.text.length>18) {
        SHOW(@"用户名必须4-18位");
        return;
    }
    if (![_registePassword.text isEqualToString:_passWord.text]) {
        SHOW(@"输入密码不相符");
        return;
    }
    if (_registePassword.text.length<6||_registePassword.text.length>18) {
        SHOW(@"密码必须6—18位");
        return;
    }
    
    //获得分类列表
    NSDictionary *dic =@{@"user_name": _userName.text,@"user_pwd":_passWord.text};
    [LLASIHelp requestWithURLReInt:URL(@"/sign/reg") paramDic:dic resultBlock:^(int re) {
        switch (re) {
            case 0:
                SHOW(@"注册失败");
                break;
            case -1:
                SHOW(@"用户名已被注册");
                break;
            case -2:
                SHOW(@"用户名不能含@字符");
                break;
            case -3:
                SHOW(@"用户名不能以数字开头");
                break;
            case -4:
                SHOW(@"密码必须6—18位");
                break;
            case -5:
                SHOW(@"用户名必须6-18位");
                break;
            default:{
                [DefaultsStore setObject:_userName.text forKey:@"userName"];
                [DefaultsStore setObject:_passWord.text forKey:@"passWord"];
                [DefaultsStore setObject:[NSString stringWithFormat:@"%d",re] forKey:@"userID"];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"login" object:nil];
                int indexs=(int)[self.navigationController.viewControllers count]-3;
                if (indexs>=0) {
                    UIViewController *back =self.navigationController.viewControllers[indexs];
                    [self.navigationController popToViewController:back animated:YES];
                }
                break;
            }
        }
    } cancelBlock:^{
        SHOW(@"获取数据失败");
    } httpMethod:@"GET"];
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
@end
