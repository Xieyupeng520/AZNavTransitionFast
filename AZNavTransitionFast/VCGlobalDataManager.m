//
//  VCGlobalDataManager.m
//  testNavTransitionFast
//
//  Created by cocozzhang on 2023/3/10.
//

#import "VCGlobalDataManager.h"

@implementation VCGlobalDataManager

+ (instancetype)instance {
    static dispatch_once_t once;
    static VCGlobalDataManager* mgr = nil;
    dispatch_once(&once, ^{
        mgr = [VCGlobalDataManager new];
    });
    return mgr;
}

- (instancetype)init {
    if (self = [super init]) {
        self.transTime = 0.5;
        self.useSystemTransition = YES;
    }
    return self;
}
@end
