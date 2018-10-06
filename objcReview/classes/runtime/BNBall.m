
//
//  BNBall.m
//  Xcode8
//
//  Created by uBerning on 2017/3/23.
//  Copyright © 2017年 BN. All rights reserved.
//


#import "BNBall.h"
#import "BNDog.h"

#import "BNPerson.h"


@implementation BNBall



//+(BOOL)resolveInstanceMethod:(SEL)sel
//{
//    if (sel==@selector(eat)) {
//        NSLog(@"eat");
//        return YES;
//    }
//    return [super resolveInstanceMethod:sel];
//}
//
-(id)forwardingTargetForSelector:(SEL)aSelector
{
    if (aSelector==@selector(eat)) {
        BNDog *dog=[BNDog new];
        return dog;
    }
    else if(aSelector==@selector(compute))
    {
        return [BNPerson person];
    }
    return self;
}


-(NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector
{
    return nil;
}


-(void)forwardInvocation:(NSInvocation *)anInvocation
{
    
}


@end
