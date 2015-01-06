
//
//  LLBulkViewController.m
//  faFaTuan
//
//  Created by git on 14-8-12.
//  Copyright (c) 2014年 fafaS. All rights reserved.
#import "LLBulkViewController.h"
#import "ImageCacher.h"
#import "FileHelpers.h"
#import "LLBulkDetailViewController.h"

#import "LLSortBulkViewController.h"
#import "LLMoreSortViewController.h"
#define HEADER_COUNT 8


@interface LLBulkViewController (){
    NSArray *dataAry;
    NSArray *headerAry;
    
    UIImageView *animatImgView;
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
    //下拉刷新
    _refreshHeaderView= [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f-self.myTableView.H, self.view.W, self.myTableView.H)];
    _refreshHeaderView.delegate = self;
    [self.myTableView addSubview:_refreshHeaderView];

    [HCNavigationAndStatusBarTool setNavigationBackground:self];

    [self addTabbarLeft];
    animatImgView=[UIImageView startAnimationAt:self.view];
    [self getData];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark-
#pragma mark-为tableview加header footer 等
/**
 *  tabBar 左上角（应用名称 和地址）
 */
-(void)addTabbarLeft
{
    UIView *viewLab =[[UIView alloc]initWithFrame:CGRectMake(IOS7_OR_LATER?0:10, 0,self.view.W*2.0/3.0,TABBAR_HEIGHT)];
    UIImageView *appnames=[UIImageView allocInitWith:CGPointMake(viewLab.center.x-self.view.W/4, viewLab.center.y) imgName:@"发发团" view:viewLab];
    [UILabel allocInitWith:CGRectMake(appnames.endX+5, 0, viewLab.W/2.0, TABBAR_HEIGHT) title:@"孝感" font:15 color:[UIColor whiteColor] view:viewLab];
    self.navigationItem.leftBarButtonItem =[[UIBarButtonItem alloc] initWithCustomView:viewLab];
}
/**
 *  获取网络数据（如果没有网络使用缓存数据）
 */
-(void)getData
{
    NSDictionary *dic2 =@{@"parent_id":@"0"};
    [LLASIHelp requestWithURL:URL(@"/init/list_deal_cate") paramDic:dic2 resultBlock:^(NSDictionary *dic) {
        headerAry=[dic objectForKey:@"data"];
        [self getTableData];
    } cancelBlock:^{
        SHOW(@"获取数据失败");
        [UIImageView stopAnimation:animatImgView];
    } httpMethod:@"GET"];
}
-(void)getTableData
{
    NSDictionary *dic =@{@"count":@"20"};
    [LLASIHelp requestWithURL:URL(@"/deal/list_hotsale") paramDic:dic resultBlock:^(NSDictionary *dic) {
        dataAry=[dic objectForKey:@"data"];
        //停止动画
        [UIImageView stopAnimation:animatImgView];
        [self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:0.0];
        
        [self setHeader];
        [self setFoot];
        [_myTableView reloadData];
    } cancelBlock:^{
        SHOW(@"获取数据失败");
        [UIImageView stopAnimation:animatImgView];
    } httpMethod:@"GET"];

}
/**
 *  设置tableview的头（美食等一级分类）
 */
