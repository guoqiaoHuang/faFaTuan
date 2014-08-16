
//
//  LLBulkViewController.m
//  faFaTuan
//
//  Created by git on 14-8-12.
//  Copyright (c) 2014年 fafaS. All rights reserved.
//

#import "LLBulkViewController.h"
@interface LLBulkViewController (){
    NSArray *dataAry;
}

@end

@implementation LLBulkViewController

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
    [self addTabbarLeft];
    [self getData];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//tabBar 左上角
-(void)addTabbarLeft
{
    UIView *viewLab =[[UIView alloc]initWithFrame:CGRectMake(0, 0,self.view.W*2.0/3.0,TABBAR_HEIGHT)];
    UIImageView *appnames=[UIImageView allocInitWith:CGPointMake(viewLab.center.x-self.view.W/4, viewLab.center.y) imgName:@"发发团" view:viewLab];
    [UILabel allocInitWith:CGRectMake(appnames.endX+5, 0, viewLab.W/2.0, TABBAR_HEIGHT) title:@"孝感" font:15 color:[UIColor whiteColor] view:viewLab];
    self.navigationItem.leftBarButtonItem =[[UIBarButtonItem alloc] initWithCustomView:viewLab];
}
-(void)getData
{
    NSDictionary *dic =@{@"count":@"20"};
    [LLASIHelp requestWithURL:URL(@"/deal/list_hotsale") paramDic:dic resultBlock:^(NSDictionary *dic) {
        dataAry=[dic objectForKey:@"data"];
        [_myTableView reloadData];
    } cancelBlock:^{
        SHOW(@"获取数据失败");
    } httpMethod:@"POST"];
}
#pragma mark-
#pragma mark-UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return [dataAry count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    LLBulkTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"BulkCell"];
    [cell.productTitle setText:[dataAry[indexPath.row] objectForKey:@"supplier_name"]];
    [cell.productDescribe setText:[dataAry[indexPath.row] objectForKey:@"sub_title"]];
    [cell.price setText:[[dataAry[indexPath.row] objectForKey:@"current_price"] stringByReplacingOccurrencesOfString:@" " withString:@""]];
    [cell.originaPrice setText:[[[dataAry[indexPath.row] objectForKey:@"origin_price"]stringByAppendingString:@"元"] stringByReplacingOccurrencesOfString:@" " withString:@""]];
    [cell.haveSales setText:[@"已售" stringByAppendingString:[dataAry[indexPath.row] objectForKey:@"sale_count"] ]];
    [cell.productImage setImage:[UIImage imageNamed:@"icon_loadingimage_merchang"]];
    
    //添加图片
//    [LLASIHelp requestWithURL:URL(@"/deal/list_hotsale") paramDic:nil resultBlock:^(NSDictionary *dic) {
//        dataAry=[dic objectForKey:@"data"];
//        [_myTableView reloadData];
//    } cancelBlock:^{5
//        SHOW(@"获取数据失败");
//    } httpMethod:@"POST"];

    return cell;
}
#pragma mark-
#pragma mark-UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return 90;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
@end
