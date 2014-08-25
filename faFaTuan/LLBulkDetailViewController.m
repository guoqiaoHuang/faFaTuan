//
//  LLBulkDetailViewControllers.m
//  faFaTuan
//
//  Created by git on 14-8-25.
//  Copyright (c) 2014年 fafaS. All rights reserved.
//

#import "LLBulkDetailViewController.h"
#import "LLBulkDetailTableViewCell.h"
#import "ImageCacher.h"
#import "FileHelpers.h"
@interface LLBulkDetailViewController (){
    NSDictionary *allData;
    NSArray *imgAry;
}

@end

@implementation LLBulkDetailViewController

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
    [HCNavigationAndStatusBarTool setNavigationTitle:self andTitle:@"团购详情"];
    [HCNavigationAndStatusBarTool customLeftBackButton:self sel:@selector(goBack)];
    [self setTableHeader];
    [self getData];
}
-(void)goBack
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark-
#pragma mark tableView头
-(void)setTableHeader
{
    //加载初始图片
    NSString *imgString =[IMG_URL_WITH(460, 280) stringByAppendingString:[_bulkDic objectForKey:@"img"]];
    NSURL *imgUrl=[NSURL URLWithString:imgString];
    UILabel *lab =[UILabel allocInitWith:CGRectZero title:imgString font:14 color:[UIColor blackColor] view:_tableHeaderView];
    if (hasCachedImage(imgUrl)) {
        [_headerImageView setImage:[UIImage imageWithContentsOfFile:pathForURL(imgUrl)]];
    }else{
        NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:imgUrl,@"url",_headerImageView,@"imageView",lab,@"urlMark",imgString,@"urlString",nil];
        [NSThread detachNewThreadSelector:@selector(cacheImage:) toTarget:[ImageCacher defaultCacher] withObject:dic];
    }
    _myTableView.tableHeaderView =_tableHeaderView;
}
- (IBAction)viewImages:(id)sender;
{
    imgAry =[NSString getUrls:[allData objectForKey:@"description"]];
    [_viewImageView setFrame:WINDOW.frame];
    [_viewImageScroll setContentSize:CGSizeMake(WINDOW.W*[imgAry count], 0)];
    _imageMarkString.text =[_bulkDic objectForKey:@"supplier_name"];
    
    [_imageMarkString sizeToFit];
    [_imageMarkString setCenter:CGPointMake(20+_imageMarkString.W/2, _viewImageScroll.H*5/6)];
    [_viewPage setCenter:CGPointMake(_viewImageScroll.W-50, _viewImageScroll.H*5/6)];
    
    //布局标题  和页面
    
    [self addImagesAtScroll];
    _viewPage.text =[NSString stringWithFormat:@"1/%d",[imgAry count]];
    [WINDOW addSubview:_viewImageView];
}
-(void)addImagesAtScroll
{
    for (int i=0; i<[imgAry count]; i++) {
        UIImageView *imagView =[UIImageView allocInitWithRect:CGRectMake(i*_viewImageScroll.W, (_viewImageScroll.H-195)/2, _viewImageScroll.W, 195) imgName:nil view:_viewImageScroll];
        //加载多张图片
        NSString *imgString =imgAry[i];
        NSURL *imgUrl=[NSURL URLWithString:imgString];
        UILabel *lab =[UILabel allocInitWith:CGRectZero title:imgString font:14 color:[UIColor blackColor] view:_viewImageScroll];
        if (hasCachedImage(imgUrl)) {
            [imagView setImage:[UIImage imageWithContentsOfFile:pathForURL(imgUrl)]];
        }else{
            NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:imgUrl,@"url",imagView,@"imageView",lab,@"urlMark",imgString,@"urlString",nil];
            [NSThread detachNewThreadSelector:@selector(cacheImage:) toTarget:[ImageCacher defaultCacher] withObject:dic];
        }
    }

}
- (IBAction)hideImageView:(id)sender {
    [_viewImageView removeFromSuperview];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.tag==50000) {
        _viewPage.text =[NSString stringWithFormat:@"%d/%d",(int)(scrollView.contentOffset.x/scrollView.W)+1,[imgAry count]];
    }
}
//获取数据
-(void)getData
{
    NSDictionary *dic =@{@"deal_id":[_bulkDic objectForKey:@"deal_id"],@"buy_type":@"0"};
    [LLASIHelp requestWithURL:URL(@"/deal/deal_detail") paramDic:dic resultBlock:^(NSDictionary *dic) {
        allData=dic;
        [_myTableView reloadData];
    } cancelBlock:^{
        SHOW(@"获取数据失败");
    } httpMethod:@"GET"];

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark-
#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    LLBulkDetailTableViewCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"LLBulkDetailTableViewCell" owner:self options:nil] firstObject];
//    cell.title.text =[allData objectForKey:@""]
    
    return cell;
}
#pragma mark-
#pragma mark UITableViewDelegate
//设置selctionHeader
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section;
{
    if (!allData) {
        return nil;
    }
    _nowPrice.text=[NSString removeNoUseZero:[allData objectForKey:@"current_price"]];
    _originPrice.text=[[NSString removeNoUseZero:[allData objectForKey:@"origin_price"]] stringByAppendingString:@"元"];
    //为button加图片
    UIEdgeInsets ed = {10.0f,10.0f,10.0f,10.0f};
    [_ticketButton setBackgroundImage:[[UIImage imageNamed:@"btn_orange"] resizableImageWithCapInsets:ed] forState:UIControlStateNormal];
    [_ticketButton setBackgroundImage:[[UIImage imageNamed:@"btn_orange_highlighted"] resizableImageWithCapInsets:ed] forState:UIControlStateHighlighted];
    //为sectionVIew加背景图片
    UIImageView *imgViews =[[UIImageView alloc]initWithFrame:_sectionView.frame];
    [imgViews setImage:[[UIImage imageNamed:@"cell_middle"] resizableImageWithCapInsets:ed]];
    [_sectionView insertSubview: imgViews atIndex:0];
    return _sectionView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
{
    return 65;
}
- (IBAction)buyAtOnce:(id)sender;//马上购买
{
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return 600;//计算cell的高的
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
@end