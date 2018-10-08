//
//  NSObject+Swizzling.h
//  runtime
//
//  Created by Berning on 2018/10/8.
//  Copyright © 2018年 BN. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (Swizzling)

+  (void)methodSwizzlingWithOriginalSelector:(SEL)originalSelector bySwizzledSelector:(SEL)swizzledSelector;

@end

NS_ASSUME_NONNULL_END
