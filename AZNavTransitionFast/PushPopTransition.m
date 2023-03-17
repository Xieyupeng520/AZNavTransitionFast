//
//  PushTransition.m
//  testNavTransitionFast
//
//  Created by cocozzhang on 2023/3/9.
//

#import "PushPopTransition.h"

@implementation PushPopTransition

static CGFloat const kDamping = 1;
static CGFloat const kInitialSpringVelocity = 0.5f;
static CGFloat const kAlpha = 0.8f;
static CGFloat const kTranslationRatio = 0.3; //偏移率（相对于屏幕宽）

- (instancetype)init {
    if (self = [super init]) {
        self.transTime = 0.5; //default value is same as system
    }
    return self;
}

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext
{
    return self.transTime;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    if (self.operation == UINavigationControllerOperationPop) {
        [self pop_animateTransition:transitionContext];
    } else if (self.operation == UINavigationControllerOperationPush) {
        [self push_animateTransition:transitionContext];
    }
}
- (void)push_animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    //push: from → to
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];

    UIView *containerView = [transitionContext containerView];
    NSTimeInterval duration = [self transitionDuration:transitionContext];

    // 模拟系统的从右往左进入动画
    CGAffineTransform to_travel_begin = CGAffineTransformMakeTranslation (CGRectGetWidth(containerView.bounds), 0);
    CGAffineTransform from_travel_end = CGAffineTransformMakeTranslation (-CGRectGetWidth(containerView.bounds) * kTranslationRatio, 0);
    
    //先摆好toVC的位置（可能会被导航栏的translucent影响位置）
    toViewController.view.frame = [transitionContext finalFrameForViewController:toViewController];
    toViewController.view.transform = to_travel_begin;
    
    [containerView insertSubview:toViewController.view aboveSubview:fromViewController.view];
    
    double beginTime = CFAbsoluteTimeGetCurrent();
    [UIView animateWithDuration:duration
                          delay:0
         usingSpringWithDamping:kDamping //阻尼系数（设1就没有来回振荡效果）
          initialSpringVelocity:kInitialSpringVelocity //速度（pt/s)
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
            fromViewController.view.transform = from_travel_end;
            fromViewController.view.alpha = kAlpha;
            toViewController.view.transform = CGAffineTransformIdentity;
        }
        completion:^(BOOL finished) {
            //还原from vc
            fromViewController.view.transform = CGAffineTransformIdentity;
            fromViewController.view.alpha = 1;
            [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
            NSLog(@"end push - cost time: %f", CFAbsoluteTimeGetCurrent() - beginTime);
        }];
}

- (void)pop_animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    //pop: to ← from
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];

    UIView *containerView = [transitionContext containerView];
    NSTimeInterval duration = [self transitionDuration:transitionContext];

    // 模拟系统的从左往右返回动画
    CGAffineTransform to_travel_begin = CGAffineTransformMakeTranslation (-CGRectGetWidth(containerView.bounds) * kTranslationRatio, 0);
    CGAffineTransform from_travel_end = CGAffineTransformMakeTranslation (CGRectGetWidth(containerView.bounds), 0);
    
    toViewController.view.transform = to_travel_begin;
    toViewController.view.alpha = kAlpha;
    
    [containerView insertSubview:toViewController.view belowSubview:fromViewController.view];

    double beginTime = CFAbsoluteTimeGetCurrent();
    [UIView animateWithDuration:duration
                          delay:0
         usingSpringWithDamping:kDamping //阻尼系数（设1就没有来回振荡效果）
          initialSpringVelocity:kInitialSpringVelocity //速度（pt/s)
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
            fromViewController.view.transform = from_travel_end;
            toViewController.view.transform = CGAffineTransformIdentity;
            toViewController.view.alpha = 1;
        }
        completion:^(BOOL finished) {
            [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
        
            NSLog(@"end pop - cost time: %f", CFAbsoluteTimeGetCurrent() - beginTime);
        }];
}

@end
