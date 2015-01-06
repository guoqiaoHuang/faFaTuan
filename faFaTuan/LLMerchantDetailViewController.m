//
//  LLMerchantDetailViewController.m
//  faFaTuan
//
//  Created by git on 14-12-24.
//  Copyright (c) 2014年 fafaS. All rights reserved.
//

#import "LLMerchantDetailViewController.h"
#import "LLMerchantImageViewController.h"

#import "LLMapViewController.h"
#import "LLMerchTableViewCell.h"
#import "LLBulkDetailViewController.h"

#import "LLCommentViewController.h"
@interface LLMerchantDetailViewController (){
    UIImageView *animatImgView;
    
    NSDictionary *allDataDic;
    NSArray *cellArray;
}

@end

@implementation LLMerchantDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [HCNavigationAndStatusBarTool setNavigationTitle:self andTitle:@"商家详情"];
    [HCNavigationAndStatusBarTool customLeftBackButton:self sel:@selector(goBack)];
    
    animatImgView=[UIImageView startAnimationAt:self.view];
    [_myTableView registerNib:[UINib nibWithNibName:@"LLMerchTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"merchCell"];
    [self getData];
}
-(void)goBack
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)getData
{
    allDataDic =[[NSDictionary alloc]init];
    cellArray = [[NSArray alloc]init];
    NSMutableDictionary *dic =[[NSMutableDictionary alloc]init];
    [dic setObject:[_merchantDic objectForKey:@"shop_id"] forKey:@"shop_id"];
    
    //获得街道列表
    [LLASIHelp requestWithURL:URL(@"/shop/detail") paramDic:dic resultBlock:^(NSDictionary *dic) {
        if (!dic) {
            SHOW(@"返回数据为空");
        }else{
            allDataDic = dic;
            cellArray =[dic objectForKey:@"data_deal"];
        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            float height=0;
            if ([[allDataDic objectForKey:@"comment_total_count"] isEqualToString:@"0"]&&([cellArray count]>0)) {
                height= 50;//没有评论  footer的高度
            }else if([[allDataDic objectForKey:@"comment_total_count"] isEqualToString:@"0"]&&([cellArray count]==0)){
                height=90;//没有评论没有团购信息  footer的高度
            }
            else if ([cellArray count]==0){
                height=236;//有评论没有团购信息  footer的高度
            }else{
                height= 196;//有评论有团购信息   footer的高度
            }
            height = (height+161+[cellArray count]*80)>self.view.H?self.view.H:height+161+[cellArray count]*80;
            if (height<self.view.H) {
                [self.myTableView setBounces:NO];
            }
            [self.myTableView setFrame:CGRectMake(0, 0, self.view.W,height)];
            
            [self.myTableView reloadData];
            //停止动画
            [UIImageView stopAnimation:animatImgView];
            [_myTableView setHidden:NO];
            [self setHeader];
            [self setFooter];
            
        });
        
    } cancelBlock:^{
        SHOW(@"获取数据失败");
        [UIImageView stopAnimation:animatImgView];
    } httpMethod:@"GET"];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)setHeader
{
    _myTableView.tableHeaderView=_headerView;
    
    [_headerTitleLable setText:[allDataDic objectForKey:@"shop_name"]];
    float rate = [[allDataDic objectForKey:@"rate"] floatValue];
    if (rate>=0&&rate<=5) {
        [_starView setScore:rate/5 withAnimation:NO];
        [_starView setIsCanTouch:NO];
    }
    [_rateLable setText:[NSString stringWithFormat:@"%.1f",rate]];
    [_addressLable setText:[allDataDic objectForKey:@"address"]];
    
    NSString  *imgString =[NSString stringWithFormat:@"%@/shop_head/460.280/%@",[allDataDic objectForKey:@"img_domain"],[allDataDic objectForKey:@"head_img"]];
    NSURL *imgUrl=[NSURL URLWithString:imgString];
    [_markImg setText:imgString];
    if (hasCachedImage(imgUrl)) {
        [_headerImageView setImage:[UIImage imageWithContentsOfFile:pathForURL(imgUrl)]];
    }else{
        NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:imgUrl,@"url",_headerImageView,@"imageView",_markImg,@"urlMark",imgString,@"urlString",nil];
        [NSThread detachNewThreadSelector:@selector(cacheImage:) toTarget:[ImageCacher defaultCacher] withObject:dic];
    }

}
- (IBAction)moreImage:(UITapGestureRecognizer *)sender {
    LLMerchantImageViewController *nextImageView = [[LLMerchantImageViewController alloc] init];
    nextImageView.shopID=[_merchantDic objectForKey:@"shop_id"];
    [self.navigationController pushViewController:nextImageView animated:YES];
}
- (IBAction)goMapView:(UITapGestureRecognizer *)sender {
    LLMapViewController *mapView =[[LLMapViewController alloc]init];
    mapView.longitude =[allDataDic objectForKey:@"lng"];
    mapView.latitude =[allDataDic objectForKey:@"lat"];
    mapView.shopName = [allDataDic objectForKey:@"shop_name"];
    [self.navigationController pushViewController:mapView animated:YES];
}
- (IBAction)telPhoneButton:(UIButton *)sender {
    NSString *phone = [allDataDic objectForKey:@"phone"];
    if (phone != nil) {
        NSString *telUrl = [NSString stringWithFormat:@"telprompt:%@",phone];
        NSURL *url = [[NSURL alloc] initWithString:telUrl];
        [[UIApplication sharedApplication] openURL:url];
    }
}

