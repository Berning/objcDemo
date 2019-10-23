//
//  bnPerson.m
//  obcjDemo
//
//  Created by Berning on 2018/10/7.
//  Copyright © 2018年 BN. All rights reserved.
//
#if !__has_feature(objc_arc)

#import "bnPerson.h"

@implementation bnPerson

-(void)dealloc
{
    NSLog(@"pre:%@",[self class]);
//    self.delegate=nil;

    [super dealloc];
    NSLog(@"suf:%@",[self class]);
}
@end

#endif
