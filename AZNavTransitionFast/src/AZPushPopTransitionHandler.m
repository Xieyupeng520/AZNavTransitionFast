//
//  AZPushPopTransitionHandler.m
//  AZNavTransitionFast
//
//  Created by cocozzhang on 2023/3/21.
//

#import "AZPushPopTransitionHandler.h"
#import "AZPushPopTransition.h"

@implementation AZPushPopTransitionHandler
/**单例, 省的每个VC自己要hold一份实例**/
+ (instancetype)instance {
    static AZPushPopTransitionHandler* instance = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        instance = [AZPushPopTransitionHandler new];
    });
    return instance;
}

#pragma mark - UINavigationControllerDelegate
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    NSAssert(operation != UINavigationControllerOperationNone, @"unknown operation");
    AZPushPopTransition *transition = [AZPushPopTransition new];
    transition.operation = operation;
    return transition;
}
@end