-(void)setHeader
{
    UIView *allView =[[UIView alloc]initWithFrame:CGRectMake(0,0,self.view.W,self.view.W/2+50)];
    //分割线以上的view
    UIView *views =[[UIView alloc]initWithFrame:CGRectMake(0,0,self.view.W,self.view.W/2)];
    [views setBackgroundColor:[UIColor whiteColor]];
    for (int i=0; i<HEADER_COUNT; i++) {
        UIImageView *imgView =[UIImageView allocInitWith:CGPointMake(views.W/8+(i%4)*views.W/4,views.H/4+(i/4)*views.H/2-7) imgName:(HEADER_COUNT-1)==i?@"more":[headerAry[i] objectForKey:@"uname"] view:views];
        UILabel *lab=[UILabel allocInitWith:CGRectMake((i%4)*views.W/4, imgView.endY+3, views.W/4, 21) title:(HEADER_COUNT-1)==i?@"更多分类":[headerAry[i] objectForKey:@"name"] font:12 color:[UIColor blackColor] view:views];
        [lab setTextAlignment:NSTextAlignmentCenter];
        UIButton *btn =[[UIButton alloc]initWithFrame:CGRectMake((i%4)*views.W/4, views.H/2*(i/4), views.W/4, views.H/2)];
        [btn setTag:(8000+i)];
        [views addSubview:btn];
        [btn addTarget:self action:@selector(choose:) forControlEvents:UIControlEventTouchUpInside];
    }
    [allView addSubview:views];
    
    //分割线以下的view
    UIView *view =[[UIView alloc]initWithFrame:CGRectMake(0,self.view.W/2, self.view.W, 50)];
    UIView *linesView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.W, 10)];
    [linesView setBackgroundColor:[UIColor colorWithRed:235.0/255 green:235.0/255 blue:241.0/255 alpha:1]];
    [view addSubview:linesView];
    [UILabel allocInitWith:CGRectMake(10,10, self.view.W-10,40) title:@"猜你喜欢" font:16 color:[UIColor blackColor] view:view];
    [allView addSubview:view];

    //设置边框线
    UIEdgeInsets edImage = {1.0f,1.0f,1.0f,1.0f};
    UIImageView *edImageView =[[UIImageView alloc]initWithFrame:allView.frame];
    UIImage *imgs =[UIImage imageNamed:@"cell_middle"];
    imgs = [imgs resizableImageWithCapInsets:edImage];
    [edImageView setImage:imgs];
    [edImageView setContentMode:UIViewContentModeScaleToFill];
    [allView  insertSubview:edImageView atIndex:0];

    _myTableView.tableHeaderView=allView;
}
-(void)choose:(UIButton*)btn
{
    if ((btn.tag-8000)==7) {
        LLMoreSortViewController *next =[[LLMoreSortViewController alloc]init];
        next.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:next animated:YES];
        return;
    }
    LLSortBulkViewController *next =[[LLSortBulkViewController alloc]init];
    next.typeName=[headerAry[btn.tag-8000] objectForKey:@"name"];
    next.mark=(btn.tag-8000)+1;//如果  对应的id发生变化需要更改
    next.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:next animated:YES];
}
/**
 *  设置tableview的尾（查看全部团购（button））
 */
-(void)setFoot
{
    UIView *views =[[UIView alloc]initWithFrame:CGRectMake(0, 50, self.view.W, 50)];
    [views setBackgroundColor:[UIColor colorWithRed:235.0/255 green:235.0/255 blue:241.0/255 alpha:1]];
    UIButton *btn =[UIButton buttonWithFrame:CGRectMake(10, 8, self.view.W-20,views.H-16) type:UIButtonTypeCustom title:@"查看全部团购" font:14 titleColor:[UIColor colorWithRed:25.0/255 green:182.0/255 blue:158.0/255 alpha:1]  normalImg:@"btn_homepage_hotdealMore_normal" selectedImg:nil tag:23000 subview:views isStretch:YES];
    [btn addTarget:self action:@selector(allBulk) forControlEvents:UIControlEventTouchUpInside];
    _myTableView.tableFooterView=views;
}
-(void)allBulk
{
    LLSortBulkViewController *next =[[LLSortBulkViewController alloc]init];
    next.typeName=@"全部分类";
    next.mark=0;
    next.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:next animated:YES];
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
    [cell.price setText:[dataAry[indexPath.row] objectForKey:@"current_price"]];
    [cell.originaPrice setText:[[dataAry[indexPath.row] objectForKey:@"origin_price"]stringByAppendingString:@"元"]];
    [cell.haveSales setText:[@"已售" stringByAppendingString:[dataAry[indexPath.row] objectForKey:@"sale_count"] ]];
    [cell.productImage setImage:[UIImage imageNamed:@"icon_loadingimage_merchang"]];
    //加载图片
    NSString *imgString =[IMG_URL stringByAppendingString:[dataAry[indexPath.row] objectForKey:@"img"]];
    cell.imageMark.text = imgString;//标记 要加载图片的 imageview是否已经加载图片
    NSURL *imgUrl=[NSURL URLWithString:imgString];
    if (hasCachedImage(imgUrl)) {
        [cell.productImage setImage:[UIImage imageWithContentsOfFile:pathForURL(imgUrl)]];
    }else{
        NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:imgUrl,@"url",cell.productImage,@"imageView",cell.imageMark,@"urlMark",imgString,@"urlString",nil];
        [NSThread detachNewThreadSelector:@selector(cacheImage:) toTarget:[ImageCacher defaultCacher] withObject:dic];
    }
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
    LLBulkDetailViewController *bulkDetail =[[LLBulkDetailViewController alloc]init];
    bulkDetail.bulkDic =dataAry[indexPath.row];
    bulkDetail.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:bulkDetail animated:YES];
}
#pragma mark -
#pragma mark 下拉刷新
//UIScrollViewDelegate Methods
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
	[_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
	[_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
}
//数据加载完成
- (void)doneLoadingTableViewData{
	_reloading = NO;
	[_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.myTableView];
}
//EGORefreshTableHeaderDelegate Methods
- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
	_reloading = YES;
    [self getData];
}
- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
	return _reloading;
}
@end
