//
//  PushTransition.h
//  testNavTransitionFast
//  转场动画核心类
//  Created by cocozzhang on 2023/3/9.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface AZPushPopTransition : NSObject<UIViewControllerAnimatedTransitioning>
/// push or pop
@property(nonatomic, assign)UINavigationControllerOperation operation;
/// 转场时间
@property(nonatomic)NSTimeInterval transTime;
@end

NS_ASSUME_NONNULL_END
