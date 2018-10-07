
//
//  NSMutableArray+BN.m
//  Xcode8
//
//  Created by uBerning on 2017/3/22.
//  Copyright © 2017年 BN. All rights reserved.
//

#import "NSMutableArray+BN.h"
#import <objc/runtime.h>

@implementation NSMutableArray (BN)

+(void)load
{
    Method md1=class_getInstanceMethod(self, @selector(addObject:));
    Method md2=class_getInstanceMethod(self, @selector(bn_AddObject:));
    
    method_exchangeImplementations(md1, md2);
}

-(void)bn_AddObject:(id)object
{
    
    NSLog(@"bn_AddObject");
//    if([object isKindOfClass:[NSString class]])
//    {
//        [(NSString *)object stringByAppendingString:@"/runtime"];
//    }
    
}


//oc ->c __bridge
//c ->oc __transfer

const double dogKey;

-(void)setDog:(NSString *)dog
{
    objc_setAssociatedObject(self,&dogKey,dog, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

-(NSString *)dog
{
    return  (NSString *)objc_getAssociatedObject(self,&dogKey);
}


static double HeightKey;

- (void)setHeight:(double)height
{
    objc_setAssociatedObject(self, &HeightKey, @(height), OBJC_ASSOCIATION_ASSIGN);
}

- (double)height
{
    return [objc_getAssociatedObject(self, &HeightKey) doubleValue];
}



@end
