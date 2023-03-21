//
//  UINavigationController+AZPushPopTransition.h
//  AZNavTransitionFast
//  加速转场效果
//  Created by cocozzhang on 2023/3/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UINavigationController (AZPushPopTransition)
- (void)pushViewControllerFast:(UIViewController *)viewController animated:(BOOL)animated;
- (UIViewController *)popViewControllerFastAnimated:(BOOL)animated;
@end

NS_ASSUME_NONNULL_END