-(void)setFooter
{
    if ([[allDataDic objectForKey:@"comment_total_count"] isEqualToString:@"0"]&&[cellArray count]>0) {
        _myTableView.tableFooterView =_noComment;
        return;
    }else if([[allDataDic objectForKey:@"comment_total_count"] isEqualToString:@"0"]&&[cellArray count]==0){
        _myTableView.tableFooterView =_noCommentAndTuan;
        return;
    }
    _myTableView.tableFooterView = _footerView;
    //没有团购 但是有评论
    if ([cellArray count]==0) {
        [_footerView setFrame:CGRectMake(_footerView.X, _footerView.Y, _footerView.W, _footerView.H+40)];
        for (UIView *views in _footerView.subviews) {
            [views setFrame:CGRectMake(views.X, views.Y+40, views.W, views.H)];
        }
        UILabel *myLable = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, self.view.W, 20)];
        [myLable setText:@"没有团购信息"];
        [myLable setFont:[UIFont systemFontOfSize:14]];
        [myLable setTextColor:[UIColor lightGrayColor]];
        [_myTableView.tableFooterView  addSubview:myLable];
        _myTableView.tableFooterView = _footerView;
    }
    NSDictionary *footerDic = [[allDataDic objectForKey:@"data_comment"] firstObject];
    [_commentName setText:[footerDic objectForKey:@"user_name"]];
    [_commentsLable setText:[footerDic objectForKey:@"content"]];
    [_commentStar setScore:[[footerDic objectForKey:@"global_point"] floatValue]/5 withAnimation:NO];
    _commentStar.isCanTouch = NO;
    [_commentNext setText:[NSString stringWithFormat:@"查看全部%@条评论",[allDataDic objectForKey:@"comment_total_count"]]];
    
    CGSize priceSize =[NSString getSizeForWith:_commentsLable.text fontSize:14.0];
    
    [_commentsLable setFrame:CGRectMake(_commentsLable.X, _commentsLable.Y, _commentsLable.W, priceSize.height)];
    [_lineImage setFrame:CGRectMake(_lineImage.X, _lineImage.Y, _lineImage.W, 60+_commentsLable.H)];
    float oy = _nextContentView.endY;
    [_nextContentView setFrame:CGRectMake(_nextContentView.X, _lineImage.endY, _nextContentView.W, _nextContentView.H)];
    oy = oy-_nextContentView.endY;
    [_footerView setFrame:CGRectMake(_footerView.X, _footerView.Y, _footerView.W, _footerView.H-oy)];
    _myTableView.tableFooterView = _footerView;
    if (_myTableView.H<self.view.H) {
        [_myTableView setFrame:CGRectMake(_myTableView.X, _myTableView.Y, _myTableView.W, _myTableView.H-oy)];
    }
}

#pragma mark -------------UITableViewDataSource---------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [cellArray count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LLMerchTableViewCell  *tableCell= [tableView dequeueReusableCellWithIdentifier:@"merchCell"];
    if (indexPath.row==0) {
        [tableCell.myImageView setHidden:NO];
    }
    [tableCell.titleLable setText:[cellArray[indexPath.row] objectForKey:@"sub_title"]];
    [tableCell.nowPriceLable setText:[cellArray[indexPath.row] objectForKey:@"current_price"]];
    [tableCell.beforePriceLable setText:[[cellArray[indexPath.row] objectForKey:@"origin_price"] stringByAppendingString:@"元"]];
    [tableCell.sellLable setText:[@"已销" stringByAppendingString:[cellArray[indexPath.row] objectForKey:@"sale_count"]]];

    //加载图片
    NSString *imgString =[[cellArray[indexPath.row] objectForKey:@"img_domain"] stringByAppendingFormat:@"/deal/460.280/%@",[cellArray[indexPath.row] objectForKey:@"img"]];
    tableCell.imageMarkLable.text = imgString;//标记 要加载图片的 imageview是否已经加载图片
    NSURL *imgUrl=[NSURL URLWithString:imgString];
    if (hasCachedImage(imgUrl)) {
        [tableCell.imageViewFor setImage:[UIImage imageWithContentsOfFile:pathForURL(imgUrl)]];
    }else{
        NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:imgUrl,@"url",tableCell.imageViewFor,@"imageView",tableCell.imageMarkLable,@"urlMark",imgString,@"urlString",nil];
        [NSThread detachNewThreadSelector:@selector(cacheImage:) toTarget:[ImageCacher defaultCacher] withObject:dic];
    }

    return tableCell;
}
#pragma mark -------------UITableViewDelegate-----------------
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return 80;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    LLBulkDetailViewController *bulkDetail =[[LLBulkDetailViewController alloc]init];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]initWithDictionary:cellArray[indexPath.row]];
    [dic setObject:[allDataDic objectForKey:@"shop_name"] forKey:@"supplier_name"];
    bulkDetail.bulkDic =dic;
    [self.navigationController pushViewController:bulkDetail animated:YES];

}
- (IBAction)goCommentPage:(UITapGestureRecognizer *)sender {
    LLCommentViewController *next = [[LLCommentViewController alloc]init];
    next.shopID = [_merchantDic objectForKey:@"shop_id"];
    [self.navigationController pushViewController:next animated:YES];
}
@end
