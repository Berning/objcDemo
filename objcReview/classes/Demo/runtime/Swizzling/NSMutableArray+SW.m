
//
//  NSMutableArray+BN.m
//  Xcode8
//
//  Created by uBerning on 2017/3/22.
//  Copyright © 2017年 BN. All rights reserved.
//

#import "NSMutableArray+SW.h"
#import <objc/runtime.h>
#import "NSObject+Swizzling.h"

@implementation NSMutableArray (SW)

+(void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [objc_getClass("__NSArrayM") methodSwizzlingWithOriginalSelector:@selector(removeObject:) bySwizzledSelector:@selector(safeRemoveObject:) ];
        
        [objc_getClass("__NSArrayM") methodSwizzlingWithOriginalSelector:@selector(addObject:) bySwizzledSelector:@selector(safeAddObject:)];
        
        [objc_getClass("__NSArrayM") methodSwizzlingWithOriginalSelector:@selector(removeObjectAtIndex:) bySwizzledSelector:@selector(safeRemoveObjectAtIndex:)];
        
        [objc_getClass("__NSArrayM") methodSwizzlingWithOriginalSelector:@selector(insertObject:atIndex:) bySwizzledSelector:@selector(safeInsertObject:atIndex:)];
        
        [objc_getClass("__NSArrayM") methodSwizzlingWithOriginalSelector:@selector(objectAtIndex:) bySwizzledSelector:@selector(safeObjectAtIndex:)];
    });
    
}

- (void)safeAddObject:(id)obj {
    if (obj == nil) {
        NSLog(@"%s can add nil object into NSMutableArray", __FUNCTION__);
    } else {
        [self safeAddObject:obj];
    }
}
- (void)safeRemoveObject:(id)obj {
    if (obj == nil) {
        NSLog(@"%s can -removeObject:, but argument obj is nil", __FUNCTION__);
        return;
    }
    [self safeRemoveObject:obj];
}

- (void)safeInsertObject:(id)anObject atIndex:(NSUInteger)index {
    if (anObject == nil) {
        NSLog(@"%s can't insert nil into NSMutableArray", __FUNCTION__);
    } else if (index > self.count) {
        NSLog(@"%s index is invalid", __FUNCTION__);
    } else {
        [self safeInsertObject:anObject atIndex:index];
    }
}

- (id)safeObjectAtIndex:(NSUInteger)index {
    if (self.count == 0) {
        NSLog(@"%s can't get any object from an empty array", __FUNCTION__);
        return nil;
    }
    if (index > self.count) {
        NSLog(@"%s index out of bounds in array", __FUNCTION__);
        return nil;
    }
    return [self safeObjectAtIndex:index];
}

- (void)safeRemoveObjectAtIndex:(NSUInteger)index {
    if (self.count <= 0) {
        NSLog(@"%s can't get any object from an empty array", __FUNCTION__);
        return;
    }
    if (index >= self.count) {
        NSLog(@"%s index out of bound", __FUNCTION__);
        return;
    }
    [self safeRemoveObjectAtIndex:index];
}




@end
