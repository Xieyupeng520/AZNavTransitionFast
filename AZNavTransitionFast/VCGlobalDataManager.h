//
//  VCGlobalDataManager.h
//  testNavTransitionFast
//  demo vc 统一数据管理器
//  Created by cocozzhang on 2023/3/10.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface VCGlobalDataManager : NSObject
/**转场时间**/
@property(nonatomic)NSTimeInterval transTime;
/**使用系统转场**/
@property(nonatomic)BOOL useSystemTransition;
/**慢动作**/
@property(nonatomic)BOOL slowAnimations;

+ (instancetype)instance;
@end

NS_ASSUME_NONNULL_END
