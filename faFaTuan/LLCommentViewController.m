//
//  LLCommentViewController.m
//  faFaTuan
//
//  Created by git on 14-12-31.
//  Copyright (c) 2014年 fafaS. All rights reserved.
//

#import "LLCommentViewController.h"
#import "LLCommentTableViewCell.h"
@interface LLCommentViewController (){
    NSMutableArray *allAry;
}

@end

@implementation LLCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [HCNavigationAndStatusBarTool setNavigationTitle:self andTitle:@"评论"];
    [HCNavigationAndStatusBarTool customLeftBackButton:self sel:@selector(goBack)];
    // Do any additional setup after loading the view from its nib.
    [_myTableView registerNib:[UINib nibWithNibName:@"LLCommentTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"commentCell"];
    [_myTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self getData];
}
-(void)getData
{
    NSMutableDictionary *dic =[[NSMutableDictionary alloc]init];
    [dic setObject:_shopID forKey:@"shop_id"];
    //获得街道列表
    [LLASIHelp requestWithURL:URL(@"/shop/comment") paramDic:dic resultBlock:^(NSDictionary *dic) {
        if (!dic) {
            SHOW(@"返回数据为空");
        }else{
            allAry =[dic objectForKey:@"data"];
            [self.myTableView reloadData];
        }
    } cancelBlock:^{
        SHOW(@"获取数据失败");
    } httpMethod:@"GET"];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)goBack
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark ------------UITableViewDataSource-----------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return  [allAry count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    LLCommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"commentCell"];
    NSDictionary *dic = allAry[indexPath.row];
    cell.commmentNameLable.text = [dic objectForKey:@"user_name"];
    cell.commentLable.text = [dic objectForKey:@"content"];
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[[dic objectForKey:@"create_time"] integerValue]];
    
    cell.commentTime.text =  [formatter stringFromDate:date];
    [cell.starView setScore:[[dic objectForKey:@"global_point"] floatValue]/5 withAnimation:NO];
    [cell.starView setIsCanTouch:NO];
    return cell;
}
#pragma mark ------------UITableViewDelegate-----------------
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    NSString *cellComment = [allAry[indexPath.row] objectForKey:@"content"];
    CGSize commentSize =[NSString getSizeForWith:cellComment fontSize:14.0];
    return commentSize.height+80-30;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
@end
