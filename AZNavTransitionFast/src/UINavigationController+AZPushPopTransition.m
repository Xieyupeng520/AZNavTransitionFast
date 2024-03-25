//
//  UINavigationController+AZPushPopTransition.m
//  AZNavTransitionFast
//
//  Created by cocozzhang on 2023/3/21.
//

#import "UINavigationController+AZPushPopTransition.h"
#import "AZPushPopTransitionHandler.h"
#import "UIViewController+AZPushPopTransition.h"
#import "AZSwizzle.h"

@implementation UINavigationController (AZPushPopTransition)

+ (void)load {
    AZSwizzleMethod([UINavigationController class], @selector(popViewControllerAnimated:), [UINavigationController class], @selector(az_popViewControllerAnimated:));
}

- (void)pushViewControllerFast:(UIViewController *)viewController animated:(BOOL)animated {
    id<UINavigationControllerDelegate> oriDelegate = self.delegate;
    self.delegate = AZPushPopTransitionHandler.instance;
    [self pushViewController:viewController animated:animated];
    viewController.transitionNeedFast = YES;
    self.delegate = oriDelegate;
}

- (UIViewController *)popViewControllerFastAnimated:(BOOL)animated {
    id<UINavigationControllerDelegate> oriDelegate = self.delegate;
    self.delegate = AZPushPopTransitionHandler.instance;
    UIViewController* vc = [self popViewControllerAnimated:animated];
    self.delegate = oriDelegate;
    return vc;
}

#pragma mark -
- (UIViewController *)az_popViewControllerAnimated:(BOOL)animated {
    if (![self isPopNeedFast]) {
        return [self az_popViewControllerAnimated:animated];
    }
    id<UINavigationControllerDelegate> oriDelegate = self.delegate;
    self.delegate = AZPushPopTransitionHandler.instance;
    UIViewController* vc = [self az_popViewControllerAnimated:animated];
    self.delegate = oriDelegate;
    return vc;
}

- (BOOL)isPopNeedFast {
    UIViewController *fromVC = [self.viewControllers lastObject];
    if (!fromVC) {
        return NO;
    }
    return fromVC.transitionNeedFast; // 加速进来，加速出去
}
@end
