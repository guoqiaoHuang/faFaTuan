//
//  DropDownListView.m
//  DropDownDemo
//
//  Created by 王立龙 on 24-8-28.
//  Copyright (c) 2014年 王立龙. All rights reserved.
//

#import "DropDownListView.h"
#define SECTION_BTN_TAG_BEGIN   1000
#define SECTION_IV_TAG_BEGIN    3000
#define SECTION_IMG   6000
#define SECTION_TEXT   9000
@implementation DropDownListView{
    NSArray *imgArray;
    NSMutableArray *selectedAry;
    BOOL isHaveTwoTab;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
//加载初始header
- (id)initWithFrame:(CGRect)frame dataSource:(id)datasource delegate:(id) delegate
{
    self = [super initWithFrame:frame];
    if (self) {
        //为view 加上背景图片
        UIImageView *backImg =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [backImg setImage:[UIImage imageNamed:@"bg_dropdown_section.png"]];
        [self insertSubview:backImg atIndex:0];
        
        currentExtendSection = -1;
        self.dropDownDataSource = datasource;
        self.dropDownDelegate = delegate;
        selectedAry =[[NSMutableArray alloc]init];
        
        //下拉菜单头有几个btn
        NSInteger sectionNum =0;
        if ([self.dropDownDataSource respondsToSelector:@selector(numberOfSections)] ) {
            sectionNum = [self.dropDownDataSource numberOfSections];
        }
        if (sectionNum == 0) {
            self = nil;
        }
        imgArray=[[NSArray alloc]init];
        if ([self.dropDownDataSource respondsToSelector:@selector(sectionsImg)] ) {
            imgArray = [self.dropDownDataSource sectionsImg];
        }

        //初始化默认显示view
        CGFloat sectionWidth = frame.size.width/sectionNum;
        for (int i = 0; i <sectionNum; i++) {
            //选项卡
            UIButton *sectionBtn = [[UIButton alloc] initWithFrame:CGRectMake(sectionWidth*i, 1, sectionWidth, frame.size.height-2)];
            sectionBtn.tag = SECTION_BTN_TAG_BEGIN + i;
            [sectionBtn addTarget:self action:@selector(sectionBtnTouch:) forControlEvents:UIControlEventTouchUpInside];
            
            NSString *sectionBtnTitle = @"";
            if ([self.dropDownDataSource respondsToSelector:@selector(titleInSection:index:)]) {
                sectionBtnTitle = [self.dropDownDataSource titleInSection:i index:[self.dropDownDataSource defaultShowSection:i]];
            }
            [selectedAry addObject:[NSString stringWithFormat:@"%d",[self.dropDownDataSource defaultShowSection:i]]];

            UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(10+i*sectionWidth,(frame.size.height-15)/2, 15, 15)];
            [img setImage:[UIImage imageNamed:imgArray[i][0]]];
            [img setTag:(SECTION_IMG+i)];
            
            UILabel *labs =[[UILabel alloc]initWithFrame:CGRectMake(30+i*sectionWidth, img.frame.origin.y,sectionWidth-30-15, img.frame.size.height)];
            [labs setBackgroundColor:[UIColor clearColor]];
            [labs setText:sectionBtnTitle];
            [labs setTextColor:[UIColor colorWithRed:130.0/255 green:130.0/255  blue:130.0/255  alpha:1]];
            [labs setFont:[UIFont systemFontOfSize:13]];
            [labs setTag:(SECTION_TEXT+i)];

            
            [self addSubview:img];
            [self addSubview:labs];
            [self addSubview:sectionBtn];

            
            //指标图
            UIImageView *sectionBtnIv = [[UIImageView alloc] initWithFrame:CGRectMake(sectionWidth*i +(sectionWidth - 15), (self.frame.size.height-8)/2, 8, 8)];
            [sectionBtnIv setImage:[UIImage imageNamed:@"icon_dropdown_triangle_down.png"]];
            [sectionBtnIv setContentMode:UIViewContentModeScaleToFill];
            sectionBtnIv.tag = SECTION_IV_TAG_BEGIN + i;
            [self addSubview: sectionBtnIv];
            //分割图片
            if (i<sectionNum && i != 0) {
                UIImageView *lineImg =[[UIImageView alloc]initWithFrame:CGRectMake(sectionWidth*i, 0, 2, frame.size.height)];
                [lineImg setImage:[UIImage imageNamed:@"icon_dropdown_tabseperator_line.png"]];
                [self addSubview:lineImg];
            }
        }
    }
    return self;
}
//点击某个选项卡
-(void)sectionBtnTouch:(UIButton *)btn
{
    NSInteger section = btn.tag - SECTION_BTN_TAG_BEGIN;
    //有下拉菜单的时候下拉菜单设置
    [self dropDownTriangleDown];
    if (currentExtendSection == section) {
        [self hideExtendedChooseView];
    }else{
        currentExtendSection = section;
       UIImageView * currentIV = (UIImageView *)[self viewWithTag:SECTION_IV_TAG_BEGIN + currentExtendSection];
       [currentIV setImage:[UIImage imageNamed:@"icon_dropdown_triangle_up.png"]];

       UIImageView * img = (UIImageView *)[self viewWithTag:SECTION_IMG + currentExtendSection];
       [img setImage:[UIImage imageNamed:imgArray[section][1]]];

        if (currentExtendSection==0) {
            UIImageView * img = (UIImageView *)[self viewWithTag:SECTION_IMG+currentExtendSection];
            [img setImage:[UIImage imageNamed:   [[self.dropDownDataSource titleInSection:currentExtendSection index:[selectedAry[0] integerValue]] stringByAppendingString:@"2"]]];
        }
        UILabel * lab = (UILabel *)[self viewWithTag:SECTION_TEXT + currentExtendSection];
        [lab setTextColor:[UIColor colorWithRed:25.0/255 green:182.0/255 blue:158.0/255 alpha:1]];
        
        [self showChooseListViewInSection:currentExtendSection choosedIndex:[self.dropDownDataSource defaultShowSection:currentExtendSection]];
    }

}

