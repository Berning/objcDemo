
//
//  BNBall.m
//  Xcode8
//
//  Created by uBerning on 2017/3/23.
//  Copyright © 2017年 BN. All rights reserved.
//


#import "BNBall.h"
#import "BNDog.h"

#import "BNPeople.h"


@implementation BNBall

//+(BOOL)resolveClassMethod:(SEL)sel
//{
//    return [super resolveClassMethod:sel];
//}
//
//+(BOOL)resolveInstanceMethod:(SEL)sel
//{
//    if (sel==@selector(eat)) {
//        NSLog(@"eat");
//        return YES;
//    }
//    return [super resolveInstanceMethod:sel];
//}


//向返回的 目标寻找方法
-(id)forwardingTargetForSelector:(SEL)aSelector
{
    if (aSelector==@selector(eat)) {
        BNDog *dog=[BNDog new];
        return dog;
    }
    else if(aSelector==@selector(compute))
    {
        return [BNPeople person];
    }
    return [super forwardingTargetForSelector:aSelector];
}


//-(NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector
//{
//    return [super methodSignatureForSelector:aSelector];
//}
//
//
//-(void)forwardInvocation:(NSInvocation *)anInvocation
//{
//    
//}


@end
