//
//  DropDownChooseProtocol.h
//  DropDownDemo
//
//  Created by 王立龙 on 24-8-28.
//  Copyright (c) 2014年 王立龙. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DropDownChooseDelegate <NSObject>

@optional
-(void) chooseAtSection:(NSInteger)section index:(NSInteger)index seIndex:(NSInteger)seIndex;
@end

@protocol DropDownChooseDataSource <NSObject>
-(NSArray *)sectionsImg;//选项卡图片
-(NSInteger)numberOfSections;//选项卡个数
-(NSInteger)numberOfRowsInSection:(NSInteger)section;
-(NSString *)titleInSection:(NSInteger)section index:(NSInteger) index;

-(NSInteger)numOfRowsInSection:(NSInteger)section index:(NSInteger) index;
-(NSString *)titleInIndex:(NSInteger)section index:(NSInteger) index seIndex:(NSInteger) seIndex;
-(NSInteger)defaultShowSection:(NSInteger)section;//默认展示第几行上的标题
-(BOOL)isHaveTwoTableView:(NSInteger)section;//
@end



