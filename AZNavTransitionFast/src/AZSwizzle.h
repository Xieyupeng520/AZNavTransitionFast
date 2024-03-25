//
//  AZSwizzle.h
//

#import <Foundation/Foundation.h>

extern void AZSwizzleMethod(Class originalCls, SEL originalSelector, Class swizzledCls,
                            SEL swizzledSelector);
