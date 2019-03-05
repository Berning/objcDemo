//
//  NSMutableArray+properties.m
//  runtime
//
//  Created by Berning on 2018/10/8.
//  Copyright © 2018年 BN. All rights reserved.
//

#import "NSMutableArray+properties.h"
#import <objc/runtime.h>
@implementation NSMutableArray (properties)

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
