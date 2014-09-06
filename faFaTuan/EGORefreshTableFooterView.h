//
//  EGORefreshTableFooterView.h
//  Demo
//
//  Created by Devin Doty on 10/14/09October14.
//  Copyright 2009 enormego. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

#import "EGORefresh.h"

@protocol EGORefreshTableFooterDelegate;
@interface EGORefreshTableFooterView : UIView {
	
	__unsafe_unretained id _delegate;
	EGOPullRefreshState _state;

	UILabel *_lastUpdatedLabel;
	UILabel *_statusLabel;
	CALayer *_arrowImage;
	UIActivityIndicatorView *_activityView;
}
@property(nonatomic,assign) id <EGORefreshTableFooterDelegate> delegate;

- (void)egoRefreshScrollViewDidScroll:(UIScrollView *)scrollView;
- (void)egoRefreshScrollViewDidEndDragging:(UIScrollView *)scrollView;
- (void)egoRefreshScrollViewDataSourceDidFinishedLoading:(UIScrollView *)scrollView;
@end

@protocol EGORefreshTableFooterDelegate
- (void)egoRefreshTableFooterDidTriggerRefresh:(EGORefreshTableFooterView*)view;
- (BOOL)egoRefreshTableFooterDataSourceIsLoading:(EGORefreshTableFooterView*)view;
- (BOOL)egoRefreshTableFooterIsEnd;
@optional
- (NSDate*)egoRefreshTableFooterDataSourceLastUpdated:(EGORefreshTableFooterView*)view;
@end
