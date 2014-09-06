//
//  EGORefreshTableHeaderView.m
//  Demo
//
//  Created by Devin Doty on 10/14/09October14.
//  Copyright 2009 enormego. All rights reserved.
//

#import "EGORefreshTableHeaderView.h"


#define TEXT_COLOR	 [UIColor colorWithRed:166.0/255.0 green:165.0/255.0 blue:159.0/255.0 alpha:1.0]
#define FLIP_ANIMATION_DURATION 0.18f
#define InsetBottom  IOS7_OR_LATER?50:0

@implementation EGORefreshTableHeaderView{
    int i;
}
@synthesize delegate=_delegate;

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
		self.backgroundColor = [UIColor colorWithRed:235.0/255 green:235.0/255 blue:241.0/255 alpha:1.0];
        //状态标签
        _statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(100.0f, frame.size.height - 35.0f, self.frame.size.width-80, 20.0f)];
		_statusLabel.font = [UIFont systemFontOfSize:14.0f];
		_statusLabel.textColor = TEXT_COLOR;
		_statusLabel.backgroundColor = [UIColor clearColor];
		[self addSubview:_statusLabel];
		i=0;
        //动画
        _personImage =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_listheader_animation_1"]];
        [_personImage setFrame:CGRectMake(25,frame.size.height-45.0f, 45, 45)];
        [self addSubview:_personImage];
        //旋转框
        _rotatingImage =[[UIImageView alloc]initWithFrame: CGRectMake(frame.size.width-45.0f, frame.size.height-35.0f, 20.0f, 20.0f)];
        [_rotatingImage setImage:[UIImage imageNamed:@"icon_loading.png"]];
        [self addSubview:_rotatingImage];

		[self setState:EGOOPullRefreshNormal];
    }
    return self;
}
#pragma mark -
#pragma mark Setters

- (void)setState:(EGOPullRefreshState)aState{
	switch (aState) {
		case EGOOPullRefreshPulling:{
            _statusLabel.text = NSLocalizedString(@"释放即可刷新", @"Release to refresh status");
            [self animationImage];
        }
			break;
		case EGOOPullRefreshNormal:{
            [_personImage stopAnimating];
			_statusLabel.text = NSLocalizedString(@"下拉即可刷新", @"Pull down to refresh status");
        }
			break;
		case EGOOPullRefreshLoading:{
            _statusLabel.text = NSLocalizedString(@"努力加载中...", @"Loading Status");
            
            CABasicAnimation* rotationAnimation;
            rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
            rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
            rotationAnimation.duration = 0.7;
            rotationAnimation.cumulative = YES;
            rotationAnimation.repeatCount = 45000;
            [_rotatingImage.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
        }
			break;
		default:
			break;
	}
	_state = aState;
}

#pragma mark -
#pragma mark ScrollView Methods

- (void)egoRefreshScrollViewDidScroll:(UIScrollView *)scrollView {	
	if (_state == EGOOPullRefreshLoading) {
		CGFloat offset = MAX(scrollView.contentOffset.y * -1, 0);
		offset = MIN(offset, 60);
        scrollView.contentInset = UIEdgeInsetsMake(offset, 0.0f, InsetBottom, 0.0f);
	}else if(scrollView.isDragging) {
		BOOL _loading = NO;
		if ([_delegate respondsToSelector:@selector(egoRefreshTableHeaderDataSourceIsLoading:)]) {
			_loading = [_delegate egoRefreshTableHeaderDataSourceIsLoading:self];
		}
		
		if (_state == EGOOPullRefreshPulling && scrollView.contentOffset.y > -65.0f && scrollView.contentOffset.y < 0.0f && !_loading) {
			[self setState:EGOOPullRefreshNormal];
		} else if (_state == EGOOPullRefreshNormal && scrollView.contentOffset.y < -65.0f && !_loading) {
			[self setState:EGOOPullRefreshPulling];
		}
		
		if (scrollView.contentInset.top != 0) {
			scrollView.contentInset = UIEdgeInsetsZero;
		}
	}
}
- (void)egoRefreshScrollViewDidEndDragging:(UIScrollView *)scrollView {
	
	BOOL _loading = NO;
	if ([_delegate respondsToSelector:@selector(egoRefreshTableHeaderDataSourceIsLoading:)]) {
		_loading = [_delegate egoRefreshTableHeaderDataSourceIsLoading:self];
	}
	
	if (scrollView.contentOffset.y <= - 65.0f && !_loading) {
		
		if ([_delegate respondsToSelector:@selector(egoRefreshTableHeaderDidTriggerRefresh:)]) {
			[_delegate egoRefreshTableHeaderDidTriggerRefresh:self];
		}
		
		[self setState:EGOOPullRefreshLoading];
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:0.2];
        scrollView.contentInset = UIEdgeInsetsMake(60.0f, 0.0f, InsetBottom, 0.0f);
		[UIView commitAnimations];
		
	}
	
}
/**
 * 结束刷新
 */
- (void)egoRefreshScrollViewDataSourceDidFinishedLoading:(UIScrollView *)scrollView {
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:.3];
    [scrollView setContentInset:UIEdgeInsetsMake(0.0f, 0.0f,InsetBottom, 0.0f)];
	[UIView commitAnimations];
    [_rotatingImage.layer removeAnimationForKey:@"rotationAnimation"];
    [_personImage stopAnimating];
	[self setState:EGOOPullRefreshNormal];
}
/**
 *动画 
 */
-(void)animationImage
{
    _personImage.animationImages = [NSArray arrayWithObjects:
                                    [UIImage imageNamed:@"icon_listheader_animation_1"],
                                    [UIImage imageNamed:@"icon_listheader_animation_2"], nil];
    _personImage.animationDuration = 0.25;
    _personImage.animationRepeatCount = 9999;
    [_personImage startAnimating];
}
@end
