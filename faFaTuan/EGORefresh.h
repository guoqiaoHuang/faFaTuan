//
//  EGORefresh.h
//  faFaTuan
//
//  Created by git on 14-9-5.
//  Copyright (c) 2014年 fafaS. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *下拉的三个状态
 */
typedef enum{
	EGOOPullRefreshPulling = 0,
	EGOOPullRefreshNormal,
	EGOOPullRefreshLoading,
} EGOPullRefreshState;
@interface EGORefresh : NSObject
@end