- (void)setTitle:(NSString *)title inSection:(NSInteger) section
{
    UIButton *btn = (id)[self viewWithTag:SECTION_BTN_TAG_BEGIN +section];
    [btn setTitle:title forState:UIControlStateNormal];
}

//隐藏下拉菜单
-  (void)hideExtendedChooseView
{
    if (currentExtendSection != -1) {
        currentExtendSection = -1;
        CGRect rect = self.mTableView.frame;
        rect.size.height = 0;
        
        CGRect rect1 = self.nTableView.frame;
        rect1.size.height = 0;
        [UIView animateWithDuration:0.3 animations:^{
            
            self.mTableBaseView.alpha = 0.2f;
            self.mTableView.alpha = 0.2;
            self.nTableView.alpha = 0.2;

            self.mTableView.frame = rect;
            self.nTableView.frame = rect1;
        }completion:^(BOOL finished) {
            [self.mTableView removeFromSuperview];
            [self.mTableBaseView removeFromSuperview];
            [self.nTableView  removeFromSuperview];

        }];
    }
}
//展开下拉菜单
-(void)showChooseListViewInSection:(NSInteger)section choosedIndex:(NSInteger)index
{
    if (!self.mTableView) {
        self.mTableBaseView = [[UIView alloc] initWithFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y + self.frame.size.height , self.frame.size.width, self.mSuperView.frame.size.height - self.frame.origin.y - self.frame.size.height)];
        self.mTableBaseView.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.5];
        
        UITapGestureRecognizer *bgTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bgTappedAction:)];
        [self.mTableBaseView addGestureRecognizer:bgTap];
        
        self.mTableView = [[UITableView alloc] initWithFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y + self.frame.size.height, self.frame.size.width, 240) style:UITableViewStylePlain];
        [self.mTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        [self.mTableView setBackgroundColor:[UIColor colorWithRed:245.0/255 green:245.0/255 blue:245.0/255 alpha:1]];
        self.mTableView.delegate = self;
        self.mTableView.dataSource = self;
        
        self.nTableView = [[UITableView alloc] initWithFrame:CGRectMake(self.frame.origin.x+self.frame.size.width/2, self.frame.origin.y + self.frame.size.height, self.frame.size.width/2, 240) style:UITableViewStylePlain];
        [self.nTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        [self.nTableView setBackgroundColor:[UIColor colorWithRed:238.0/255 green:238.0/255 blue:238.0/255 alpha:1]];
        [self.nTableView setTag:8888];
        self.nTableView.delegate = self;
        self.nTableView.dataSource = self;

        
    }
    
    if ([self.dropDownDataSource respondsToSelector:@selector(isHaveTwoTableView:)]) {
        isHaveTwoTab=[self.dropDownDataSource isHaveTwoTableView:currentExtendSection];
    }
    [self.mTableView setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y + self.frame.size.height, self.frame.size.width/(isHaveTwoTab?2:1), 240)];

    //修改tableview的frame
    CGRect rect = self.mTableView.frame;
    rect.size.height = 0;
    self.mTableView.frame = rect;
    [self.mSuperView addSubview:self.mTableBaseView];
    [self.mSuperView addSubview:self.mTableView];
    //动画设置位置
    rect .size.height = 240;
    
    CGRect rect1 = self.nTableView.frame;
    if (isHaveTwoTab) {
        rect1.size.height = 0;
        self.nTableView.frame = rect1;
        [self.mSuperView addSubview:self.nTableView];
        rect1.size.height=240;
    }else{
        if (_nTableView.superview!=nil) {
            [_nTableView removeFromSuperview];
        }
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        self.mTableBaseView.alpha = 1.0;
        self.mTableView.alpha = 1.0;
        self.mTableView.frame =  rect;
        if (isHaveTwoTab) {
            self.nTableView.alpha = 1.0;
            self.nTableView.frame =  rect1;
        }

    }];
    
    [self.mTableView reloadData];
}

