//
//  LLLoginPassWordViewController.m
//  faFaTuan
//
//  Created by git on 15-1-3.
//  Copyright (c) 2015年 fafaS. All rights reserved.
//

#import "LLLoginPassWordViewController.h"

@interface LLLoginPassWordViewController ()

@end

@implementation LLLoginPassWordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [HCNavigationAndStatusBarTool setNavigationTitle:self andTitle:@"修改密码"];
    [HCNavigationAndStatusBarTool customLeftBackButton:self sel:@selector(goBack)];

    UIEdgeInsets ed ={2,2,2,2};
    [_okButton setBackgroundImage:[[UIImage imageNamed:@"btn_green"] resizableImageWithCapInsets:ed] forState:UIControlStateNormal];
    [_okButton setBackgroundImage:[[UIImage imageNamed:@"btn_green_highlighted"] resizableImageWithCapInsets:ed] forState:UIControlStateHighlighted];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)goBack
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)ok:(UIButton *)sender {
    if (![_originalPassWord.text isEqualToString:[DefaultsStore objectForKey:@"passWord"]]) {
        SHOW(@"原密码错误");
        return;
    }else if (![_newsPassWord.text isEqualToString:_confirmPassWord.text]){
        SHOW(@"两次输入新密码不同");
        return;
    }else if (_newsPassWord.text.length<6||_newsPassWord.text.length>18){
        SHOW(@"密码必须6—18位");
        return;
    }
    NSDictionary *dic =@{@"user_name":[DefaultsStore objectForKey:@"userName"],@"user_pwd":[DefaultsStore objectForKey:@"passWord"],@"old_pwd":[DefaultsStore objectForKey:@"passWord"],@"new_pwd":_newsPassWord.text};
    [LLASIHelp requestWithURLReInt:URL(@"/account/password") paramDic:dic resultBlock:^(int re) {
        if (re==0) {
            SHOW(@"旧密码错误");
        }else if (re==2){
            SHOW(@"系统异常");
        }else{
            SHOW(@"修改成功");
            [DefaultsStore setObject:_newsPassWord.text forKey:@"passWord"];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"login" object:nil];
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
    } cancelBlock:^{
        SHOW(@"获取数据失败");
    } httpMethod:@"GET"];

}
- (IBAction)beginTextField:(UITextField *)sender {
    [(UIImageView*)[self.view viewWithTag:sender.tag+10000] setHighlighted:YES];
}
- (IBAction)endTextField:(UITextField *)sender {
    [(UIImageView*)[self.view viewWithTag:sender.tag+10000] setHighlighted:NO];
}
@end
