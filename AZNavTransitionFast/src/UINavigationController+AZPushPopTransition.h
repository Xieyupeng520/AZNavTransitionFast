//
//  UINavigationController+AZPushPopTransition.h
//  AZNavTransitionFast
//  加速转场效果
//  Created by cocozzhang on 2023/3/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UINavigationController (AZPushPopTransition)

/// push 加速。push加速过的页面，pop也会加速
- (void)pushViewControllerFast:(UIViewController *)viewController animated:(BOOL)animated;

/// pop 加速
- (UIViewController *)popViewControllerFastAnimated:(BOOL)animated;
@end

NS_ASSUME_NONNULL_END
