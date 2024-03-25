//
//  UIViewController+AZPushPopTransition.h
//  AZNavTransitionFast
//  某个VC在push加速的话，pop理应也加速
//  Created by 可可 on 2024/3/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (AZPushPopTransition)

/// 标记push是否加速
@property(nonatomic)BOOL transitionNeedFast;

@end

NS_ASSUME_NONNULL_END
