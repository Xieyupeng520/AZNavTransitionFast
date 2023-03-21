//
//  AZPushPopTransitionHandler.h
//  AZNavTransitionFast
//  导航控制器代理实例
//  Created by cocozzhang on 2023/3/21.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface AZPushPopTransitionHandler : NSObject<UINavigationControllerDelegate>
+ (instancetype)instance;
@end

NS_ASSUME_NONNULL_END
