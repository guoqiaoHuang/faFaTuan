//
//  LLBindingPhoneViewController.m
//  faFaTuan
//
//  Created by git on 15-1-3.
//  Copyright (c) 2015年 fafaS. All rights reserved.
//

#import "LLBindingPhoneViewController.h"

@interface LLBindingPhoneViewController (){
    NSTimer *timers;
    int time;
}

@end

@implementation LLBindingPhoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [HCNavigationAndStatusBarTool setNavigationTitle:self andTitle:@"绑定手机"];
    [HCNavigationAndStatusBarTool customLeftBackButton:self sel:@selector(goBack)];
    [self setButtonImage:_okButton];
    [self setButtonImage:_verifiButton];
}
-(void)setButtonImage:(UIButton *)btn
{
    UIEdgeInsets ed ={2,2,2,2};
    [btn setBackgroundImage:[[UIImage imageNamed:@"btn_green"] resizableImageWithCapInsets:ed] forState:UIControlStateNormal];
    [btn setBackgroundImage:[[UIImage imageNamed:@"btn_green_highlighted"] resizableImageWithCapInsets:ed] forState:UIControlStateHighlighted];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)goBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)begin:(UITextField *)sender {
    [(UIImageView*)[self.view viewWithTag:sender.tag+10000] setHighlighted:YES];
}
- (IBAction)end:(UITextField *)sender {
    [(UIImageView*)[self.view viewWithTag:sender.tag+10000] setHighlighted:NO];
}

- (IBAction)getVerNumber:(UIButton *)sender {
    if (_phoneNumberTextFild.text.length!=11) {
        SHOW(@"请输入正确的手机号");
        return;
    }
    NSDictionary *dic =@{@"user_name":[DefaultsStore objectForKey:@"userName"],@"user_pwd":[DefaultsStore objectForKey:@"passWord"],@"mobile":_phoneNumberTextFild.text};
    [LLASIHelp requestWithURLReInt:URL(@"/account/mobile") paramDic:dic resultBlock:^(int re) {
        switch (re) {
            case 0:
                SHOW(@"手机号已经被绑定");
                break;
            case 1:{
                [_verifiButton setEnabled:NO];
                [_okButton setEnabled:YES];
                
                [_timeLable setFrame:_verifiButton.frame];
                time=59;
                timers=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(verificationRepeat) userInfo:nil repeats:YES];
            }
                break;
            case 2:
                SHOW(@"手机号格式错误");
                break;
            case 3:
                SHOW(@"短信发送失败");
                break;
            default:
                break;
        }
    } cancelBlock:^{
        SHOW(@"获取数据失败");
    } httpMethod:@"GET"];

}
//验证码读秒
-(void)verificationRepeat
{
    if (time<0) {
        [timers invalidate];
        [_verifiButton setEnabled:YES];
        [_timeLable setFrame:CGRectZero];
        [_verifiButton setTitle:[NSString stringWithFormat:@"获取验证码"] forState:UIControlStateNormal];
    }else if (time==59){
        [_verifiButton setTitle:@"" forState:UIControlStateNormal];
    }
    _timeLable.text = [NSString stringWithFormat:@"%d秒后重发",time--];
}
- (IBAction)submitTextFiled:(UIButton *)sender {
    if (_phoneNumberTextFild.text.length!=11) {
        SHOW(@"请输入正确的手机号");
        return;
    }
    if (_verifiTextField.text.length!=6) {
        SHOW(@"请输入正确的验证码");
        return;
    }
    NSDictionary *dic =@{@"user_name":[DefaultsStore objectForKey:@"userName"],@"user_pwd":[DefaultsStore objectForKey:@"passWord"],@"mobile":_phoneNumberTextFild.text,@"valid_code":_verifiTextField.text};
    [LLASIHelp requestWithURLReInt:URL(@"/account/bind_mobile") paramDic:dic resultBlock:^(int re) {
        switch (re) {
            case 0:
                SHOW(@"验证码错误");
                break;
            case 1:{
                SHOW(@"绑定成功");
                [[NSNotificationCenter defaultCenter]postNotificationName:@"login" object:nil];            }
                [self.navigationController popToRootViewControllerAnimated:YES];
                break;
            case 2:
                SHOW(@"手机号格式错误");
                break;
            default:
                break;
        }
    } cancelBlock:^{
        SHOW(@"获取数据失败");
    } httpMethod:@"GET"];
}
@end
