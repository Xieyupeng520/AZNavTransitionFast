//
//  UINavigationController+AZPushPopTransition.m
//  AZNavTransitionFast
//
//  Created by cocozzhang on 2023/3/21.
//

#import "UINavigationController+AZPushPopTransition.h"
#import "AZPushPopTransitionHandler.h"

@implementation UINavigationController (AZPushPopTransition)
- (void)pushViewControllerFast:(UIViewController *)viewController animated:(BOOL)animated {
    id<UINavigationControllerDelegate> oriDelegate = self.delegate;
    self.delegate = AZPushPopTransitionHandler.instance;
    [self pushViewController:viewController animated:animated];
    self.delegate = oriDelegate;
}

- (UIViewController *)popViewControllerFastAnimated:(BOOL)animated {
    id<UINavigationControllerDelegate> oriDelegate = self.delegate;
    self.delegate = AZPushPopTransitionHandler.instance;
    UIViewController* vc = [self popViewControllerAnimated:animated];
    self.delegate = oriDelegate;
    return vc;
}
@end
