//
//  EGORefreshTableFooterView.m
//  Demo
//
//  Created by Devin Doty on 10/14/09October14.
//  Copyright 2009 enormego. All rights reserved.

#import "EGORefreshTableFooterView.h"


#define TEXT_COLOR	 [UIColor darkGrayColor]
#define FLIP_ANIMATION_DURATION 0.18f


@interface EGORefreshTableFooterView (Private)
- (void)setState:(EGOPullRefreshState)aState;
@end

@implementation EGORefreshTableFooterView

@synthesize delegate=_delegate;


- (id)initWithFrame:(CGRect)frame textColor:(UIColor *)textColor  {
    if((self = [super initWithFrame:frame])) {
		self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
		self.backgroundColor = [UIColor whiteColor];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 18, self.frame.size.width, 20.0f)];
		label.autoresizingMask = UIViewAutoresizingFlexibleWidth;
		label.font = [UIFont systemFontOfSize:12.0f];
		label.textColor = textColor;
		label.shadowColor = [UIColor colorWithWhite:0.9f alpha:1.0f];
		label.shadowOffset = CGSizeMake(0.0f, 1.0f);
		label.backgroundColor = [UIColor clearColor];
		label.textAlignment = NSTextAlignmentCenter;
		[self addSubview:label];
		_lastUpdatedLabel=label;
		
        label = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 5.0f, self.frame.size.width, 20.0f)];
		label.autoresizingMask = UIViewAutoresizingFlexibleWidth;
		label.font = [UIFont systemFontOfSize:13.0f];
		label.textColor = textColor;
		label.shadowColor = [UIColor colorWithWhite:0.9f alpha:1.0f];
		label.shadowOffset = CGSizeMake(0.0f, 1.0f);
		label.backgroundColor = [UIColor clearColor];
		label.textAlignment = NSTextAlignmentCenter;
		[self addSubview:label];
		_statusLabel=label;
		
		UIActivityIndicatorView *view = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        view.frame = CGRectMake(25.0f, 5.0f, 20.0f, 20.0f);
		[self addSubview:view];
		_activityView = view;
		
		[self setState:EGOOPullRefreshNormal];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame  {
  return [self initWithFrame:frame  textColor:TEXT_COLOR];
}

#pragma mark -
#pragma mark Setters

- (void)setState:(EGOPullRefreshState)aState{
	
	switch (aState) {
		case EGOOPullRefreshPulling:
			_statusLabel.text = NSLocalizedString(@"松开加载更多", @"Release to refresh status");
			break;
		case EGOOPullRefreshNormal:
            [_activityView stopAnimating];
			_statusLabel.text = NSLocalizedString(@"上拉加载更多", @"Pull down to refresh status");
			break;
            
		case EGOOPullRefreshLoading:
            [_activityView startAnimating];
			_statusLabel.text = NSLocalizedString(@"加载中...", @"Loading Status");
			break;
		default:
			break;
	}
	_state = aState;
}


#pragma mark -
#pragma mark ScrollView Methods
- (void)egoRefreshScrollViewDidScroll:(UIScrollView *)scrollView {
    if ([_delegate respondsToSelector:@selector(egoRefreshTableFooterIsEnd)]) {
        if ([_delegate egoRefreshTableFooterIsEnd]) {
            if (scrollView.contentInset.bottom != 0) {
                scrollView.contentInset = UIEdgeInsetsZero;
            }
            _statusLabel.text = NSLocalizedString(@"已经到底", @"No more");
            return;
        }
    }
    float offY          = scrollView.contentOffset.y;
    float contentHeight = scrollView.contentSize.height;
    float boundsHeight  = scrollView.bounds.size.height;
	if (_state == EGOOPullRefreshLoading)
    {
        //在下拉刷新时中，若正在loading
	} else if (scrollView.isDragging) {
		
		BOOL _loading = NO;
		if ([_delegate respondsToSelector:@selector(egoRefreshTableFooterDataSourceIsLoading:)]) {
			_loading = [_delegate egoRefreshTableFooterDataSourceIsLoading:self];
		}
        double d = contentHeight - boundsHeight < 0?0:contentHeight - boundsHeight;
        if (_state == EGOOPullRefreshPulling &&offY < d + 15 &&offY > d &&!_loading)
        {
			[self setState:EGOOPullRefreshNormal];
		}
        else if (_state == EGOOPullRefreshNormal &&offY > d + 15&& !_loading)
        {
			[self setState:EGOOPullRefreshPulling];
		}
        if (scrollView.contentInset.bottom != 0) {
			scrollView.contentInset = UIEdgeInsetsZero;
		}
	}
	
}


- (void)egoRefreshScrollViewDidEndDragging:(UIScrollView *)scrollView {
    if ([_delegate respondsToSelector:@selector(egoRefreshTableFooterIsEnd)]) {
        if ([_delegate egoRefreshTableFooterIsEnd]) {
            _statusLabel.text = NSLocalizedString(@"已经到底", @"No more");
            return;
        }
    }
    
    float offY = scrollView.contentOffset.y;
    float contentHeight = scrollView.contentSize.height;
    float boundsHeight = scrollView.bounds.size.height;
	BOOL _loading = NO;
	if ([_delegate respondsToSelector:@selector(egoRefreshTableFooterDataSourceIsLoading:)]) {
		_loading = [_delegate egoRefreshTableFooterDataSourceIsLoading:self];
	}
    int d = contentHeight - boundsHeight > 0 ? contentHeight - boundsHeight : 0;
	if (offY >= (d +15) && !_loading)
    {
		if ([_delegate respondsToSelector:@selector(egoRefreshTableFooterDidTriggerRefresh:)]) {
			[_delegate egoRefreshTableFooterDidTriggerRefresh:self];
		}
		[self setState:EGOOPullRefreshLoading];
	}
}
- (void)egoRefreshScrollViewDataSourceDidFinishedLoading:(UIScrollView *)scrollView {	
        [self setState:EGOOPullRefreshNormal];
}
@end
