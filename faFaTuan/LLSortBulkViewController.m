//
//  LLSortBulkViewController.m
//  faFaTuan
//
//  Created by git on 14-8-26.
//  Copyright (c) 2014年 fafaS. All rights reserved.
//

#import "LLSortBulkViewController.h"
#import "DropDownListView.h"
#import "LLASIHelp.h"
#import "LLSortBulkTableViewCell.h"
#import "ImageCacher.h"
#import "FileHelpers.h"

#import "LLBulkDetailViewController.h"
#define drop_down_menu_h 40
@interface LLSortBulkViewController (){
    NSMutableArray *chooseArray ;
    NSMutableArray *initArray;
    NSMutableArray *allArray;
    
    NSMutableArray *selectedArray;
    UIImageView *animatImgView;
}


@end

@implementation LLSortBulkViewController

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
    [HCNavigationAndStatusBarTool setNavigationTitle:self andTitle:_typeName];
    [HCNavigationAndStatusBarTool customLeftBackButton:self sel:@selector(goBack)];
    
    _refreshHeaderView= [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f-self.myTableView.H, self.view.W, self.myTableView.H)];
    _refreshHeaderView.delegate = self;
    [self.myTableView addSubview:_refreshHeaderView];
    
    chooseArray =[[NSMutableArray alloc]init];
    selectedArray =[[NSMutableArray alloc]initWithObjects:[NSString stringWithFormat:@"%d",_mark],@"0",@"0",@"-1", nil];
    
    [self.myTableView registerNib:[UINib nibWithNibName:@"LLSortBulkTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"SortBulks"];
    [self.myTableView setFrame:CGRectMake(0, drop_down_menu_h, self.view.W, WINDOW.H-20-drop_down_menu_h-(IOS7_OR_LATER?0:44))];

    animatImgView=[UIImageView startAnimationAt:self.view];
    [self getDropDownData];
    allArray =[[NSMutableArray alloc]init];
    // Do any additional setup after loading the view from its nib.
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
#pragma mark -- 获取数据
-(void)getDropDownData
{
    initArray = [NSMutableArray arrayWithArray:@[@[_typeName,
                                                   [_typeName stringByAppendingString:@"2"]],
                                                 @[@"icon_dropdown_location_normal",
                                                   @"icon_dropdown_location_selected"],
                                                 @[@"icon_dropdown_sort_normal",
                                                   @"icon_dropdown_sort_selected"]]];
    //获得分类列表
    NSDictionary *dic =@{@"parent_id": @"-1"};
    [LLASIHelp requestWithURL:URL(@"/init/list_deal_cate") paramDic:dic resultBlock:^(NSDictionary *dic) {
        NSMutableArray *sortAry =[self sortArray:[dic objectForKey:@"data"]];
        [chooseArray addObject:sortAry];
        [self getAreaData];
        
    } cancelBlock:^{
        SHOW(@"获取数据失败");
        [UIImageView stopAnimation:animatImgView];
    } httpMethod:@"GET"];
    
}
-(void)getAreaData
{
    //获得街道列表
    [LLASIHelp requestWithURL:URL(@"/init/list_deal_area") paramDic:nil resultBlock:^(NSDictionary *dic) {
        NSMutableArray *areaAry =[dic objectForKey:@"data"];
        [areaAry insertObject:@{@"name": @"全城",@"id":@"0"} atIndex:0];
        //排序属性
        NSArray *descAry =@[@{@"name": @"默认",@"id":@"default"},
                            @{@"name": @"评价最高",@"id": @"rate"},
                            @{@"name": @"最新发布",@"id": @"create_time"},
                            @{@"name": @"价格最高",@"id": @"price_desc"},
                            @{@"name": @"价格最低",@"id": @"price_asc"}];
        [chooseArray addObject:areaAry];
        [chooseArray addObject:descAry];
        [self addSection];
        
    } cancelBlock:^{
        SHOW(@"获取数据失败");
        [UIImageView stopAnimation:animatImgView];
    } httpMethod:@"GET"];
    
}
-(void)addSection
{
    DropDownListView * dropDownView = [[DropDownListView alloc] initWithFrame:CGRectMake(0,0, self.view.frame.size.width, drop_down_menu_h) dataSource:self delegate:self];
    dropDownView.mSuperView = self.view;
    [self.view addSubview:dropDownView];
    
    [self getList:[NSString stringWithFormat:@"%d",_mark==0?_mark:_mark+1000] area:@"0" sort:@"default" page:1];
}
-(NSMutableArray *)sortArray:(NSArray *)arys
{
    NSMutableArray *myAry= [[NSMutableArray alloc] init];
    for (NSDictionary *dic in arys) {
        if ([[dic objectForKey:@"parent_id"] isEqualToString:@"0"]) {
            NSMutableDictionary *levelOneDic =[[NSMutableDictionary alloc]init];
            
            for (NSString *key in [dic allKeys]) {
                [levelOneDic setObject:[dic objectForKey:key] forKey:key];
            }
            
            NSMutableArray *levelTwoAry= [[NSMutableArray alloc] init];
            for (NSDictionary *mydic in arys) {
                if ([[mydic objectForKey:@"parent_id"] isEqualToString:[dic objectForKey:@"id"]]) {
                    [levelTwoAry addObject:mydic];
                }
            }
            if ([levelTwoAry count]!=0) {
                [levelTwoAry insertObject:@{@"name": @"全部",@"id":[dic objectForKey:@"id"]} atIndex:0];
            }
            [levelOneDic setObject:levelTwoAry forKey:@"levelTwo"];
            [myAry addObject:levelOneDic];
        }
    }
    
    [myAry insertObject:@{@"name": @"全部分类",@"id":@"0",@"levelTwo":@[]} atIndex:0];
    
    return myAry;
}



#pragma mark -- dropDownListDelegate
-(void) chooseAtSection:(NSInteger)section index:(NSInteger)index seIndex:(NSInteger)seIndex
{
    [selectedArray replaceObjectAtIndex:section withObject:[NSString stringWithFormat:@"%d",index]];
    if (section==0) {
        [selectedArray replaceObjectAtIndex:section+3 withObject:[NSString stringWithFormat:@"%d",seIndex]];
    }
    //变换标题
    [HCNavigationAndStatusBarTool setNavigationTitle:self
                                            andTitle:[selectedArray[3] isEqualToString:@"-1"]||[selectedArray[3] isEqualToString:@"0"]?[chooseArray[0][[selectedArray[0] integerValue]] objectForKey:@"name"]:[[chooseArray[0][[selectedArray[0] integerValue]] objectForKey:@"levelTwo"][[selectedArray[3] integerValue]]objectForKey:@"name"]];
    //更新tableView
    [self getList: [selectedArray[3] isEqualToString:@"-1"]?
                     [chooseArray[0][[selectedArray[0] integerValue]] objectForKey:@"id"]
                     :[[chooseArray[0][[selectedArray[0] integerValue]] objectForKey:@"levelTwo"][[selectedArray[3] integerValue]]objectForKey:@"id"]
             area:[chooseArray[1][[selectedArray[1] integerValue]] objectForKey:@"id"]
             sort:[chooseArray[2][[selectedArray[2] integerValue]] objectForKey:@"id"]
             page:1];
}
#pragma mark -- dropdownList DataSource
//选项卡图片
-(NSArray *)sectionsImg
{
    return initArray;
}
//选项卡个数
-(NSInteger)numberOfSections
{
    if ([initArray count]!=[chooseArray count]) {
        NSLog(@"数据错误");
    }
    return [initArray count];
}
-(NSInteger)numberOfRowsInSection:(NSInteger)section
{
    NSArray *arry =chooseArray[section];
    return [arry count];
}
-(NSString *)titleInSection:(NSInteger)section index:(NSInteger) index
{
    return [chooseArray[section][index] objectForKey:@"name"];
}
-(NSInteger)defaultShowSection:(NSInteger)section
{
    if (section==0) {
        return _mark;
    }
    return 0;
}
//联动tableView
-(NSInteger)numOfRowsInSection:(NSInteger)section index:(NSInteger) index
{
    NSArray *arry =[chooseArray[section][index] objectForKey:@"levelTwo"];
    return [arry count];
}

-(UIImage *)imgInSection:(NSInteger)section index:(NSInteger) index
{//选项卡图片
    NSLog(@"%@",chooseArray[section][index]);
    return chooseArray[section][index];
}

-(NSString *)titleInIndex:(NSInteger)section index:(NSInteger) index seIndex:(NSInteger) seIndex
{
    return [[chooseArray[section][index] objectForKey:@"levelTwo"][seIndex] objectForKey:@"name"];
}
-(BOOL)isHaveTwoTableView:(NSInteger)section
{
    if (section==0) {
        return YES;
    }else{
        return NO;
    }
}





-(void)getList:(NSString *)typeID area:(NSString*)areaID sort:(NSString *)sort page:(int) page
{
    NSMutableDictionary *dic =[[NSMutableDictionary alloc]init];
    [dic setObject:typeID forKey:@"deal_cate_id"];
    [dic setObject:areaID forKey:@"deal_area_id"];
    [dic setObject:sort forKey:@"sort"];
    [dic setObject:[NSString stringWithFormat:@"%d",page] forKey:@"page"];

    [dic setObject:@"0" forKey:@"buy_type"];
    [dic setObject:@"20" forKey:@"page_size"];
    //获得街道列表
    [LLASIHelp requestWithURL:URL(@"/deal/list") paramDic:dic resultBlock:^(NSDictionary *dic) {
        allArray =[dic objectForKey:@"data"];
        [self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:0.0];
        [self.myTableView reloadData];

        //停止动画
        [UIImageView stopAnimation:animatImgView];
    } cancelBlock:^{
        SHOW(@"获取数据失败");
        [UIImageView stopAnimation:animatImgView];
    } httpMethod:@"GET"];
 
}
#pragma mark-
#pragma mark-UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return [allArray count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    LLSortBulkTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SortBulks"];
    [cell.productTitle setText:[allArray[indexPath.row] objectForKey:@"supplier_name"]];
    [cell.productDescribe setText:[allArray[indexPath.row] objectForKey:@"sub_title"]];
    [cell.price setText:[allArray[indexPath.row] objectForKey:@"current_price"]];
    [cell.originaPrice setText:[[allArray[indexPath.row] objectForKey:@"origin_price"]stringByAppendingString:@"元"]];
    [cell.haveSales setText:[@"已售" stringByAppendingString:[allArray[indexPath.row] objectForKey:@"sale_count"] ]];
    [cell.productImage setImage:[UIImage imageNamed:@"icon_loadingimage_merchang"]];
    //加载图片
    NSString *imgString =[IMG_URL stringByAppendingString:[allArray[indexPath.row] objectForKey:@"img"]];
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
    bulkDetail.bulkDic =allArray[indexPath.row];
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
    
    [self getList: [selectedArray[3] isEqualToString:@"-1"]?
     [chooseArray[0][[selectedArray[0] integerValue]] objectForKey:@"id"]
                 :[[chooseArray[0][[selectedArray[0] integerValue]] objectForKey:@"levelTwo"][[selectedArray[3] integerValue]]objectForKey:@"id"]
             area:[chooseArray[1][[selectedArray[1] integerValue]] objectForKey:@"id"]
             sort:[chooseArray[2][[selectedArray[2] integerValue]] objectForKey:@"id"]
             page:1];
}
- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
	return _reloading;
}
@end
