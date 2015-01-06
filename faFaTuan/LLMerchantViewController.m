//
//  LLMerchantViewController.m
//  faFaTuan
//
//  Created by git on 14-8-12.
//  Copyright (c) 2014年 fafaS. All rights reserved.
//

#import "LLMerchantViewController.h"


#import "DropDownListView.h"
#import "LLASIHelp.h"
#import "LLMerchantTableViewCell.h"
#import "ImageCacher.h"
#import "FileHelpers.h"

#import "LLMerchantDetailViewController.h"
#define drop_down_menu_h 40


@interface LLMerchantViewController (){
    NSMutableArray *chooseArray ;
    NSMutableArray *initArray;
    NSMutableArray *allArray;
    
    NSMutableArray *selectedArray;
    UIImageView *animatImgView;
    int allPage;
}

@end

@implementation LLMerchantViewController

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
    //    [_myTableView setFrame:CGRectMake(0, drop_down_menu_h, self.view.W, WINDOW.H-64-drop_down_menu_h-50)];
    [HCNavigationAndStatusBarTool setNavigationBackground:self];
    [self addTabbarLeft];
    
    pages=1;
    allPage=-1;
    _refreshHeaderView= [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f-self.myTableView.H, self.view.W, self.myTableView.H)];
    _refreshHeaderView.delegate = self;
    [self.myTableView addSubview:_refreshHeaderView];
    

    [self.myTableView registerNib:[UINib nibWithNibName:@"LLMerchantTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"SortBulks"];
    animatImgView=[UIImageView startAnimationAt:self.view];
    
    chooseArray =[[NSMutableArray alloc]init];
    selectedArray =[[NSMutableArray alloc]initWithObjects:@"0",@"0",@"0",@"-1", nil];
    allArray =[[NSMutableArray alloc]init];
    [self getDropDownData];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/**
 *  tabBar 左上角（应用名称 和地址）
 */
-(void)addTabbarLeft
{
    UIView *viewLab =[[UIView alloc]initWithFrame:CGRectMake(IOS7_OR_LATER?0:10, 0,self.view.W*2.0/3.0,TABBAR_HEIGHT)];
    UIImageView *appnames=[UIImageView allocInitWith:CGPointMake(viewLab.center.x-self.view.W/4, viewLab.center.y) imgName:@"发发团" view:viewLab];
    [UILabel allocInitWith:CGRectMake(appnames.endX+5, 0, viewLab.W/2.0, TABBAR_HEIGHT) title:@"商家" font:15 color:[UIColor whiteColor] view:viewLab];
    self.navigationItem.leftBarButtonItem =[[UIBarButtonItem alloc] initWithCustomView:viewLab];
}
#pragma mark -- 获取数据
-(void)getDropDownData
{
    initArray = [NSMutableArray arrayWithArray:@[@[@"全部分类",
                                                   [@"全部分类" stringByAppendingString:@"2"]],
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
                            @{@"name": @"评价最高",@"id": @"rate"}];
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
    
    refreshView = [[EGORefreshTableFooterView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.view.W,33)];
    refreshView.delegate = self;
    _myTableView.tableFooterView=refreshView;
    reloading = NO;
    
    [self getList:@"0" area:@"0" sort:@"default" page:1];
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
    [selectedArray replaceObjectAtIndex:section withObject:[NSString stringWithFormat:@"%ld",(long)index]];
    if (section==0) {
        [selectedArray replaceObjectAtIndex:section+3 withObject:[NSString stringWithFormat:@"%ld",(long)seIndex]];
    }
    //更新tableView
    pages=1;
    [self getList: [selectedArray[3] isEqualToString:@"-1"]?
     [chooseArray[0][[selectedArray[0] integerValue]] objectForKey:@"id"]
                 :[[chooseArray[0][[selectedArray[0] integerValue]] objectForKey:@"levelTwo"][[selectedArray[3] integerValue]]objectForKey:@"id"]
             area:[chooseArray[1][[selectedArray[1] integerValue]] objectForKey:@"id"]
             sort:[chooseArray[2][[selectedArray[2] integerValue]] objectForKey:@"id"]
             page:pages];
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
    [LLASIHelp requestWithURL:URL(@"/shop/list") paramDic:dic resultBlock:^(NSDictionary *dic) {
        allPage =[[dic objectForKey:@"total_count"] intValue];
        if (page==1) {
            allArray =[dic objectForKey:@"data"];
        }else{
            for (NSArray *ary in [dic objectForKey:@"data"]) {
                [allArray addObject:ary];
            }
        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self doneLoadingTableViewData];
            [self.myTableView reloadData];
            //停止动画
            [UIImageView stopAnimation:animatImgView];
            
        });
        
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
    LLMerchantTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SortBulks"];
    NSDictionary *dic =allArray[indexPath.row];
    [cell.myTitleLable setText:[dic objectForKey:@"shop_name"]];
    [cell.starView setScore:[[dic objectForKey:@"rate"] floatValue]/5 withAnimation:NO];
    cell.starView.isCanTouch = NO;
    [cell.evaluateNumLable setText:[NSString stringWithFormat:@"%@评价",[dic objectForKey:@"rate_total_count"]]];
    [cell.addressLable setText:[dic objectForKey:@"address"]];
    
    [cell.myImageView setImage:[UIImage imageNamed:@"icon_loadingimage_merchang"]];
    //加载图片
    NSString *imgString =[[dic objectForKey:@"img_domain"] stringByAppendingFormat:@"/shop_head/460.280/%@",[dic objectForKey:@"head_img"]];
    cell.markLable.text = imgString;//标记 要加载图片的 imageview是否已经加载图片
    NSURL *imgUrl=[NSURL URLWithString:imgString];
    if (hasCachedImage(imgUrl)) {
        [cell.myImageView setImage:[UIImage imageWithContentsOfFile:pathForURL(imgUrl)]];
    }else{
        NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:imgUrl,@"url",cell.myImageView,@"imageView",cell.markLable,@"urlMark",imgString,@"urlString",nil];
        [NSThread detachNewThreadSelector:@selector(cacheImage:) toTarget:[ImageCacher defaultCacher] withObject:dic];
    }
    return cell;
}
#pragma mark-
#pragma mark-UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return 75;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    LLMerchantDetailViewController *bulkDetail =[[LLMerchantDetailViewController alloc]init];
    bulkDetail.merchantDic =allArray[indexPath.row];
    bulkDetail.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:bulkDetail animated:YES];
}