#pragma mark -- UITableView Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.dropDownDelegate respondsToSelector:@selector(chooseAtSection:index:seIndex:)]) {
        //取消原来cell的选中状态
        NSIndexPath *index =[NSIndexPath indexPathForRow:[selectedAry[currentExtendSection] intValue] inSection:indexPath.section];

        if (tableView.tag!=8888&&_nTableView.superview!=nil) {
            //设置最新选中的cell
            UIImageView *imgView= (UIImageView *)[[tableView cellForRowAtIndexPath:index] viewWithTag:1];
            [imgView setImage:[UIImage imageNamed:@"bg_dropdown_section"]];
            
            //设置最新cell为选中状态
            imgView= (UIImageView *)[[tableView cellForRowAtIndexPath:indexPath] viewWithTag:1];
            [imgView setImage:[UIImage imageNamed:@"bg_dropdown_left_selected"]];

            [selectedAry replaceObjectAtIndex:currentExtendSection withObject:[NSString stringWithFormat:@"%d",indexPath.row] ];

            [_nTableView reloadData];
            if ([_nTableView numberOfRowsInSection:0]==0) {
                [self returnTheList:indexPath];
            }
        }else if (tableView.tag==8888&&_nTableView.superview!=nil) {
            NSString *chooseCellTitle =[self.dropDownDataSource titleInIndex:currentExtendSection  index:[selectedAry[0] integerValue] seIndex:indexPath.row];
            if ([chooseCellTitle isEqualToString:@"全部"]) {
                chooseCellTitle =[self.dropDownDataSource titleInSection:currentExtendSection index:[selectedAry[0] integerValue]];
            }
            UILabel * lab = (UILabel *)[self viewWithTag:SECTION_TEXT + currentExtendSection];
            [lab setText:chooseCellTitle];
            
            [self.dropDownDelegate chooseAtSection:currentExtendSection index:[selectedAry[0] integerValue] seIndex:indexPath.row];
            [self dropDownTriangleDown];
            [self hideExtendedChooseView];
        }else{
            UIImageView *imgView= (UIImageView *)[[tableView cellForRowAtIndexPath:index] viewWithTag:1];
            [imgView setImage:[UIImage imageNamed:@"bg_dropdown_section"]];
            
            //设置最新cell为选中状态
            imgView= (UIImageView *)[[tableView cellForRowAtIndexPath:indexPath] viewWithTag:1];
            [imgView setImage:[UIImage imageNamed:@"bg_dropdown_left_selected"]];

            //设置最新选中的cell
            [selectedAry replaceObjectAtIndex:currentExtendSection withObject:[NSString stringWithFormat:@"%d",indexPath.row] ];
            [self returnTheList:indexPath];
        }
    }
}
-(void)returnTheList:(NSIndexPath *)indexPath
{
    NSString *chooseCellTitle = [self.dropDownDataSource titleInSection:currentExtendSection index:indexPath.row];
    UILabel * lab = (UILabel *)[self viewWithTag:SECTION_TEXT + currentExtendSection];
    [lab setText:chooseCellTitle];
    
    [self.dropDownDelegate chooseAtSection:currentExtendSection index:indexPath.row seIndex:-1];
    [self dropDownTriangleDown];
    [self hideExtendedChooseView];
}

