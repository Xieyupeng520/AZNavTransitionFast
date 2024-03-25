//
//  UIViewController+AZPushPopTransition.m
//  AZNavTransitionFast
//
//  Created by 可可 on 2024/3/22.
//

#import <objc/runtime.h>
#import "UIViewController+AZPushPopTransition.h"

@implementation UIViewController (AZPushPopTransition)

- (BOOL)transitionNeedFast {
    id value = objc_getAssociatedObject(self, @selector(transitionNeedFast));
    if ([value isKindOfClass:NSNumber.class]) {
        return [value boolValue];
    }
    return YES; // 希望所有的VC转场都变化就设为为YES，否则设为NO
}

- (void)setTransitionNeedFast:(BOOL)transitionNeedFast {
    objc_setAssociatedObject(self, @selector(transitionNeedFast), @(transitionNeedFast), OBJC_ASSOCIATION_ASSIGN);
}

@end