#pragma mark -
#pragma mark 下拉刷新
//UIScrollViewDelegate Methods
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
	[_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
    
    [refreshView egoRefreshScrollViewDidScroll:scrollView];//上拉加载更多
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
	[_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
    
    [refreshView egoRefreshScrollViewDidEndDragging:scrollView];//上拉加载更多
}
//数据加载完成
- (void)doneLoadingTableViewData{
	_reloading = NO;
	[_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.myTableView];
    
    reloading = NO;//下拉加载更多
    [refreshView egoRefreshScrollViewDataSourceDidFinishedLoading:self.myTableView];
}
//EGORefreshTableHeaderDelegate Methods
- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
	_reloading = YES;
    pages=1;
    [self getList: [selectedArray[3] isEqualToString:@"-1"]?
     [chooseArray[0][[selectedArray[0] integerValue]] objectForKey:@"id"]
                 :[[chooseArray[0][[selectedArray[0] integerValue]] objectForKey:@"levelTwo"][[selectedArray[3] integerValue]]objectForKey:@"id"]
             area:[chooseArray[1][[selectedArray[1] integerValue]] objectForKey:@"id"]
             sort:[chooseArray[2][[selectedArray[2] integerValue]] objectForKey:@"id"]
             page:pages];
}
- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
	return _reloading;
}

#pragma mark - EGORefreshTableFooterDelegate
//出发下拉刷新动作，开始拉取数据
- (void)egoRefreshTableFooterDidTriggerRefresh:(EGORefreshTableFooterView*)view
{
    pages++;//下拉加载更多
    [self getList: [selectedArray[3] isEqualToString:@"-1"]?
     [chooseArray[0][[selectedArray[0] integerValue]] objectForKey:@"id"]
                 :[[chooseArray[0][[selectedArray[0] integerValue]] objectForKey:@"levelTwo"][[selectedArray[3] integerValue]]objectForKey:@"id"]
             area:[chooseArray[1][[selectedArray[1] integerValue]] objectForKey:@"id"]
             sort:[chooseArray[2][[selectedArray[2] integerValue]] objectForKey:@"id"]
             page:pages];
}
//返回当前刷新状态：是否在刷新
- (BOOL)egoRefreshTableFooterDataSourceIsLoading:(EGORefreshTableFooterView*)view
{
    return reloading;
}
-(BOOL)egoRefreshTableFooterIsEnd
{
    if (allPage!=-1&&[allArray count]>=allPage) {
        return YES;
    }else{
        return NO;
    }
}
@end