#pragma mark -- UITableView DataSource


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag==8888) {
        return [self.dropDownDataSource numOfRowsInSection:currentExtendSection index:[selectedAry[0] integerValue]];
    }
    return [self.dropDownDataSource numberOfRowsInSection:currentExtendSection];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag==8888) {
        static NSString * cellIdentifier = @"secondCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            
            UIImageView *backImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height-1)];
            [backImg setTag:1];
            [cell insertSubview:backImg atIndex:0];
        }
        UIImageView *backImg =  (UIImageView *)[cell viewWithTag:1];
        
        [backImg setImage:[UIImage imageNamed:@"bg_dropdown_left_selected"]];
        cell.textLabel.text = [self.dropDownDataSource titleInIndex:currentExtendSection index: [selectedAry[0] integerValue] seIndex:indexPath.row];
        [cell.textLabel setBackgroundColor:[UIColor clearColor]];
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        return cell;
    }
    static NSString * cellIdentifier = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        
        UIImageView *backImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height-1)];
        [backImg setTag:1];
        [cell insertSubview:backImg atIndex:0];
    }
    UIImageView *backImg =  (UIImageView *)[cell viewWithTag:1];
    
    [backImg setImage:[UIImage imageNamed:indexPath.row==[selectedAry[currentExtendSection] intValue]?@"bg_dropdown_left_selected": @"bg_dropdown_section"]];
    cell.textLabel.text = [self.dropDownDataSource titleInSection:currentExtendSection index:indexPath.row];
    if (tableView.tag!=8888&&_nTableView.superview!=nil)
    {
        [cell.imageView setImage:[UIImage imageNamed:cell.textLabel.text]];
    }else{
        [cell.imageView setImage:nil];
    }
    [cell.textLabel setBackgroundColor:[UIColor clearColor]];
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    return cell;
}


#pragma mark -
#pragma mark 设置函数
//点击收回菜单
-(void)bgTappedAction:(UITapGestureRecognizer *)tap
{
    [self dropDownTriangleDown];
    [self hideExtendedChooseView];
}
//是否有下啦菜单
- (BOOL)isShow
{
    if (currentExtendSection == -1) {
        return NO;
    }
    return YES;
}
//指示三角向下
-(void)dropDownTriangleDown
{
    if (currentExtendSection==-1) {
        return;
    }
    UIImageView *currentIV = (UIImageView *)[self viewWithTag:(SECTION_IV_TAG_BEGIN + currentExtendSection)];
    [currentIV setImage:[UIImage imageNamed:@"icon_dropdown_triangle_down.png"]];
    
    UIImageView * img = (UIImageView *)[self viewWithTag:SECTION_IMG + currentExtendSection];
    [img setImage:[UIImage imageNamed:imgArray[currentExtendSection][0]]];
    
    UILabel * lab = (UILabel *)[self viewWithTag:SECTION_TEXT + currentExtendSection];
    [lab setTextColor:[UIColor colorWithRed:130.0/255 green:130.0/255  blue:130.0/255  alpha:1]];
    
    if (currentExtendSection==0) {
        UIImageView * img = (UIImageView *)[self viewWithTag:SECTION_IMG+currentExtendSection];
        if ([self.dropDownDelegate respondsToSelector:@selector(chooseAtSection:index:seIndex:)]) {
            [img setImage:[UIImage imageNamed:[self.dropDownDataSource titleInSection:currentExtendSection index:[selectedAry[0] integerValue] ]]];

        }

    }

}
@end
